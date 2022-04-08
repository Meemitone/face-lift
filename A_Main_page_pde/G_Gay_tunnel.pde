float gaySpin = 0;
float gayZpos = 0;

PImage gayPhoto;
PGraphics gayDrawing;
float gDBallposX = 0;
float gDBallposY = 0;

float gayLength = 10000;
int gayRingNum = 2; // with a background, the system only really allows a tunnel of total 10000 length before it cuts off, starts at 0, so 0 = 1 ring
float gayCount = 20;
float gayRectWidth;
float gayRadius = 500;
float gayPlaneWidth;
float gaySpiralSize = 0;
float gayScalar;



void gaySetup() // --------------------------------------------------------------------------------------------------------------------------------
{
  gayRectWidth = 2*gayRadius*tan(PI/gayCount);// decides how wide each rectangle is
  gayDrawing = createGraphics(int(gayRectWidth*gayCount), 500);
  gayPhoto = loadImage("Gay image.png"); // creates a photo which will be drawn with code
  
  gayPlaneWidth = gayRectWidth*gayCount; 
  gayScalar =gayPlaneWidth/3167.689; // for use in quick maffs
}









void gayDraw()// --------------------------------------------------------------------------------------------------------------------------------
{
  gayDrawing.beginDraw();
  gayDrawing.background(100);
  gDBallposX+=20;
  gDBallposY+=5;

  gDBallposX%=gayDrawing.width;
  gDBallposY%=gayDrawing.height;
  fill(0, 255, 255);
  gayDrawing.circle(gDBallposX, gDBallposY, 50); // draws on the photo variable
  gayDrawing.endDraw();
}







void gayRing(float gayDist) { // --------------------------------------------------------------------------------------------------------------------------------
  //  gaySpin += 0.01;

  pushMatrix();
  translate(width/2, height/2, -gayDist);
  rotateX(PI/2); // moves plane to center and back a bit
 // gayCount += 0.001;



  for (int i = 0; i < gayCount; i++)
  {

    pushMatrix();
    rotateY(-TWO_PI/gayCount * i + gaySpin);
    translate(0, 0, -gayRadius);
    translate(-gayRectWidth * i-1, 0, 0); // gets to position of rectangles --------

    noFill();
    //  fill(0);
    strokeWeight(8);
    stroke(0, 0, 100);
    //noStroke();
    rectMode(CENTER); // sets up rect


//      fill(i*20, 0, i*(255/gayCount));
      fill(0);
      rect(gayRectWidth * i, 0, gayRectWidth, gayLength); // draws rects -----------
 

    translate(0, 0, 1 + abs(ab.get(0)*100));
  //  image(gayPhoto,-gayRectWidth/2,0);
 //   image(gayDrawing, -gayRectWidth/2, 0); // applies the photo to the ring
 
   noStroke();
   fill(0);
   
   // zpos starts at 0 and goes to - 2*gayLength
 
   translate(( gayRectWidth * gayCount)  /3, gayLength/3 ,0);
   
//   circle(0,0, gaySpiralSize * 0.2);    // gets into place for spiral

   drawGaySpiral_1( gaySpiralSize * 0.2, 100);

    popMatrix();
  }
  popMatrix();
}





void drawGayTunnel()// --------------------------------------------------------------------------------------------------------------------------------
{

  //void gayRing(float gayDist, float gayRadius,   int gayCount = 12;){
    
  for (float i = gayZpos; i < gayLength*gayRingNum; i+=gayLength) // this draws each ring one after another, starting from ring #0, so i<gaylength*0 will give 1 ring
  {
    gayRing(i);
  }
  
  gayZpos-=40;
  if (gayZpos < -2*gayLength)
    gayZpos = 0;
//      println(gayZpos);
      
  gaySpiralSize = gayLength - abs(gayLength+gayZpos);
  
  println(gaySpiralSize);
}





void drawGaySpiral_1(float size, int circleNum)
{
  float Y=0;
  for(I=0;I<size;I+=gayLength/circleNum*0.2)
  {
    fill(-Y/10,255,255);
    Y -= 20;
    circle(0,Y,30);
    rotateZ(PI*2.3);

  }
  
  
  
}
