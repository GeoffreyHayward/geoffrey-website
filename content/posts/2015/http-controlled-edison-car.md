---
title: "Make your own HTTP Controlled Edison Car"
author: "Geoffrey Hayward"
date: 2015-12-15T11:00:00Z
categories:
- computing
tags:
- Arduino
- Edison
- FabLab
- JavaFX 8
- Node-RED
- Robotics
---
In this post I will describe how you can make a 4 wheel drive robot car that can be controlled by HTTP GET requests. HTTP GET requests are what you use to request web pages. The types of requests will be 'stop', 'forward', 'left', etc..

<!--more-->

This post outlines how to make the car itself. You can send HTTP GET request via any web browser using the browser's address bar. Or, you can even make a simple web page if you like. I will be keen to hear about the controllers you make.

I made the car for the local FabLab Edison and BlueMix Hackathon. During the Hackathon the car's controller I made was with JavaFX and is a voice controller. The voice controller uses BlueMix's Watson voice-to-text service. The car controller I made is outside the scope of this post. But you can see it in action in the video bellow.

{{< youtube dXUc_4tSbTI >}}

## To Build the Robot Car You Will Need

* An Intel® Edison Kit for Arduino
* [A 4-wheel Robot Car Chassis Kits for Arduino](https://www.amazon.co.uk/gp/product/B00GSIRHEU)
* 2 x L298N H-bridges
* Grove Starter Kit Plus - Intel IoT Edition (Optional)
* Solder and Soldering Iron
* Wire cutters
* Long nose pliers
* 9 volt battery
* 9 volt battery connectors
* 8 AA batteries
* An additional 4 AA battery holder
* Wifi access
* A mix of Male to Female, Male to Male and Female to Female Jumper Cables

# Step 1 Build the Car Kit

​The Car Kit will arrive in a bag. The bag contains 4 wheels, 8 wires (4 red and 4 black), 4 motors, the chassis, and the fittings. The instructions that I received were in Chinese (I assume Chinese). I cannot read Chinese, but the diagrams on the instructions were very easy to follow.

Begin by stripping the paper off of the chassis.This took me about 20 minutes to do as it was quite fiddly.

Next attach the motors using the fixings that are provided in the kit. Then attach the wheels to the motor shafts. Attaching the motors did not take very long, there are 2 bolts per motor.

Slide a wheel onto the shaft of each of the motors.

Once the motors are attached, you can solder the wires to the motors (1 black negative wire and 1 red positive wire per motor).

Before fitting the top of the chassis; fit the h-bridges (Step 2). Once the h-bridges are fitted and wired up you can fit the top of the chassis.

## Step 2 Attach the H-bridges

The h-bridges are not supplied in the car chassis kit; they have to be purchased separately.

First you will need to wire the 4 motors to the 2 L298N H-bridges, one motor per h-bridge output A & B respectively.

Then for each L298N H-bridges connect one 4 AA battery holder. Connect the positive wire from the battery holder to the 5+ vault h-bridge in. As well as connecting the battery holder's negative wire to the h-bridge's ground you will need a second ground wire. The second ground wire will take a common ground out from the Edison's breakout board.

I found the following video from LessonStudio to be very helpful (this car, we are making, does not use pulse width modulation - leave the jumpers in place):

{{< youtube kv-9mxVaVzE >}}

## Step 3 Set up the Edison

First Connect your Edison to your PC. If you have not connected your Edison to a PC before, I recommend watching this 'step-by-step guide to windows' by Carlos Montesionos.

{{< youtube lDKM7UKUL5A >}}

Next connect your Edison to your local WiFi (if you haven't already). The WiFi will let you send commands to the car wireless. SSH into the Edison and run `configure_edison --wifi`; then follow the prompt. If you get stuck, I can recommend [Connecting your Intel Edison board using Wi-Fi](https://software.intel.com/en-us/connecting-your-intel-edison-board-using-wifi) by Intel (the Edison's maker).

Next add Node-RED to the Edison. Node-RED will give you the functionality to receive the boundary HTTP GET requests. Node-RED can then take these requests to signal to the h-bridges to drive the motors. In other words Node-RED will manage the car's business logic.

To set-up Node-RED, SSH into the Edison and issues the following commands:

```text
npm install -g --unsafe-perm node-red 
npm install -g --unsafe-perm pm2
npm install node-red-node-intel-gpio 
pm2 start /usr/bin/node-red --node-args="--max-old-space-size=256"
pm2 save
pm2 startup
```

## Step 4 Wire the Edison to the Car

Once you have wired the car's power and h-bridges and set up the Edison, it's time to attach the Edison to the car. The Edison Arduino breakout board comes with legs. I attached the legs so that the breakout board stands over the top of the 4 AA battery holders.

Begin by wiring jumper cables from the Edison Arduino breakout board's digital outs to the h-bridge's ins. There are 2 jumper cables per motor. This means you will need to use 8 digital outputs in total.

Next, from each h-bridge take the common ground and wire it into one of the spare grounds on the Edison Arduino breakout board. The grounds are marked 'GND'. An Edison Arduino breakout board has 3 grounds available.

Connect the 9 volt battery once you have programmed Node-RED. In the meantime, power the Edison Arduino breakout board from the mains. I found the 9 volt battery only lasted 3-4 hours before the Edison could no longer boot.

## Step 5 Program Node-RED to Handle the HTTP requests

Begin by navigation to Node-RED. Node-RED has a web browser based user interface. You may find the following address works; if it doesn't work, change 'edison.local' to the IP address. 1880 is Node-RED's default port.

```text
http://edison.local:1880
```

Next, drag an 'HTTP' input onto the Node-RED canvas. It is important to send an 'HTTP' response back to whatever sent the request (otherwise the request will block the client). Therefore, drag a 'HTTP' output onto the canvas. Join the 'HTTP' input to the 'HTTP' output. Double click the input and set the address to `/forwared`. Then, using the address bar of your browser, send `http://edison.local:1880/forwared`. If everything works, you will see `{ }` printed inside your web browser.

Next, drag 2 functions onto the canvas. Name one function 'low' and the other one 'high'. In each function set `msg.payload = 0` and `msg.payload = 1` respectively (0 being low, 1 being high).

```javascript
// example high
msg.payload = 1;
return msg;
```

Next, drag 8 GPIO digital outputs onto the canvas. You will need to work through each GPIO digital output to match up with the motors. For each motor there are 2 GPIO outputs and 2 h-bridge inputs. Once you have each motor GPIO connected, you can send the highs and lows functions respectively.

You will need to repeat these steps until `/left`, `/left`, `/back`, and `/stop` can be processed by Node-red. Tip, don't try and reuse the high/low function blocks add 2 more for each command.

Here is a video of me testing what I had programmed (wired) Node-RED correctly.

{{< youtube goctmkpX7Ng >}}

Would you like to take a short cut? Just import this [Node-RED Edison Car Configuration](https://gist.github.com/GeoffHayward/70d5f67e34b2d298b62c) Node-RED via its import option. The file is a JSON array that I exported from my own configuration (The configuration is mostly as it was when tested in the video above).

Step 6 Have fun

That's it. If you follow the steps closely, you will have created a working HTTP controlled Edison Car. Good luck and I hope you enjoy making it. You can, also, find more fun project to do with the Edison over at [Intel's Instructables page](http://www.instructables.com/id/Intel/).
