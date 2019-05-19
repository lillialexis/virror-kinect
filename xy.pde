
int xy(int i, int x, int y, int width, int height, boolean layout, int ledsPerPin) {
  // generates an index in the image array from the LED X,Y values
  // image index 0 is top left, 1 moves right, then down.
  // value for Y is height/8, so group height
  // X understands the width of the screen
  // i is teensy channel output pin, so local Y 

  //flip X and Y and i
  x = width - x - 1;
  //y = (height / 8) - y -1; 
  i = 8 - i -1 ;

  //reverse alternate rows
  if (layout) {x = width - x - 1;}
  int index = x + (width * 8 * y) + (width * i);

  //catch errors in calculation
  if (index > (height * width) ) {
    index = 0;
    print("Index ("); print(y); println(") out of bounds");
  }


  return (index);
}
