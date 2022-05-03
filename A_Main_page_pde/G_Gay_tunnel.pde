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
float gayPlaneWidth; // == 2*gayRadius*tan(PI/gayCount)*gayCount
float gaySpiralSize = 0;
float gayScalar;

float recurSize=0;
float len = 1250;//your max size is twice this (spiral)

void gaySetup() // --------------------------------------------------------------------------------------------------------------------------------
{
  gayRectWidth = 2*gayRadius*tan(PI/gayCount);// decides how wide each rectangle is
  gayDrawing = createGraphics(int(gayRectWidth*gayCount), 500);
  gayPhoto = loadImage("Gay image.png"); // creates a photo which will be drawn with code
  
  gayPlaneWidth = gayRectWidth*gayCount;  
  gayScalar =gayPlaneWidth/3167.689; // for use in quick maffs
  println(gayPlaneWidth);
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
    gaySpin += 0.001;
  
 float num = 750+750*sin(frameCount*TWO_PI/1000);
   recurSize = len+len*sin(frameCount/100f*PI); // these are used as oscilating sizes for the spirals
   
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


    strokeWeight(8);
    stroke(0, 0, 100);
    noStroke();
    fill(10);
 // fill(i*20, 0, i*(255/gayCount));
    rectMode(CENTER); // sets up rect
    rect(gayRectWidth * i, 0, gayRectWidth, gayLength); // draws rects -----------
      
      
      
      
      
//   translate(0, 0, abs(ab.get(0)*200));  // bops the spirals


    translate(( gayRectWidth * gayCount)  /3, gayLength/3 ,1);
    
    noStroke();
    fill(200,255,255);
    pushMatrix()    ;
        rotate(1*gaySpin);
    drawGaySpiral_1( gaySpiralSize * 0.2, 100); // moves to and then draws first spiral
    popMatrix();
    
    translate(1000,5000);  
pushMatrix()    ;
    strokeWeight(1);
    fill(150,255,255);
    noStroke();
    rotate(-2*gaySpin);
    art(num,0); // draws the second spiral
popMatrix();
    
    translate(300,3000);  
    rotate(-PI/2);
    recur(recurSize,750,5,0,0,0,20);

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
  
  gayZpos-=20;
  if (gayZpos < -2*gayLength)
    gayZpos = 0;
//      println(gayZpos);
      
  gaySpiralSize = gayLength - abs(gayLength+gayZpos);
  
}














void drawGaySpiral_1(float size, int circleNum) // ----------------------------------- 1
{
  pushMatrix();
  float Y=0;
  for(I=0;I<size;I+=gayLength/circleNum*0.1)
  {
//    fill(-Y/10,255,255);
    Y -= 10;
    circle(0,Y,30);
    rotateZ(PI*1.1);

  }
  popMatrix();
}



void art(float radius, float theta) // -------------------------------------- 2
{
  float t = theta;
  for(float i = 0; i < radius; i+=10)
  {
    float x,y;
 x = i*sin(t);
 y = i*-cos(t);

 circle(x,y,20);

 t += 0.08;
  }
}






void recur(float distrem, float armdist, int segmentation, float x, float y, float angle, float colour) //------------------------------------------- 3
{
  stroke(colour, 255,255);
  float drawlen;
  if (distrem<=armdist)
  drawlen = distrem;
  else
  drawlen = armdist;
  
  float x2 = x + drawlen * cos(angle);
  float y2 = y + drawlen * sin(angle);
  line(x,y,x2,y2);
  if(distrem<=armdist)
  return;
  
  for(int i = 1; i < segmentation; i++)
  {
    recur(distrem-armdist, armdist, segmentation, x2, y2, angle+TWO_PI/float(segmentation)*i+PI, (colour+20)%255);
  }
}
