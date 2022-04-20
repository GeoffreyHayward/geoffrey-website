---
title: "Edison Board Class (3rd Session)"
author: "Geoffrey Hayward"
date: 2015-11-03T11:00:00Z
categories:
- computing
tags:
- BlueMix
- Edison
---
This week's post is short; I ran out of time before the next session.

<!--more-->

At last week's session we where given a 5 minute challenge. The challenge was to make an LED light up when a button is pressed down. Here is the outcome of the 5 minute challenge.

{{< youtube zIqr-rH6Ly4 >}}

And here is the code I came up with during the challenge.

```javascript
var groveSensor = require('jsupm_grove');

var button = new groveSensor.GroveButton(5); 
var led = new groveSensor.GroveLed(2); 

function doLight(){         
    led.write(button.value());           
}

setInterval(doLight,300);
```

As you can see the button is plugged into D5 of the Seeed Base Shield. And the LED is plugged into D2. 'D' for digital.

In tonight's session we are going to be shown how to send data up to IBM's BlueMix. It going to be fun.
