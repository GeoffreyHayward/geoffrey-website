---
title: "Download with PowerShell"
author: "Geoffrey Hayward"
date: 2017-03-15T11:00:00Z
categories:
- computing
tags:
- DevOps
- PowerShell
---
You can download files with PowerShell using [Start-Bitstransfer](https://technet.microsoft.com/en-us/library/dd819420.aspx).

<!--more-->

```powershell
$credential = Get-Credential
Start-BitsTransfer -Source http://deployments.example.com:8888/release/amazing-application-1.0.0.exe -Destination .\amazing-application-1.0.0.exe  -Credential $credential -Authentication basic
```

You can leave out authentication if the web server does not require credentials.

I hope this helps.
