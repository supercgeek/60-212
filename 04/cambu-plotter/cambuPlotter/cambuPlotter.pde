// see https://processing.org/reference/libraries/pdf/index.html
import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 0; 
PFont myFont;
Gridmaker newGrid;
PGraphics pg;
int textSize = 40;
 
void setup() {
  size(612, 792);
  bRecordingPDF = true;
  myFont = createFont("GT-Walsheim-Thin-Trial.otf", textSize);
  textFont(myFont);
  
  newGrid = new Gridmaker();
  //Make Vectors
  pg = createGraphics(width, height, JAVA2D); // create a PGraphics the same size as the main sketch display window
}
 
void keyPressed() {
  // When you press a key, it will initiate a PDF export
  bRecordingPDF = true;
}
 
void draw() {
  if (bRecordingPDF) {
    background(255); // this should come BEFORE beginRecord()
    beginRecord(PDF, "cambu_" + pdfOutputCount + ".pdf");
    //START -- -- -- CAMBU FUNCTIONS
    pg.beginDraw(); // start drawing to the PGraphics
    drawGrid();
    chaosRepresentation();
    printAllPixels();
    
    pg.endDraw(); // finish drawing to the PGraphics
    //END -- -- -- CAMBU FUNCTIONS
    endRecord();
    bRecordingPDF = false;
    pdfOutputCount++;
    image(pg, 0, 0);
  }
}
void printAllPixels() {
  loadPixels();
  println(pixels[0]);
}

void drawGrid() {
  noStroke();
 //squares down
 int i = 0;
 for (int y = 0; y < newGrid.totalHeight; y = y + newGrid.verticalDivisor){
   if (i % 2 == 0) {fill(140,140,140,80);} else {fill(240,240,240,80);} //if even, else odd
   i++;
   
   //fill(0,0,0);
   // this function is the background grid rect(0, y, newGrid.totalWidth, newGrid.verticalDivisor);
   //charsHere(0,y);
   }
 
 ////squares across
 int j = 0;
 for (int x = 0; x < newGrid.totalWidth; x = x + newGrid.horizontalDivisor){
   if (j % 2 == 0) {fill(140,140,140,80);} else {fill(240,240,240,80);} //if even, else odd
    j++;
    
    //fill(0,0,0);
   // this function is the background grid 
   //rect(x, 0, newGrid.horizontalDivisor, newGrid.totalHeight);
   //charsHere(x, 0);
   }
 }
 
 void charsHere(int x, int y) {
   //textAlign(CENTER, CENTER);
   String a = (x + y)/2 + "";
   //fill(05, 05, 05, a);  
   //pg.background(255,255,255);
   pg.textFont(myFont);
   pg.textSize(textSize);
   pg.fill(0,0,0);
   pg.text(a,x+(newGrid.horizontalDivisor/16),y-(newGrid.verticalDivisor/4)); //<>//
  
   //int curCol = get(x+(newGrid.horizontalDivisor/16),y-(newGrid.verticalDivisor/4));
   //println(curCol);
   //text(a, random(0, width), random(0, height));//random placement
   //fill(0,0,0);
   //text(a,x+(newGrid.horizontalDivisor/16),y-(newGrid.verticalDivisor/4));//
   
 }
 
 void chaosRepresentation(){
  float chaos = 1;
  int startX = 0;
  int startY = 0;
  
  //embedded for loops 
  //verticalDivisor, x amount
  // horizontalDivisor, y amount
  for (int y = 0; y < newGrid.numberOfRows; y++) {
    startX = 0;
    for (int x = 0; x < newGrid.numberOfCols; x++) {
      fill((255/newGrid.numberOfCols)*(y/2),(255/newGrid.numberOfRows)*x,200);
      //rect(startX,startY,newGrid.horizontalDivisor,newGrid.verticalDivisor); //<>//
      charsHere(startX,startY);
      startX = startX + newGrid.horizontalDivisor;
      //fill(0,0,0);
      
    }
    startY = startY + newGrid.verticalDivisor;
  }
 }
 
 
 // pg.beginDraw(); // start drawing to the PGraphics
 // pg.textSize(175); // set the text rendering size (of the PGraphics!) to 175
 // pg.textAlign(CENTER, CENTER); // center the text (of the PGraphics!) horizontally and vertically
 // pg.background(255); // clear the background (of the PGraphics!) with a white color
 // pg.fill(0); // set the text fill color (of the PGraphics!) to black
 // // display the String "TYPE" in the center of the PGraphics
 // pg.text("TYPE", pg.width/2, pg.height/2); 
 // pg.endDraw(); // finish drawing to the PGraphics