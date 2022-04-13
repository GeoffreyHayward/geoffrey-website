---
title: "Java Regex Pattern Within a String"
author: "Geoffrey Hayward"
date: 2018-02-01T11:00:00Z
categories:
- computing
tags:
- Java SE
- Regular Expression
---
Using Java, here is how to find a regex pattern within a string.

<!--more-->

```java
@Test
public void stringContainsRegexPattern() {
	assertTrue(Pattern.compile("pattern(?:\\s[a-z]+){2}\\setc\\.").matcher("Here is the pattern and that etc.").find());
}
```