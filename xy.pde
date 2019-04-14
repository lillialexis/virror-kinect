
// CHANGE THIS TO TRY DIFFERENT CALCULATIONS ON THE BIGGER SCREEN
int attempt = 0;

int xy(int i, int x, int y, int width, int height, boolean layout, int linesPerPin) {
  // orig:

  if (attempt == 0) {
    return (i * 16) + (x) + (16 * 16 / 2 * y);
  } else if (attempt == 1) {
    return (i * width) + (x) + (width * width / 2 * y);
  } else if (attempt == 2) {
    return (i * width) + (x) + (width * height / 2 * y);
  } else if (attempt == 3) {
    return (i * width) + (x) + (height * height / 2 * y);
  } else if (attempt == 4) {
    return (i * height) + (x) + (width * width / 2 * y);
  } else if (attempt == 5) {
    return (i * height) + (x) + (width * height / 2 * y);
  } else if (attempt == 6) {
    return (i * height) + (x) + (height * height / 2 * y);
  } else if (attempt == 7) {
    return (i * width) + (x) + (width * width / linesPerPin * y);
  } else if (attempt == 8) {
    return (i * width) + (x) + (width * height / linesPerPin * y);
  } else if (attempt == 9) {
    return (i * width) + (x) + (height * height / linesPerPin * y);
  } else if (attempt == 10) {
    return (i * height) + (x) + (width * width / linesPerPin * y);
  } else if (attempt == 11) {
    return (i * height) + (x) + (width * height / linesPerPin * y);
  } else if (attempt == 12) {
    return (i * height) + (x) + (height * height / linesPerPin * y);
  }

  return (i * 16) + (x) + (16 * 16 / 2 * y);
}
