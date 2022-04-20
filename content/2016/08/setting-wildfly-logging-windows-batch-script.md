---
title: "Setting WildFly's Logging Level with Windows Batch Script"
author: "Geoffrey Hayward"
date: 2016-08-05T11:00:00Z
categories:
- computing
tags:
- Batch Script
- CMD
- DevOps
- Java EE
- JBoss CLI
- Logging
- WildFly
---
I would like to share a simple Windows Batch script that I made. The Batch script changes the WildFly's logging level quickly and easily. It is as easy as running `change-logging-level.cmd --file-debug --console-error`.

<!--more-->

**change-logging-level.cmd**

```text
:: Name:     change-logging-level.cmd
:: Purpose:  Set's the logging level to very low or the setting given as an argument
:: Author:   geoffhayward.eu
:: Revision: August 2016 - initial version
@ECHO OFF

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

SET NOPAUSE=true
SET ME=%~n0
SET SCRIPT=%TEMP%\%ME%-%DATE:/=-%.txt
SET CON_LEVEL=ERROR
SET FILE_LEVEL=ERROR

:parse_args
IF NOT "%~1"=="" (
		IF "%~1"=="--all" (
		SET CON_LEVEL=ALL
		SET FILE_LEVEL=ALL
	)
	IF "%~1"=="--console-all" (
		SET CON_LEVEL=ALL
	)
	IF "%~1"=="--file-all" (
		SET FILE_LEVEL=ALL
	)
	IF "%~1"=="--config" (
		SET CON_LEVEL=CONFIG
		SET FILE_LEVEL=CONFIG
	)
	IF "%~1"=="--console-config" (
		SET CON_LEVEL=CONFIG
	)
	IF "%~1"=="--file-config" (
		SET FILE_LEVEL=CONFIG
	)
	IF "%~1"=="--debug" (
		SET CON_LEVEL=DEBUG
		SET FILE_LEVEL=DEBUG
	)
	IF "%~1"=="--console-debug" (
		SET CON_LEVEL=DEBUG
	)
	IF "%~1"=="--file-debug" (
		SET FILE_LEVEL=DEBUG
	)
	IF "%~1"=="--error" (
		SET CON_LEVEL=ERROR
		SET FILE_LEVEL=ERROR
	)
	IF "%~1"=="--console-error" (
		SET CON_LEVEL=ERROR
	)
	IF "%~1"=="--file-error" (
		SET FILE_LEVEL=ERROR
	)
	IF "%~1"=="--fatal" (
		SET CON_LEVEL=FATAL
		SET FILE_LEVEL=FATAL
	)
	IF "%~1"=="--console-fatal" (
		SET CON_LEVEL=FATAL
	)
	IF "%~1"=="--file-fatal" (
		SET FILE_LEVEL=FATAL
	)
	IF "%~1"=="--fine" (
		SET CON_LEVEL=FINE
		SET FILE_LEVEL=FINE
	)
	IF "%~1"=="--console-fine" (
		SET CON_LEVEL=FINE
	)
	IF "%~1"=="--file-fine" (
		SET FILE_LEVEL=FINE
	)
	IF "%~1"=="--finer" (
		SET CON_LEVEL=FINER
		SET FILE_LEVEL=FINER
	)
	IF "%~1"=="--console-finer" (
		SET CON_LEVEL=FINER
	)
	IF "%~1"=="--file-finer" (
		SET FILE_LEVEL=FINER
	)
	IF "%~1"=="--finest" (
		SET CON_LEVEL=FINEST
		SET FILE_LEVEL=FINEST
	)
	IF "%~1"=="--console-finest" (
		SET CON_LEVEL=FINEST
	)
	IF "%~1"=="--file-finest" (
		SET FILE_LEVEL=FINEST
	)
	IF "%~1"=="--info" (
		SET CON_LEVEL=INFO
		SET FILE_LEVEL=INFO
	)
	IF "%~1"=="--console-info" (
		SET CON_LEVEL=INFO
	)
	IF "%~1"=="--file-info" (
		SET FILE_LEVEL=INFO
	)
	IF "%~1"=="--off" (
		SET CON_LEVEL=OFF
		SET FILE_LEVEL=OFF
	)
	IF "%~1"=="--console-off" (
		SET CON_LEVEL=OFF
	)
	IF "%~1"=="--file-off" (
		SET FILE_LEVEL=OFF
	)
	IF "%~1"=="--trace" (
		SET CON_LEVEL=TRACE
		SET FILE_LEVEL=TRACE
	)
	IF "%~1"=="--console-trace" (
		SET CON_LEVEL=TRACE
	)
	IF "%~1"=="--file-trace" (
		SET FILE_LEVEL=TRACE
	)
	IF "%~1"=="--warn" (
		SET CON_LEVEL=WARN
		SET FILE_LEVEL=WARN
	)
	IF "%~1"=="--console-warn" (
		SET CON_LEVEL=WARN
	)
	IF "%~1"=="--file-warn" (
		SET FILE_LEVEL=WARN
	)
	IF "%~1"=="--warning" (
		SET CON_LEVEL=WARNING
		SET FILE_LEVEL=WARNING
	)
	IF "%~1"=="--console-warning" (
		SET CON_LEVEL=WARNING
	)
	IF "%~1"=="--file-warning" (
		SET FILE_LEVEL=WARNING
	)
	SHIFT
	GOTO :parse_args
)


ECHO batch > %SCRIPT%
ECHO /subsystem=logging/console-handler=CONSOLE:change-log-level(level=%CON_LEVEL%)>> %SCRIPT%
ECHO /subsystem=logging/periodic-rotating-file-handler=FILE:change-log-level(level=%CON_LEVEL%)>> %SCRIPT%
ECHO run-batch >> %SCRIPT%

 
CALL %JBOSS_HOME%\bin\jboss-cli.bat -c --file="%TEMP%\%ME%-%DATE:/=-%.txt"

ENDLOCAL
```

This version of the Batch script is designed for Windows based dev environments, with WildFly as the target dev Java EE application container. The Batch script creates a simple JBoss CLI script and then sends that script into JBoss CLI. Note `%JBOSS_HOME%` needs to be set as an environment variable.

Calling this 'change-logging-level.cmd' script without any arguments will set WildFly's logging level down to 'ERROR' for both the console and file logging. Supplying arguments will override the default, for example `change-logging-level.cmd --fine` will immediately (except long running transactions), set all logging to 'fine'.