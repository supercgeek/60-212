// a template for receiving face tracking osc messages from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker

// further adapted by Marisa Lu
// adapted by Kaleb Crawford 
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art

// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230

import oscP5.*;
OscP5 oscP5;

import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture cam;
//Movie cam;
// num faces found
int found;
float[] rawArray;

//which point is selected
int highlighted;

int liveOrNot = 1 ; //0 for recorded video, 1 for live
int shiftVal = 465;
int xOffset = round(0.1*width);
int yOffset = round(0.1*height);



void setup() {
  size(1280, 730);
  frameRate(60);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "rawData", "/raw");

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    //println("There are no cameras available for capture.");
    exit();
  } else {
    for (int i = 0; i < cameras.length; i++) {
      //println(cameras[i]);
    }

    cam = new Capture(this, 1024, 576, cameras[0]);
    cam.start();
  }
}

//void keyPressed() {
//  if (keyCode == RIGHT) {
//    highlighted = (highlighted + 2) % rawArray.length;
//  }
//  if (keyCode == LEFT) {
//    highlighted = (highlighted - 2) % rawArray.length;
//    if (highlighted < 0) {
//      highlighted = rawArray.length-1;
//    }
//  }
//}
void draw() {
  //background(255, 255,255, 50);
  fill(255, 255, 255, 7);
  int border = 5;
  strokeWeight(border);
  rect(border, border, width-border*2, height-border*2);
  int timeNowSinceStart = millis() % 2555;
  float curColMod = map(timeNowSinceStart, 0, 2555, 0, 255);
  //drawPhoneFrame();

  //if (cam.available() == true) {
  // cam.read();
  //}
  //set(xOffset, yOffset, cam);

  if (found > 0) {
    for (int val = 0; val < rawArray.length -1; val+=2) {
      //function that changes stroke color if it been more than X time since last called
      chnageColIfBreak(curColMod);
      ellipse(rawArray[val], rawArray[val+1], 1, 1);
    }
  }
}

void drawPhoneFrame() {
  strokeWeight(1);
  int phoneWidth = 345;
  int phoneHeight = 675;
  int screenWidth = 315;
  int screenHeight = 570;

  //DRAW PHONE 
  stroke(0, 0, 0);

  rect(width/2 - phoneWidth*0.5, 45-15, phoneWidth, phoneHeight, 45); //phone frame
  rect(width/2 - 0.5*screenWidth, 45+15+15, screenWidth, screenHeight, 15); //phone screen
  rect(width/2 - 0.5*100, 45, 100, 15, 5); //earpiece
  ellipse(width/2, 675, 35, 35); //home
}

float currentMilVal = 0;
float prevMilVal = 0;
float someVal = 285; //this 1000 miliseconds or one second
int faceIncre;

void chnageColIfBreak(float curColMod) {
  currentMilVal = millis();
  if (currentMilVal - prevMilVal < someVal) {
    //the time between OSC face grabs  has not been long enough to change the colour
    // aka, it just relocked a face, didn't switch to a new face
  } else {
    faceIncre++;
    int curSelect = faceIncre % 3;
    if (curSelect == 1) { // RED
      drawPhoneFrame();
      stroke(17, 45, 200 * (millis()%1000)/100);
      //stroke(curColMod*1.2, curColMod*0.8, curColMod*0.5);
      //println(curColMod*1.2 + "//"  +  curColMod + "//"  + curColMod);
    } else if (curSelect == 2) { // GREEN
      drawPhoneFrame();
      stroke(32, 165, 50 * (millis()%1000)/100);
      //stroke(curColMod*0.1, curColMod*1.2, curColMod*0.3);
    } else { // curSelect == 3, in this case BLUE 
      drawPhoneFrame();
      stroke(120, 78, 245 * (millis()%1000)/100);
      //stroke(curColMod/8, curColMod/2, curColMod*1.65);
    }
    //println(faceIncre + " " + curSelect);
  }

  prevMilVal = currentMilVal;
}
/////////////////////////////////// OSC CALLBACK FUNCTIONS//////////////////////////////////

public void found(int i) {
  //println("found: " + i);
  found = i;
}

public void rawData(float[] raw) {
  //println("raw data saved to rawArray");
  rawArray = raw;
  
  if (liveOrNot == 0) {
    for (int x = 0; x < rawArray.length; x = x + 2) {
      rawArray[x] = rawArray[x] + shiftVal;
    }
  }
}