// see https://processing.org/reference/libraries/pdf/index.html
import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 0; 
PFont myFont;
 
void setup() {
  size(612, 792);
  bRecordingPDF = true;
  // Uncomment the following two lines to see the available fonts 
  //String[] fontList = PFont.list();
  //printArray(fontList);
  myFont = createFont("GT-Walsheim-Thin-Trial.otf", 67);
  textFont(myFont);
  //textAlign(CENTER, CENTER);
  //  text("ABSCasdf", width/2, height/2);
  //noLoop();
}
 
void keyPressed() {
  // When you press a key, it will initiate a PDF export
  bRecordingPDF = true;
}
 
void draw() {
  if (bRecordingPDF) {
    background(255); // this should come BEFORE beginRecord()
    beginRecord(PDF, "cambu_" + pdfOutputCount + ".pdf");
 
    //--------------------------
    // This draws a squiggly drunk walk. 
    //noFill(); 
    //beginShape();
    //float rx = width/2;
    //float ry = height/2;
    
    //for (int i=0; i < 100; i++) {
    //  rx = rx + random(-25, 25); 
    //  ry = ry + random(-25, 25); 
    //  curveVertex(rx, ry);
    //}
    //endShape();
    //--------------------------
    drawGrid();
    //typeODistort();
    
    endRecord();
    bRecordingPDF = false;
    pdfOutputCount++;
  }
}

void drawGrid() {
  noStroke();
 //----------- 
 int totalHeight = height;
 int totalWidth = width;
 
 int numberOfRows = 101;
 int numberOfCols = 67;
 
 int verticalDivisor = round(totalHeight/numberOfRows);
 int horizontalDivisor = totalWidth/numberOfCols;

 
 //squares down
 int i = 0;
 for (int y = 0; y < totalHeight; y = y + verticalDivisor){
   if (i % 2 == 0) {fill(140,140,140,80);} else {fill(240,240,240,80);} //if even, else odd
   i++;
   fill(0,0,0);
   rect(0, y, totalWidth, verticalDivisor);
   charsHere(0,y);
 }
 
 ////squares across
 int j = 0;
 for (int x = 0; x < totalWidth; x = x + horizontalDivisor){
   if (j % 2 == 0) {fill(140,140,140,80);} else {fill(240,240,240,80);} //if even, else odd
    j++;
    fill(0,0,0);
   rect(x, 0, horizontalDivisor, totalHeight);
   charsHere(x, 0);
 }
 }
 
 void charsHere(int xArea, int yArea) {
   textAlign(CENTER, CENTER);
   int a = xArea + yArea;
   fill(255, 245, 255, a);
   
   text(a, random(0, width), random(0, height));
    
 
 }