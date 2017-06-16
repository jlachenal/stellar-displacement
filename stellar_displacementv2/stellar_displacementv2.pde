import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect kinect;
PImage img;

float starR = 120;
float starG = 0;
float starB = 255;

int starX = 120;
int starY = 250;
int x;
int y;
int i;

int[] starMapX;
int[] starMapY;

int starCount = 22;

void setup() {
  
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initVideo();
  
  img = createImage(kinect.width, kinect.height, RGB); // makes blank image
  
  int[] starMapX = new int[20];  
  for (int i = 1; i < starCount; i++);{
    starMapX[i] = int(random(10, 630));
    println(starMapX[i]);
  }
  
  int[] starMapY = new int[20];
  for (int i = 1; i < starCount; i++);{
    starMapY[i] = int(random(10, 470));
    println(starMapY[i]);
  }
  
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
     
     // checking the brightness... if it's over a certain value, do all the things
     if (bright > 100){  
       img.pixels[offset] = color(255, 0, 150);
       // checking to see if we're hitting our star, and when we do, change the color
       if (x == starX && y == starY){
         starX = int(random(640));
         starY = int(random(480));
       }     
     } else {
       img.pixels[offset] = color(0);
     }
    }
  }
 
  img.updatePixels(); // updates pixel values
  
  image(img,0,0); // loads the image, shows as-is
  
  for (int i = 0; i < starCount; i++){
  ellipse(starMapX[i], starMapY[i], 20, 20);
  }
  
}

//void makeStarMap() {
  
//// make a ton of stars  
//  for (int i=1; i<=20; i++){
//  noStroke();  
//  ellipse(starMapX[i], starMapY[i], 20, 20);    
//  }
  
  
//}

//void changeStarPosition() {
 
//  starX = int(random(640));
//  starY = int(random(480));
  
//}

//void drawSegment() {
 
//  line(starX, starY, x, y);
  
//}

//void newStarMap() {
  
//  starMapX = new int[20];
//  for (int i = 1; i < 20; i++) {
//    starMapX[i] = int(random(640));
//  }
  
//  starMapY = new int[20];
//  for (int i = 1; i < 20; i++) {
//    starMapY[i] = int(random(640));
//  }

//  for (int i = 1; i <= 20; i++) {
//    ellipse(starMapX[i], starMapY[i], 20, 20);
//  }
  
//}