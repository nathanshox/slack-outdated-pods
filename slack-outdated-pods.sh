#!/bin/bash -l
export LANG=en_US.UTF-8

PROJECT="YOUR_PROJECT"
CHANNEL="#YOUR_SLACK_CHANNEL"
SLACK_WEBHOOK_URL="YOUR_SLACK_WEBHOOK_URL"

pod install

# Step 1: Get all the outdated pods
OUTPUT=$(pod outdated | sed -ne '/^The following pod updates are available:$/{s///; :a' -e 'n;p;ba' -e '}')

echo $(pod outdated)

# Step 2: Save to a file so Sed can work on in place
echo "${OUTPUT}" > outdated.txt

# Step 3: Remove the first two characters '- ' on each line
sed -i '' 's/..//' outdated.txt

# Step 4: Remove everything after the first word, so all we are left with are the pod names
sed -i '' 's/ .*//' outdated.txt

# Step 5: We need to remove newlines because it's causing invalid JSON when sending to Slack
LIST=$(tr '\n' ' ' < outdated.txt)

echo $LIST

curl --verbose -X POST -d '{
    "channel": "'"$CHANNEL"'",
    "username": "CocoaPods Bot",
    "icon_emoji": ":scream:",
    "color": "#FF0000",
    "text": "'"The following CocoaPods are out of date in *${PROJECT}* and need to be updated:\n\n ${LIST}"'"
}' -H "Content-Type: application/json" $SLACK_WEBHOOK_URL
