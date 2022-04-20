---
title: "Convert an ArrayList to an Array in Java"
author: "Geoffrey Hayward"
date: 2016-02-25T11:00:00Z
categories:
- computing
tags:
- Array
- ArrayList
- Java Tip
---
A colleague ask me how to convert an ArrayList to an Array in Java. Here was my answer:

<!--more-->

```java
List<String> results = new ArrayList<>();
...
results.toArray(new String[results.size()]);
```

Hope it's helpful. If you know of anymore ways to convert an ArrayList to an Array in Java, leave a comment.

**Update:** [The Java 8 Lambda way: ArrayList to an Array](/posts/2016/07/java-8-lambda-way-arraylist-to-an-array/)
