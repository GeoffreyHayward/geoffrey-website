---
title: "Blinking an LED with Java on the Intel Edison"
author: "Geoffrey Hayward"
date: 2016-02-05T11:00:00Z
categories:
- computing
tags:
- Edison
- Java SE
- Java Tip
---
I have been keen to use Java on the Intel Edison since hearing that the Edison supports Java. At the time of writing this, I could not find much information on how to use Java with the Edison. So I decided to try and get a simple LED blink program going. While a blink program is very simple, the hello world of hardware, it thought me the important bits about using the Edison with Java.

<!--more-->

Here is the blink program in action:

{{< youtube 7ZDFedKyuWw >}}


And here is the blink program's code:

```java
import mraa.Gpio;

public class EdisonTest {

    static {
        try {
            System.loadLibrary("mraajava");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("Native code library failed to load.");
            System.exit(1);
        }
    }

    public static void main(String[] args) throws InterruptedException {
        Gpio gpio = new Gpio(11);
        gpio.dir(Dir.DIR_OUT);
        int state = 1;

        while (true){
            gpio.write(state);
            state = (state==1?0:1); 
            Thread.sleep(1000);
        }
    } 

}
```

The command to run the program is `java -Djava.library.path=/usr/lib/java/ -jar EdisonTest.jar`. I used WinSCP to put the EdisonTest.jar and its lib folder into `/home/root/` (where I ran the program from).

If you get any problems check that your manifest file includes the lib folder. And that the lib folder includes the mraa.jar. You can download the [mraa.jar and UPM jars](http://iotdk.intel.com/repos/2.0/java/) from Intel.
