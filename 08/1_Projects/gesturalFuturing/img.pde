class flowImg {

  color c;
  float xPosition;
  float yPosition;

  flowImg() {
    c = color(20);
    xPosition = -400;
    yPosition = -250;
  }

  void render() {
    fill(c);
    rect(xPosition, yPosition, 150, 150);
  }

  void move(float x, float y) {
    //xPosition = xPosition + deltaX;
    //yPosition = yPosition + deltaY;
    xPosition = x;
    yPosition = y;
  }
}