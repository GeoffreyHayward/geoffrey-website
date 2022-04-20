---
title: "Java JUnit: Reset a Singleton"
author: "Geoffrey Hayward"
date: 2018-02-28T11:00:00Z
categories:
- computing
tags:
- Java SE
- JUnit
- Singleton
---
Java singleton's are hard to unit test because the state of the singleton is altered as each test runs. But for testing sake you can reset the singleton's state use reflection. Here is an example that worked for me.</p>

<!--more-->

```java
@Before
public void setup() throws NoSuchFieldException, IllegalAccessException {
        Field instance = RemoteMessageTranslation.class.getDeclaredField("set");
        instance.setAccessible(true);
        instance.setBoolean(null, false);
}
```

I hope this helps.
