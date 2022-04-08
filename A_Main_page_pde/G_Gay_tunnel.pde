float gaySpin = 0;
float gayZpos = -500;
PImage gayPhoto;

void gayRing(float gayDist, float gayRadius,  int gayCount){
//  gaySpin += 0.01; 
  
  pushMatrix();
  translate(width/2,height/2,-gayDist);
  rotateX(PI/2); // moves plane to center and back a bit
  

  float gayRectWidth = 2*gayRadius*tan(PI/gayCount);// deci
  
  for(int i = 0; i < gayCount; i++)
  {
    
  pushMatrix();
  rotateY(-TWO_PI/gayCount * i + gaySpin);
  translate(0,0,-gayRadius);
  translate(-gayRectWidth * i-1,0,0);
  
  noFill();
//  fill(0);
  strokeWeight(8);
  stroke(0,0,100);
//noStroke();
  rectMode(CENTER);
  
  for(I=0;I<gayCount;I++){
  fill(I*20,200,200);
  rect(gayRectWidth * I,0,gayRectWidth,500);
  }
  
  translate(0,0,1);
  image(gayPhoto,-gayRectWidth/2,0);
  
  
  popMatrix();
  }
  popMatrix();
}





void drawGayTunnel()
{

        //void gayRing(float gayDist, float gayRadius,   int gayCount = 12;){
        for(float i = gayZpos; i < 10000; i+=500)
        gayRing(i, 1000, 12);
        
        gayZpos-=40;
        if(gayZpos > 500)
        gayZpos = -500;
  
  
}
