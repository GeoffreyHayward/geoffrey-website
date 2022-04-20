---
title: "Java WSDL Import Without the .class Files"
author: "Geoffrey Hayward"
date: 2016-05-03T11:00:00Z
categories:
- computing
tags:
- Java SE
- Java Tip
- SOAP
---
It is easy to generate a SOAP client from a WSDL with Java. Java comes with the tool named 'wsimport'. The wsimport tool is part of the Java JDK, found in the JDK bin folder. By default when you run the tool it will create and keep the compiled .class files. If you do not need the .class files just add `-Xnocompile` to the command.

```text
wsimport http://localhost:8080/demo?wsdl -Xnocompile
```
