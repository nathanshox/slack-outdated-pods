# slack-outdated-pods

A simple script you can use in your build system to remind your team via Slack that there are updates available to CocoaPods you are using in your project.

---

1) Set your project name, slack channel, and slack webhook url at the top of `slack-outdated-pods.sh`

```
PROJECT="YOUR_PROJECT"
CHANNEL="#YOUR_SLACK_CHANNEL"
SLACK_WEBHOOK_URL="YOUR_SLACK_WEBHOOK_URL"
```

2) Set the script to run regularly on your build system

For instance, for every Monday at 10am on Jenkins, set the Poll SCM schedule to the following.

```
H 10 * * 1
```

3) Keep your pods updated! ✅

---

![Sample Output](http://i.imgur.com/vAh8xi8.png)
