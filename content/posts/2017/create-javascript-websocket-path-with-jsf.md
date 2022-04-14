---
title: "Create a JavaScript WebSocket path with JSF"
author: "Geoffrey Hayward"
date: 2017-01-16T11:00:00Z
categories:
- computing
tags:
- JavaScript
- JSF
- WebSocket
---
Here is how you can create a WebSockets base path for your JavaScript with JSF. This WebSocket base path points back to your deployed application's WAR context address.

<!--more-->

```html
<script type="text/javascript">
    var base="#{request.scheme.endsWith("s") ? "wss" : "ws" }://#{request.serverName}:#{request.serverPort}#{request.contextPath}";
</script>
```

I hope this helps.