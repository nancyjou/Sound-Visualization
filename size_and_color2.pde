float global1;
float global2;
float adc;
float fiddle;
float colorY;
float alphaX;

import netP5.*;
import oscP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(800, 800);
  background(255);
  frameRate(25);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12001);

  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}

void draw() {

  fiddle = global2;
  colorY= map(global2, 25, 150, 0, 360);
  alphaX= map(global1, 40, 250, 20, 255);
  fill(colorY, 100, 100);
  fill(colorY, 100, fiddle+50, alphaX);
  for (int y=200; y<(height/4)+1; y+=10) {
    ellipse(width/2, random(0, 400), global1, global1);
    println(y);
  }
  adc = global1 + 10;
}


void mousePressed() {
  OscMessage myMessage = new OscMessage("/first");


  myMessage.add(123);
  myMessage.add(12.34);
  myMessage.add("some text");

  oscP5.send(myMessage, myRemoteLocation);
}  

void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/first")==true) {



    float firstValue = theOscMessage.get(0).floatValue();
    global1 = firstValue;
  }

  if (theOscMessage.checkAddrPattern("/second")==true) {



    float secondValue = theOscMessage.get(0).floatValue();
    global2 = secondValue;
  }
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}