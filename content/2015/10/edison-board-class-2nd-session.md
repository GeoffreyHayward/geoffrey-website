---
title: "Edison Board Class (2nd Session)"
author: "Geoffrey Hayward"
date: 2015-10-26T11:00:00Z
categories:
- computing
tags:
- Edison
---
In last week's 2nd session of the Edison board class a lot of the time was spent making sure everyone was set-up ready to start making stuff. We were also introduced to the Grove Starter Kit Plus for the Intel IoT Edison Board.

<!--more-->

The Grove Starter Kit Plus for the Edison Board is an interesting collection of sensors. The box includes many sensors, many LEDs, a buzzer, the base shield for Arduino and a stepper motor. Here is the full list of what's in the box:

* Base Shield v2
* Grove LCD RGB Backlight
* Grove Buzzer
* Grove Sound Sensor
* Grove Touch Sensor
* Grove Temperature
* Grove Light Sensor
* Grove Rotary Angle Sensor
* Grove Button
* Grove LED Socket with 3mm Red LED
* Grove LED Socket with 3mm Green LED
* Grove LED Socket with 3mm Blue LED
* Grove 3-Axis Digital Accelerometer(±1.5g)
* Grove Piezo Vibration Sensor
* micro-USB cable

Our homework; get something working with the starter kit. I thought I would have a play with the LCD RGB backlight screen and the temperature sensor. This is what I made:

<p><img src="../../../static.geoffhayward.eu/images/temperature.html" class="img-responsive" alt=" Edison Board with the Grove Starter Kit set up to show the temperature on the screen." />

The code that I wrote for this is:

```javascript
var jsUpmI2cLcd  = require ('jsupm_i2clcd');
var groveSensor = require('jsupm_grove');

var lcd = new jsUpmI2cLcd.Jhd1313m1(6, 0x3E, 0x62); // Initialize the LCD
var temp = new groveSensor.GroveTemp(0);
 
function doTemperature(){
    var value = temp.value();
    doPrint(value);
    doColour(value);
}

function doPrint(value){
    lcd.clear();
    lcd.setCursor(0,0); 
    lcd.write("Temperature");
    lcd.setCursor(1,0);
    lcd.write(value.toPrecision(2) + "C");
}

function doColour(value){
    if(value <= 17){
           lcd.setColor(0, 0, 250);    
    }
    if(value > 17 && value < 25){
           lcd.setColor(0, 225, 0);    
    }
    if(value >= 25){
           lcd.setColor(225, 0, 0);    
    }
}

lcd.setCursor(0,0); 
lcd.write("Loading");
setInterval( doTemperature, 3000);
```

I found the [Seeed Wiki](https://wiki.seeedstudio.com/) to be a very good resource for getting going with the sensor and LED RBG screen.</p>
<p>That's it for this week. The next session is tomorrow. I will have an update soon.</p>
