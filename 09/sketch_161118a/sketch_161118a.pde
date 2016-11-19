import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;

Robot robot;

void setup() {
  size(400, 400);

  //Let's get a Robot...
  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {  
    e.printStackTrace();
    exit();
  }
}

void draw() {
}

void mousePressed() {
  //Press the space key
  robot.keyPress(KeyEvent.VK_SPACE); //VK_SPACE
  //If we want a delay here, that gets a little bit more complicated...
  robot.keyRelease(KeyEvent.VK_SPACE);}

void keyPressed() {
  //Detect space key presses (to show that it works)
  if (key == ' ') {
    println("Space!");
  }
}