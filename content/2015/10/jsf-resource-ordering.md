---
title: "JSF Resource Ordering"
author: "Geoffrey Hayward"
date: 2015-10-08T11:00:00Z
categories:
- computing
tags:
- JSF
- OmniFaces
---
JSF's `h:outputStylesheet` and `h:outputScript` elements have an odd way of ordering linked resources. For example if you do not set the `target` element of an `h:outputScript` to body the JavaScript is output before the CSS. This is irrespective of the order given in a template.

<!--more-->

I needed to put an `<!--[if lte IE 7]> [...] <![endif]-->` element into a template. OmniFaces' `o:conditionalComment` is a great element for this; but the `<!--[if lte IE 7]> [...] <![endif]-->` condition was being output before the main CSS.

To fix this resource loading problem use a plain old HTML `link` elements instead of JSF `h:outputStylesheet` elements. Use this element with the HTML `link` elements having `#{resource['libs:reset.css']}` as there href.

```xml
<link rel="stylesheet" href="#{resource['libs:reset.css']}" />
<link rel="stylesheet" href="#{resource['css:login.css']}" />
<o:conditionalComment if="lte IE 7" >
     <link rel="stylesheet" href="#{resource['css:login-ie7.css']}" />
</o:conditionalComment>
```

Will then output:

```xml
<link rel="stylesheet" href="/javax.faces.resource/reset.css?ln=libs" />
<link rel="stylesheet" href="/javax.faces.resource/login.css?ln=css" />
<!--[if lte IE 7]>
     <link rel="stylesheet" href="/javax.faces.resource/login-ie7.css?ln=css" />
<![endif]-->
```

Which is the desired resource ordering.
