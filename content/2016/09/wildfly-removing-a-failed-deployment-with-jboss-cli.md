---
title: "WildFly: Removing a Failed Deployment with JBoss CLI"
author: "Geoffrey Hayward"
date: 2016-09-05T11:00:00Z
categories:
- computing
tags:
- JBoss CLI
- WildFly
---
I was having trouble working out how to remove the WAR file of a failed deployment from WildFly using the JBoss CLI. I found that I could not simply type `undeploy <WAR name>` to remove a failed deployment from WildFly using the JBoss CLI. However, I did find that the following command let me remove a failed deployment and it's WAR file.

<!--more-->

```text
/deployment=<WAR name>:remove
```

After running this command I checked that the failed deployment and it's WAR file had been removed by running `deployment-into` and then by looking in the WildFly deployment's folder on the disc. This command had successfully removed the deployment and it's WAR file.
