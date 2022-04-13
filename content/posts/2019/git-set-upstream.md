---
title: "Git: Set Upstream of a New Branch on First Push"
author: "Geoffrey Hayward"
date: 2019-04-29T11:00:00Z
categories:
- computing
tags:
- Git
- GREP
---
The first push of a new Git branch, when given as `git push` will remind you to set the upstream.

<!--more-->

The following command will capture that reminder and then run it.

```text
$(git push 2&gt;&amp;1 | grep &quot;git push&quot;)
```
