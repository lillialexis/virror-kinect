/* VALUES TO CHANGE */

ImageMode imageMode = ImageMode.IMAGE; 

String[] imagePaths = { 
  "./data/VirrorSampleSmall.jpg", 
  "./data/VirrorSampleMedium.jpg",
  // Add more images here, and change imagePathIndex to point to the image you want
};
int imagePathIndex = 0;

String[] moviePaths = { 
  "./data/movie.mp4", 
  "./data/mov2.mov",
  // Add more movies here, and change moviePathIndex to point to the movie you want
};
int moviePathIndex = 0;

String[] usbPorts = { 
  "/dev/cu.usbmodem4438171",
  "COM4",
  "/dev/ttyACM0",
  // Add more port names here, and change usbPortIndex to point to the port you want
};
int usbPortIndex = 0;


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
