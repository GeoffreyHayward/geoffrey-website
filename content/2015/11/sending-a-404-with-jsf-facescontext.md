---
title: "Sending a 404 with JSF's FacesContext"
author: "Geoffrey Hayward"
date: 2015-12-08T11:00:00Z
categories:
- computing
tags:
- Java Tip
- JSF
- Response Codes
---
Sending a 404 "page not found" response with JSF is easily achieved. In the example below a 404 "page not found" is sent back to the requester if a search on a primary key does not yield a result.

<!--more-->

```java
public Post findPost(Long id) throws IOException {
    Post post =em.find(Post.class, id);
    if (post == null) {
        FacesContext.getCurrentInstance().getExternalContext().responseSendError(HttpServletResponse.SC_NOT_FOUND, "Page not found");
        FacesContext.getCurrentInstance().responseComplete();
    }
    return post;
}
```
    
As can be seen from the example: to send a 404 "page not found" response with JSF you need to get the external context via the 'FacesContext' object. Then using the external context, of the JSF, set the response code. In this case the response code is an error. Finally, It's important to complete the response to halt server side processing.
