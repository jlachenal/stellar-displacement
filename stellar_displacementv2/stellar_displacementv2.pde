import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect kinect;
PImage img;

int x;
int y;
int starCount = 10;
int[] starMapX = new int[starCount];
int[] starMapY = new int[starCount];

void setup() {
  
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initVideo();
  
  img = createImage(kinect.width, kinect.height, RGB); // makes blank image
  
  newStarMap();
  
}
void draw() {
  
  img.loadPixels(); // applies pixel values to image
  
  PImage frame = kinect.getVideoImage();
  
  // i want to look at every pixel (except for skip pixels, above)
  for (int x = 0; x < kinect.width; x++){
   for (int y = 0; y < kinect.height; y++){
     int offset = x + y * kinect.width;
     int c = frame.pixels[offset];
     float bright = brightness(c);

     if (bright > 100){  
       img.pixels[offset] = color(255, 0, 150);
          for (int ii = 0; ii < starMapX.length; ii++){
            for (int iii = 0; iii < starMapY.length; iii++){
              if (x == starMapX[ii] && y == starMapY[iii]){
                newStarMap();
              }
            }
          }
     } else {
       img.pixels[offset] = color(0);
     }
  }
 }
 
  img.updatePixels(); // updates pixel values
  
  image(img,0,0); // loads the image, shows as-is
  
  for (int i = 0; i < starCount; i++){
  noStroke();
  ellipse(starMapX[i], starMapY[i], 10, 10);
  }
  
}

void newStarMap() {
  
  for (int i = 0; i < starCount; i++){
    starMapX[i] = int(random(10, 630));
  }
  
  for (int i = 0; i < starCount; i++){
    starMapY[i] = int(random(10, 470));
    println(i + ":" + starMapX[i] + "," + starMapY[i]);
  }
  
}