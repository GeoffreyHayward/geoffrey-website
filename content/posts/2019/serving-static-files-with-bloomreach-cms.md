---
title: "Serving Static Files With Bloomreach CMS"
author: "Geoffrey Hayward"
date: 2019-06-19T11:00:00Z
categories:
- computing
tags:
- Bloomreach CMS
- Hippo CMS
---
Serving a static file with Bloomreach (formally known as Hippo CMS), such as `BingVerify.xml`, is not as simple as dropping it in the webapp folder. However, with a little extra configuration Bloomreach CMS will serve the file.</p>

<!--more-->

First add the static file in webapp. In my case example <code>site/src/main/webapp/BingSiteAuth.xml</code>. Then update <code>hts:default</code> in sitemap.ymal akin to the following.</p>

```yaml
/hst:hst/hst:configurations/hst:default/hst:sitemap:
 /BingSiteAuth.xml:
   hst:authenticated: false
   hst:containerresource: true
   jcr:primaryType: hst:sitemapitem
```

After rebuilding the project, the static file BingSiteAuth.xml will be served by Bloomreach CMS.</p>
