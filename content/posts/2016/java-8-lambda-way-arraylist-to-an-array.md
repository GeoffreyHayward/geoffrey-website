---
title: "The Java 8 Lambda way: ArrayList to an Array"
author: "Geoffrey Hayward"
date: 2016-07-15T11:00:00Z
categories:
- computing
tags:
- Java SE
- Lambda
- Stream API
---
In an earlier post this year, [Convert an ArrayList to an Array in Java](/posts/2016/from-arraylist-to-array-java/), I 
wrote about a way to convert an ArrayList to an Array in Java. Here is the example code from the earlier post.

<!--more-->

```java
List<String> results = new ArrayList<>();
...
results.toArray(new String[results.size()]);
```

This earlier way works fine, however it's old school. Here is the Java 8 Lambda way to convert an ArrayList to an Array:

```java
Long[] longArray = longArrayList.stream()
    .map(Long::new)
    .toArray(Long[]::new);
```
    
This example works by mapping a new object for each item in the ArrayList's stream to the new stream, and then collecting 
that stream as an array.
