// see https://processing.org/reference/libraries/pdf/index.html //<>// //<>// //<>//
import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 0; 
PFont myFont;
Gridmaker newGrid;
PGraphics pg;
int textSize = 40;
float magicYimpactor;
float amount; 
float currentChaos;

void setup() {
  size(612, 792);
  bRecordingPDF = true;
  myFont = createFont("GT-Walsheim-Thin-Trial.otf", textSize);
  textFont(myFont);

  newGrid = new Gridmaker();
  pg = createGraphics(width, height, JAVA2D); // create a PGraphics the same size as the main sketch display window
}

void draw() {
  if (bRecordingPDF) {
    background(255); // this should come BEFORE beginRecord()

    //START -- -- -- CAMBU FUNCTIONS
    pg.beginDraw(); // start drawing to the PGraphics
    drawGrid();
    chaosRepresentation();

    pg.endDraw(); // finish drawing to the PGraphics
    //END -- -- -- CAMBU FUNCTIONS
    image(pg, 0, 0);
    // -- -- -- function that reads all of pg and places points/ellipses at certain values of a certain brightness
    beginRecord(PDF, "cambu_" + pdfOutputCount + ".pdf");
    rasterToNotVector();
    endRecord();
    bRecordingPDF = false;
    pdfOutputCount++;
  }
}

void keyPressed() {
  //rasterToNotVector();
  //magicYimpactor = mouseX*0.0005;
  magicYimpactor = mouseX*0.0005;
  //magicXXX = mouseX;
  //magicXimpactor = mouseY*0.0005;
  //amount = mouseX*0.0005;
  bRecordingPDF = true;
}

void chaosRepresentation() {
  float chaosStart = 1;
  int startX = 0;
  int startY = 0;

  int chaosIndex = 0;
  for (int y = 0; y < newGrid.numberOfRows; y++) { //verticalDivisor, x amount
    startX = 0;
    for (int x = 0; x < newGrid.numberOfCols; x++) { // horizontalDivisor, y amount
      fill((255/newGrid.numberOfCols)*(y/2), (255/newGrid.numberOfRows)*x, 200);
      //rect(startX,startY,newGrid.horizontalDivisor,newGrid.verticalDivisor); //within the domain & range of this rectangle, transform the pixels on pg 
      chaosIndex = chaosIndex + 1;
      currentChaos = chaosStart * chaosIndex;
      charsHere(startX, startY, currentChaos);
      startX = startX + newGrid.horizontalDivisor;
    }
    startY = startY + newGrid.verticalDivisor;
  }
}

void charsHere(int x, int y, float currentChaos) {
  int a = round((x + y)*.5);

  pg.textFont(myFont);
  pg.textSize(textSize);
  pg.fill(0, 0, 0);

  int xDes = x+(newGrid.horizontalDivisor/16);
  int yDes = y-(newGrid.verticalDivisor/4);

  pg.text(a, xDes, yDes);
  quadrantDestoryer(xDes, yDes, currentChaos); // operates between (startX, startY, newGrid.horizontalDivisor, newGrid.verticalDivisor)
}

void quadrantDestoryer(int xToDes, int yToDes, float currentChaos) {
  float xA = xToDes + 0.6*newGrid.horizontalDivisor - noise(currentChaos, yToDes, xToDes);
  float yA = yToDes - 0.2*newGrid.verticalDivisor;

  pg.fill(255, 235, 250);
  //pg.noStroke();
  pg.ellipse(xToDes + 0.5*newGrid.horizontalDivisor * noise(currentChaos, yToDes), yToDes - 0.2*newGrid.verticalDivisor, noise(currentChaos, yToDes)*0.5*currentChaos, 0.05*currentChaos);
  //pg.ellipse(xA, yA, random(0, newGrid.horizontalDivisor)*0.8, noise(50, newGrid.horizontalDivisor)*2);
  //pg.rect(xA-8, yA, xA+ 30, yA + newGrid.verticalDivisor * 0.5);
  //pg.ellipse(xToDes, yToDes, currentChaos*noise(xToDes, yToDes), noise(currentChaos+currentChaos));
}

void rasterToNotVector() {//y down
  for (int y = 0; y < height; y ++) {
    for (int x = 0; x < width; x++) { //x across              
      color cp = get(x, y);
      int b = (int)blue(cp);
      int g = (int)green(cp); 
      int r = (int)red(cp);
      int tolerance = 150;

      float noised = 30;

      if (r < tolerance && g < tolerance && b < tolerance) { 

        float amount = 30;
        float chiller = 0.05;
        float nx = noise(x/noised, y/noised); 
        float ny = noise(magicYimpactor + x/noised, magicYimpactor*magicYimpactor + y*y); 

        nx = map(nx, 0, 1, -amount+ x*chiller, amount); //cc to Golan for explaining distortion fields.
        ny = map(ny, 0, 1, -amount + y*chiller, amount*magicYimpactor); 

        //line(x, y, x+nx, y+ny);
        strokeWeight(7);
        fill(34, 78, 240);
        ellipse(x + nx*0.5, y + ny/2, y*0.1, x*0.3);
      }
    }
  }
}
void drawGrid() {
  noStroke();
  int i = 0;
  for (int y = 0; y < newGrid.totalHeight; y = y + newGrid.verticalDivisor) { //squares down
    if (i % 2 == 0) {
      fill(140, 140, 140, 80);
    } else {
      fill(240, 240, 240, 80);
    } //if even, else odd
    i++;
  }

  int j = 0;
  for (int x = 0; x < newGrid.totalWidth; x = x + newGrid.horizontalDivisor) { ////squares across
    if (j % 2 == 0) {
      fill(140, 140, 140, 80);
    } else {
      fill(240, 240, 240, 80);
    } //if even, else odd
    j++;
  }
}

class Gridmaker {
  int totalHeight = height;
  int totalWidth = width;
  int numberOfRows = 14;
  int numberOfCols = 7;
  int verticalDivisor = round(totalHeight/numberOfRows);
  int horizontalDivisor = totalWidth/numberOfCols;
}