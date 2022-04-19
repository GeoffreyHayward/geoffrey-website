---
title: "Ready for the FabLab Edison Hackathon"
author: "Geoffrey Hayward"
date: 2015-11-24T11:00:00Z
categories:
- computing
tags:
- Edison
- FabLab
- Java SE
- JavaFX 8
- Watson
---
During this coming Thursday's Edison Hackathon, at the FabLab, I am hoping to control a robot car by voice. In preparation I have made a JavaFX voice controller UI. And I have put together a 4-wheel drive robot car chassis kit.

<!--more-->

The voice controller uses the IBM Watson Speech to Text service. Since recording the video below I have tried commands with context such as "turn left", "reverse the car ". This has had better results. Using phrases, I added regex (word matching) to pull out the commanding verb from the phrase. The commands are then sent as HTTP GET request to whatever IP address and port is given. The Edison will be on the car processing the GET requests via WIFI and acting upon them.

{{< youtube aXDBYfPljN0 >}}


The video below is the running 4-wheel drive robot car chassis kit. To get it working I used an Arduino. I will, of course, swap the Arduino for the Edison before Thursday. The motors are powered by battery, I think the Edison will still be powered by mains (but I am going to seek advice on the day).

{{< youtube f5UgWvg-W4w >}}

As you can see I am all set ready for the FabLab Edison Hackathon: very excited.
