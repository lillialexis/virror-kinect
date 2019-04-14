

void event(PImage frame) {
  
  //if (framerate == 0) framerate = m.getSourceFrameRate();
  framerate = 30.0; // TODO, how to read the frame rate???
  
  for (int i=0; i < numPorts; i++) {    
    // copy a portion of the movie's image to the LED image
    int xoffset = percentage(frame.width, ledArea[i].x);
    int yoffset = percentage(frame.height, ledArea[i].y);
    int xwidth =  percentage(frame.width, ledArea[i].width);
    int yheight = percentage(frame.height, ledArea[i].height);
    ledImage[i].copy(frame, xoffset, yoffset, xwidth, yheight,
                     0, 0, ledImage[i].width, ledImage[i].height);
    // convert the LED image to raw data
    byte[] ledData =  new byte[(ledImage[i].width * ledImage[i].height * 3) + 3];
    image2data(ledImage[i], ledData, ledLayout[i]);
    if (i == 0) {
      ledData[0] = '*';  // first Teensy is the frame sync master
      int usec = (int)((1000000.0 / framerate) * 0.75);
      ledData[1] = (byte)(usec);   // request the frame sync pulse
      ledData[2] = (byte)(usec >> 8); // at 75% of the frame time
    } else {
      ledData[0] = '%';  // others sync to the master board
      ledData[1] = 0;
      ledData[2] = 0;
    }
    // send the raw data to the LEDs  :-)
    ledSerial[i].write(ledData);
  }
}

int doOnce = 0;

// image2data converts an image to OctoWS2811's raw data format.
// The number of vertical pixels in the image must be a multiple
// of 8.  The data array must be the proper size for the image.
void image2data(PImage image, byte[] data, boolean layout) {
  int offset = 3;
  int x, y, xbegin, xend, xinc, ibegin, iend, iinc, mask;
  int linesPerPin = image.height / 8;
  int pixel[] = new int[8];

 for (y = 0; y < linesPerPin; y++) {
    if ((y & 1) == (layout ? 0 : 1)) {
      // even numbered rows are left to right
      xbegin = 0;
      xend = image.width;
      xinc = 1;
      ibegin = 0;
      iend = 8;
      iinc = 1;
    } else {
      // odd numbered rows are right to left
      xbegin = image.width - 1;
      xend = -1;
      xinc = -1;
      ibegin = 7;
      iend = -1;
      iinc = -1;
    }

    for (x = xbegin; x != xend; x += xinc) {
      for (int i = ibegin; i != iend; i += iinc) {
        // fetch 8 pixels from the image, 1 for each pin
        int index = xy(i, x, y, image.width, image.height, layout, linesPerPin);

        pixel[i] = image.pixels[index];
        pixel[i] = colorWiring(pixel[i]);

        if (doOnce == 0) {
          print("y:\t", y);
          print("\t");
          print("x:\t", x);
          print("\t");
          println("i:\t", index);
        }
      }

      // convert 8 pixels to 24 bytes
      for (mask = 0x800000; mask != 0; mask >>= 1) {
        byte b = 0;
        for (int i = 0; i < 8; i++) {
          if ((pixel[i] & mask) != 0) b |= (1 << i);
        }
        data[offset++] = b;
      }
    }
  }

  doOnce++;
}
