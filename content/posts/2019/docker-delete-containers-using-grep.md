---
title: "Docker: Delete Containers and Images Using GREP"
author: "Geoffrey Hayward"
date: 2018-04-20T11:00:00Z
categories:
- computing
tags:
- AWK
- Docker
- GREP
---
Here is a handy way of deleting Docker containers using GREP.

<!--more-->

```text
docker rm -f $(docker ps | grep <grep term> | awk ‘{print $1}’)
```

And here is a handy way of deleting Docker images using GREP.

```text
docker rmi -f $(docker images | grep <grep term> | awk ‘{print $3}’)
```

