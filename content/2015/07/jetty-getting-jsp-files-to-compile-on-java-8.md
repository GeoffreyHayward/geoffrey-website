---
title: "Jetty: getting JSP's to compile on Java 8"
author: "Geoffrey Hayward"
date: 2015-07-25T11:00:00Z
categories:
- computing
tags:
- Java 8
- Java Tip
- Jetty
- JSP
- Maven
---
I have been trying to put an older embedded Jetty served application onto Java 8. The application's JSP files where, however, not compiling. This delayed having the benefits Java 8 brings to development.

<!--more-->

After a lot of digging I discovered that the Mavan `org.mortbay.jetty` namespace (a.k.a. groupid) had been superseded by `org.eclipse.jetty`. The newer development and fixes by the Jetty project are in the later namespace. Therefore, by replacing the old `org.mortbay.jetty` dependency:

```xml
<dependency>
    <groupId>org.mortbay.jetty</groupId>
    <artifactId>jsp-2.1-glassfish</artifactId>
  <version>9.1.02.B04.p0</version>
</dependency>
```

with the new `org.eclipse.jetty` dependency:

```xml
<dependency>
  <groupId>org.eclipse.jetty</groupId>
    <artifactId>jetty-jsp</artifactId>
  <version>9.3.0.M1</version>
</dependency>
```

The JSP's compile and the older project now works with Java 8.
