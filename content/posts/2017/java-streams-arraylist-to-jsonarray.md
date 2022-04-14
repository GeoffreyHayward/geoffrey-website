---
title: "Java Stream API: ArrayList to JsonArray"
author: "Geoffrey Hayward"
date: 2017-01-03T11:00:00Z
categories:
- computing
tags:
- Java EE
- JSON
- JsonArray
- JsonObject
- Stream API
---
You can convert an ArrayList to a Java EE JsonArray using the Java Stream API in the following way.

<!--more-->

```java
// the example set up
ArrayList<Pet> pets = new ArrayList<>();
pets.add(new Pet("Goldie", "Fish"));
pets.add(new Pet("Daisy", "Cow"));
pets.add(new Pet("Snowball", "Cat"));

// the work
pets.stream()
	.map((a) -> { 
		return Json.createObjectBuilder()
			.add("id", a.getName())
			.add("type", a.getGroup())
			.build();
	})
	.collect(
		Json::createArrayBuilder,
		JsonArrayBuilder::add,
		JsonArrayBuilder::add
	)
	.build();
```
	
The `.map` operation of the stream API takes a `Function<T,R>`. The function converts each item to a JsonObject. Then the `.collect` operation creates the JsonArray using each of the JsonObjects.

I hope you find this useful.
