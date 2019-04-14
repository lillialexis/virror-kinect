/* VALUES TO CHANGE */

ImageMode imageMode = ImageMode.KINECT_VIDEO; 
Board board = Board.DEV;

String[] imagePaths = { 
  "./data/VirrorSampleSmall.jpg", 
  "./data/VirrorSampleMedium.jpg",
  // Add more images here, and change imagePathIndex to point to the image you want
};
int imagePathIndex = 0;

String[] moviePaths = { 
  "movie.mp4", 
  "mov2.mov",
  "video.mp4",
  "snowflake.avi"
  // Add more movies here, and change moviePathIndex to point to the movie you want
};
int moviePathIndex = 3;

String[] usbPorts = { 
  "/dev/cu.usbmodem4438171",
  "COM4",
  "/dev/ttyACM0",
  // Add more port names here, and change usbPortIndex to point to the port you want
};
int usbPortIndex = 1;

enum Board {
  DEV,
  REAL
};

enum ImageMode {
  IMAGE,
  MOVIE,
  KINECT_VIDEO,
  KINECT_IR
};

String usbIdentifier() {
  return usbPorts[usbPortIndex];
}  

String imagePath() {
    return imagePaths[imagePathIndex];
}

String moviePath() {
    return moviePaths[moviePathIndex];
}

int boardDivisor() {
  return board == Board.DEV ? 4 : 1;
}
  
