float gaySpin = 0;
float gayZpos = -1000;
PImage gayPhoto;

void gayRing(float gayDist, float gayRadius,  int gayCount){
//  gaySpin += 0.01; 
  
  pushMatrix();
  translate(width/2,height/2,-gayDist);


 // fill(0,255,100,100);

 // rect(0,0,gayRadius/5,gayRadius/2);
  
  rotateX(PI/2);
  


  float gayRectWidth = 2*gayRadius*tan(PI/gayCount);
  
  for(int i = 0; i < gayCount; i++)
  {
    
  pushMatrix();
  rotateY(-TWO_PI/gayCount * i + gaySpin);
  translate(0,0,-gayRadius);
  translate(-gayRectWidth * i-1,0,0);

  

  
  noFill();
//  fill(0);
  strokeWeight(8);
//  stroke(0,0,255);
noStroke();
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
