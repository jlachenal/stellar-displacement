import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect kinect;
PImage img;
PImage img2;

int x;
int y;
int starCount = 20;
int[] starMapX = new int[starCount];
int[] starMapY = new int[starCount];

int[] hitStar = new int[starCount];

int[] lines = new int[500];
int lineIndex = 0;

int lastHitX = -1;
int lastHitY = -1;

int resetTimer = 0;

void setup() {
  
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initVideo();
  
  img = createImage(kinect.width, kinect.height, RGB); // makes blank image
  
  newStarMap();
  
}

int pointIsStar(int xx, int yy) {
   for (int i = 0; i < starMapX.length; i++){
    if ((xx == starMapX[i]) && (yy == starMapY[i])){
      return i;
    }
  }
  return -1;
}

void draw() {
  
  fill(0);
  rect(0, 0, kinect.width, kinect.height);
  
  //img.loadPixels(); // applies pixel values to image
  
  PImage frame = kinect.getVideoImage();
  
  // i want to look at every pixel (except for skip pixels, above)
  for (int x = 0; x < kinect.width; x++){
   for (int y = 0; y < kinect.height; y++){
     int offset = x + y * kinect.width;
     int c = frame.pixels[offset];
     float bright = brightness(c);

      //indicate bright spots
      if (bright > 100){
         //img.pixels[offset] = color(255, 0, 150);
         fill(150, 0, 255);
         ellipse(x, y, 10, 10);
         resetTimer = 0;
       } else {
         resetTimer++;
       }
       
      if (resetTimer > 500000000){
         newStarMap(); 
         
      }

     int starIndex = pointIsStar(x, y);
     if (starIndex >= 0){
       //println("Found " + starIndex + " star at " + x + ", " + y);
       if (bright > 100){
         println("Hit " + starIndex + " star at " + x + ", " + y);
         hitStar[starIndex] = 1;
         
         
         if ((lastHitX != x) && (lastHitY != y)){
           lines[lineIndex] = x;
           lines[lineIndex+1] = y;
           lineIndex += 2;
           lastHitX = x;
           lastHitY = y;
         }
         
         println("Set last hit " + x + ", " + y);

       } 
       
       noStroke();
       if (hitStar[starIndex] == 1){
         //println("Changing fill for star " + starIndex);
         fill(255, 0, 150);
       } else {
         fill(255, 255, 255);       
       }
       ellipse(x, y, 10, 10);
     }
  }
 }
 
 //Move through two by two with a look back.
 for (int i = 0; i < lineIndex; i+=2){   
   if (lines[i+2] == -1 || lines[i] == -1){break;}
   
   //fill(255, 0, 150); 
   stroke(255, 0, 150); 
   line(lines[i], lines[i+1], lines[i+2], lines[i+3]);
 }
 
 stroke(0, 0, 0);
 strokeWeight(1);
 line(0, 0, 0, height);
 line(0, 0, width, 0);

}

void newStarMap() {
  
  for (int i = 0; i < starCount; i++){
    starMapX[i] = int(random(10, 630));
    starMapY[i] = int(random(10, 470));  
    hitStar[i] = 0;
  }
  
  for (int i = 0; i < 300; i++) {
    lines[i] = -1;
    lineIndex = 0;
  }
}