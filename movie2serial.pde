/*  OctoWS2811 movie2serial.pde - Transmit video data to 1 or more
 Teensy 3.0 boards running OctoWS2811 VideoDisplay.ino
 http://www.pjrc.com/teensy/td_libs_OctoWS2811.html
 Copyright (c) 2013 Paul Stoffregen, PJRC.COM, LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

// To configure this program, edit the following sections:
//
//  1: change myMovie to open a video file of your choice    ;-)
//
//  2: edit the serialConfigure() lines in setup() for your
//     serial device names (Mac, Linux) or COM ports (Windows)
//
//  3: if your LED strips have unusual color configuration,
//     edit colorWiring().  Nearly all strips have GRB wiring,
//     so normally you can leave this as-is.
//
//  4: if playing 50 or 60 Hz progressive video (or faster),
//     edit framerate in movieEvent().

import processing.video.*;
import processing.serial.*;
import java.awt.Rectangle;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float deg;

Movie myMovie;

float gamma = 3.2;

PImage testImage;

int numPorts=0;  // the number of serial ports in use
int maxPorts=24; // maximum number of serial ports

Serial[] ledSerial = new Serial[maxPorts];     // each port's actual Serial port
Rectangle[] ledArea = new Rectangle[maxPorts]; // the area of the movie each port gets, in % (0-100)
boolean[] ledLayout = new boolean[maxPorts];   // layout of rows, true = even is left->right
PImage[] ledImage = new PImage[maxPorts];      // image sent to each port
int[] gammatable = new int[256];
int errorCount=0;
float framerate=0;

void setup() {
  String[] list = Serial.list();
  delay(20);
  println("Serial Ports List:");
  println(list);
  serialConfigure(usbIdentifier());
  //serialConfigure("/dev/ttyACM1");
  if (errorCount > 0) exit();
  for (int i=0; i < 256; i++) {
    gammatable[i] = (int)(pow((float)i / 255.0, gamma) * 255.0 + 0.5);
  }
  size(480, 400);  // create the window

  if (imageMode == ImageMode.IMAGE) {
    testImage = loadImage(imagePath());

  } else if (imageMode == ImageMode.MOVIE) {
    myMovie = new Movie(this, moviePath());
    myMovie.loop();  // start the movie :-)

  } else {    
    kinect = new Kinect(this);
    kinect.initDepth();
    kinect.initVideo();
    kinect.enableIR(imageMode == ImageMode.KINECT_IR);
    kinect.enableColorDepth(imageMode == ImageMode.KINECT_COLOR_DEPTH);
   
    deg = kinect.getTilt();
    kinect.setTilt(-285);
  }
}

PImage lastEventFrame = null;

// movieEvent runs for each new frame of movie data
void movieEvent(Movie m) {
  // read the movie's next frame
  m.read();  
  //event(m);
  lastEventFrame = m;
}

// videoEvent runs for each new frame of Kinect data
void videoEvent(Kinect k) {
  //background(0);
  if (imageMode == ImageMode.KINECT_VIDEO) {
    //PImage frame 
    lastEventFrame = k.getVideoImage();
    //image(frame, 0, 0);
    //fill(255);
    //event(frame);  
  } else if (imageMode == ImageMode.KINECT_COLOR_DEPTH) {
    //PImage frame
    lastEventFrame = k.getDepthImage();
    //image(frame, 0, 0);
    //fill(255);
    //event(frame);
  }
}

// draw runs every time the screen is redrawn - show the movie...
void draw() {
  if (imageMode == ImageMode.IMAGE) {
    event(testImage);
  } else {
    event(lastEventFrame);
  }

  //if (imageMode == ImageMode.IMAGE) {
  //} else if (imageMode == ImageMode.MOVIE) {
  //  image(myMovie, 0, 80);
  //} else if (imageMode == ImageMode.KINECT_COLOR_DEPTH) { // if (imageMode equals KINECT_VIDEO or KINECT_IR
  
  //}

  // then try to show what was most recently sent to the LEDs
  // by displaying all the images for each port.
  for (int i=0; i < numPorts; i++) {
    // compute the intended size of the entire LED array
    int xsize = percentageInverse(ledImage[i].width, ledArea[i].width);
    int ysize = percentageInverse(ledImage[i].height, ledArea[i].height);
    // computer this image's position within it
    int xloc =  percentage(xsize, ledArea[i].x);
    int yloc =  percentage(ysize, ledArea[i].y);
    // show what should appear on the LEDs
    image(ledImage[i], 240 - xsize / 2 + xloc, 10 + yloc);
  }
}

// respond to mouse clicks as pause/play
boolean isPlaying = true;
void mousePressed() {
  if (isPlaying) {
    myMovie.pause();
    isPlaying = false;
  } else {
    myMovie.play();
    isPlaying = true;
  }
}
