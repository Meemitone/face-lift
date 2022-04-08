float gaySpin = 0;
float gayZpos = 0;

PImage gayPhoto;
PGraphics gayDrawing;
float gDBallposX = 0;
float gDBallposY = 0;

float gayLength = 10000;
int gayRingNum = 2; // with a background, the system only really allows a tunnel of total 10000 length before it cuts off, starts at 0, so 0 = 1 ring
int gayCount = 20;
float gayRectWidth;
float gayRadius = 1000;

void gaySetup()
{
  gayRectWidth = 2*gayRadius*tan(PI/gayCount);// decides how wide each rectangle is
  gayDrawing = createGraphics(int(gayRectWidth*gayCount), 500);
  gayPhoto = loadImage("Gay image.png"); // creates a photo which will be drawn with code
}

void gayDraw()
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

void gayRing(float gayDist) {
  //  gaySpin += 0.01;

  pushMatrix();
  translate(width/2, height/2, -gayDist);
  rotateX(PI/2); // moves plane to center and back a bit




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

    for (I=0; I<gayCount; I++) {
      fill(I*20, 200, 100);
      rect(gayRectWidth * I, 0, gayRectWidth, gayLength); // draws rects -----------
    }

    translate(0, 0, 1);
  //  image(gayPhoto,-gayRectWidth/2,0);
 //   image(gayDrawing, -gayRectWidth/2, 0); // applies the photo to the ring
 
   translate(1000,0,0);
//   for(I = 0; I<gayZpos; I++)
//   {
//     noStroke();
//     fill(I/4,255,255);
     circle(0,0,-gayZpos);
//     rotateY(TWO_PI/20);
//   }
 
 

    popMatrix();
  }
  popMatrix();
}





void drawGayTunnel()
{

  //void gayRing(float gayDist, float gayRadius,   int gayCount = 12;){
    
  for (float i = gayZpos; i < gayLength*gayRingNum; i+=gayLength) // this draws each ring one after another, starting from ring #0, so i<gaylength*0 will give 1 ring
  {
    gayRing(i);
  }
  
  gayZpos-=40;
  if (gayZpos > gayLength)
    gayZpos = -gayLength;
    println(gayZpos);
}
