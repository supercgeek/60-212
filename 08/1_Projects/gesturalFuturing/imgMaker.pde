class img {

  color c;
  float xPosition;
  float yPosition;
  float rectWidth;
  float rectHeight;
  boolean isHovering;

  img(float xPos, float yPos, float rWidth, float rHeight) {
    c = color(200, 200, 200, 0);
    xPosition = xPos;
    yPosition = yPos;
    rectWidth = rWidth;
    rectHeight = rHeight;
    isHovering = false;
  }

  void render() {
    fill(c);
    rect(xPosition, yPosition, rectWidth, rectHeight);
  }

  void updateHoverState(boolean hoverState) {
    isHovering = hoverState;
    if (isHovering) {
      c = color(245, 50, 100, 50);
    } else {
      c = color(245, 50, 100, 0);
    }
  }

  void move(float x, float y) {
    
    //xPosition = xPosition + deltaX;
    //yPosition = yPosition + deltaY;
    xPosition = x-rectWidth/2;
    yPosition = y-rectHeight/2;
  }
}