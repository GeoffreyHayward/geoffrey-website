---
title: "Helper Script: MongoDB as a Windows Service"
author: "Geoffrey Hayward"
date: 2016-10-24T11:00:00Z
categories:
- computing
tags:
- CMD
- DevOps
- MongoDB
---
I would like to share a Windows CMD script for adding MongoDB to a development environment. If you do development work that includes MongoDB on a Windows' PC then you should find this script helpful.

<!--more-->

The script is designed to be used in application development environments as opposed to production. After MongoDB has been installed using the MongoDB installer this CMD script creates the MongoDB data folder and the log folder; it then adds MongoDB as a Windows Service using mongod by MongoDB. And then to save you from going into the Windows Service Tool script the script starts the MongoDB service for you. After you have run the script MongoDB will start each time your PC starts.

Note you will need to run this script as an administrator. This script assumed that the MongoDB installer added MongoDB's bin to the path during its install.

**add-mongo-as-service.cmd**

```text
:: Name:     add-mongo-as-service.cmd
:: Purpose:  Adds MongoDB as a service to a Windows application development environment.
:: Note:     Run this script as an administrator.
:: Author:   www.geoffhayward.eu
:: Revision: Oct 2016 - initial version
@ECHO OFF

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

SET ME=%~n0
set MY_DIR=%~dp0

IF NOT EXIST "%USERPROFILE%\Mongo\" MKDIR "%USERPROFILE%\Mongo\"
IF NOT EXIST "%USERPROFILE%\Mongo\data\" MKDIR "%USERPROFILE%\Mongo\data\"
IF NOT EXIST "%USERPROFILE%\Mongo\logs\" MKDIR "%USERPROFILE%\Mongo\logs\"

CALL mongod --dbpath "%USERPROFILE%\Mongo\data" --logpath "%USERPROFILE%\Mongo\logs\log.txt" --install

CALL NET START MongoDB

ENDLOCAL
```

Add this script to your source control and then enjoy a more productive way of quickly setting up your environment.
