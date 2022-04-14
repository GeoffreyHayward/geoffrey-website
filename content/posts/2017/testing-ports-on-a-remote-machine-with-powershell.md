---
title: "Testing Ports on a Remote Machine with PowerShell"
author: "Geoffrey Hayward"
date: 2017-03-14T11:00:00Z
categories:
- computing
tags:
- PowerShell
---
If you do not wish to enable TelNet just to test ports on a remote machine then PowerShell has a solution. PowerShell comes with [Test-NetConnection](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.2), which gives detailed information about a connection.

<!--more-->

**Example of using Test-NetConnection**

```powershell
Test-NetConnection www.geoffhayward.eu -Port 443 -InformationLevel "Detailed"
```

I hope this helps.
