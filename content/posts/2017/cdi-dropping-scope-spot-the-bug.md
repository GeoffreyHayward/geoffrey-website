---
title: "CDI Dropping Scope: Spot the Bug?"
author: "Geoffrey Hayward"
date: 2017-03-22T11:00:00Z
categories:
- computing
tags:
- CDI
- Java EE
- JSF
- SessionScoped
- ViewScoped
---
It took me a while to get to the bottom of why CDI seemed to be dropping `@ViewScoped` and `@SessionScoped` beans. `@RequestScope` was not behaving properly ether.

<!--more-->

It took a lot of digging in the application's codebase and a lot of watching the Debugger before narrowing down the course. Anyway here is the culprit; can you spot the bug?

```xml
<h:link outcome="#{navbar.logout()}" >Logout</h:link>
```

That is from an extract of a composite component that is used on every page of the application. Hence, CDI seemed to be dropping scope.

```java
@Named(value = "navbar")
@ApplicationScoped
public class Navbar implements Serializable {
	
    @Inject
    private HttpServletRequest request;

    public String logout() {
        request.getSession(false).invalidate();
        return "/index?faces-redirect=true";
    }

}
```

I hope you enjoyed this issue more than I did.
