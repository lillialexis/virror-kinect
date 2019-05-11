
// CHANGE THIS TO TRY DIFFERENT CALCULATIONS ON THE BIGGER SCREEN
int attempt = 0;

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
  if (index > (height * width) ) {index = 0; print("Index (");print(y);println(") out of bounds");}
  
  return (index);
}





//  if (attempt == 12) {
//    return (i * 16) + (x) + (16 * 16 / 2 * y);
//  } else if (attempt == 1) {
//    return (i * width) + (x) + (width * width / 2 * y);
//  } else if (attempt == 2) {
//    return (i * width) + (x) + (width * height / 2 * y);
//  } else if (attempt == 3) {
//    return (i * width) + (x) + (height * height / 2 * y);
//  } else if (attempt == 4) {
//    return (i * height) + (x) + (width * width / 2 * y);
//  } else if (attempt == 5) {
//    return (i * height) + (x) + (width * height / 2 * y);
//  } else if (attempt == 6) {
//    return (i * height) + (x) + (height * height / 2 * y);
//  } else if (attempt == 7) {
//    return (i * width) + (x) + (width * width / linesPerPin * y);
//  } else if (attempt == 8) {
//    return (i * width) + (x) + (width * height / linesPerPin * y);
//  } else if (attempt == 9) {
//    return (i * width) + (x) + (height * height / linesPerPin * y);
//  } else if (attempt == 10) {
//    return (i * height) + (x) + (width * width / linesPerPin * y);
//  } else if (attempt == 11) {
//    return (i * height) + (x) + (width * height / linesPerPin * y);
//  } else if (attempt == 12) {
//    return (i * height) + (x) + (height * height / linesPerPin * y);
//  }

//  return (i * 16) + (x) + (16 * 16 / 2 * y);
//}
