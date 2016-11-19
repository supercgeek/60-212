import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;

Robot robot;


void setup() {
  size(500, 500);
}
void draw() {
  robot.keyPress(KeyEvent.VK_SPACE);
  //robot.keyPress(KeyEvent.VK_3);
  noLoop();
}