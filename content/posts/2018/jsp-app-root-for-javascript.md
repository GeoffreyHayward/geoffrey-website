---
title: "JSP: Embed the Application Root for JavaScript"
author: "Geoffrey Hayward"
date: 2018-05-02T11:00:00Z
categories:
- Computing
tags:
- Ajax
- HTTPS
- JSP
---
There are several ways to embed the root of a deployed application into a JSP page for JavaScript to phone home with. However in some server environments some methods work better than others. This short post explains the problem that load balancing can course to the Request object and gives a simple workaround for finding the application's root from its JavaScript.

<!--more-->

The most common suggestion for embedding an application's seems to be the following. However, the following does not work when a load balancer forwards HTTPS request to the application's server via HTTP (a.k.a. SSL Off Loading).

```javascript
function root() { // Bad example
       return "${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";}";
}
```


When the application server receives a proxied request via HTTP the JSP will embed the HTTP scheme along with the application server's configured HTTP port.

The simple workaround is to ask JavaScript for its origin and append only the context path from the JSP. Here is a working example:

```javascript
function root() { // Good example
       return window.location.origin + "${pageContext.request.contextPath}";
}
```

Hope this helps.
