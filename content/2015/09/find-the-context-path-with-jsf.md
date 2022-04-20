---
title: "Find the Application Context Path with JSF"
author: "Geoffrey Hayward"
date: 2015-09-22T11:00:00Z
categories:
- computing
tags:
- JSF
- JSP
---
Sometimes JSF does not have a component that will produce a particular type of HTML element. That's not a problem but, I always forget the three method deep route to the context path. I always find I have to work through an IDE's code completion tool to find the application's path.

<!--more-->

Here it is for next time:

```text
#{facesContext.externalContext.requestContextPath}
```

A shorter version:

```text
#{request.contextPath}
```

Just for completeness here is the JSP version:

```text
${pageContext.request.contextPath}
```

And finaly, the scriptlet version:

```text
<%
    String root = pageContext.getRequest().getServletContext().getContextPath();
%>
```

If you know any more please do leave a comment.