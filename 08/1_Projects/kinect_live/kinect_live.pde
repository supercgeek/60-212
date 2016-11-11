import org.openkinect.processing.*;
Kinect kinect;

void setup() {
  kinect = new Kinect(this);
  kinect.initDevice();
}