---
title: "Struggling to Configure the WildFly Logging Subsystem"
author: "Geoffrey Hayward"
date: 2016-01-20T11:00:00Z
categories:
- computing
tags:
- Java EE
- Jetty
- Log4j
- Logging
- WildFly
---
I have been struggling to configure the Java EE WildFly application server's Logging subsystem. I was finding that any changes to the configuration within domain.xml where not making any difference to what was or was not actually being logged. I finally got to the bottom of the issue.

<!--more-->

The project, I am working on, used to run with embedded Jetty. This means some old configuration files have hung around erroneously. The old configuration files should have been deleted - but never was.

What I have learnt: WildFly's Logging subsystem uses deployment level configuration over container level configuration **by default**. That means old Log4j configuration files were being read by WildFly. Once I removed the old Log4j configuration files WildFly began logging as expected.

I have found out that any of the file names in the following list [^1] will be read as deployment level configuration by WildFly.

* logging.properties
* jboss-logging.properties
* log4j.properties
* log4j.xml
* jboss-log4j.xml

Hope this helps.

[^1]: Ritchie, C. 2014. WildFly Configuration, Deployment, and Administration (Second Edition), Packt Publishing, p 56.
