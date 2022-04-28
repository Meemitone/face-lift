float blackHoleAngle = PI/2.2;
float blackHoleBop = 0;
boolean blackHoleShrink = false;
boolean BHend = false;
boolean BHsetup = true;
dust stormA;
dust stormB;


void drawBlackHole(float blackHoleSize){
  if(BHsetup)
  {
    //on first call of drawBlackHole, make the particle storm objects
    BHsetup = false;
  stormA = new dust(0, 50, 1000, 3,18,0,50,-0.005); //(int count, float minRad, float maxRad, float minSize, float maxSize, float minCol, float maxCol, float delta, float rotat)
  stormB = new dust(400, 50, 1000, 3,10,0,60,0.0025, blackHoleAngle);
  }
  
blackHoleBop = 0 + abs(ab.get(0)*500); // black hole size based off sound
  
  blackHoleSize = constrain(blackHoleSize,0,1);
  
 
  for(I=0;I<100;I++){
    stroke(random(5,45),255,random(150,255),100);  
    line(width/2, height/2 + random(-100,+100)*blackHoleSize,  width/2 + random(-300,300)*blackHoleSize,height/2); // short lines
  }
 /* for(I=0;I<150;I++){
    stroke(random(0,35),255,random(150,255),50);  
    line(width/2,height/2 + (random(-50,50))*blackHoleSize,  width/2 + random(-600,600) * blackHoleSize,height/2); // long lines
  }*/
  
  
pushMatrix(); // saves matrix position
translate(width/2,height/2); // moves origin point to center of screen



  fill(0);
  translate(0,0,1);
  circle(0,0,(200 + blackHoleBop)*blackHoleSize); // black circle
  sphere((200 + blackHoleBop)*blackHoleSize/2); // does a sphere
  translate(0,0,-1);
  
noFill();

  for(I=0;I<40;I++){
    
    rotate(random(0,PI));
    stroke(random(5,45),255,random(150,255),150);
    
    ellipse(0,0,(200+blackHoleBop)*blackHoleSize,  random((200+blackHoleBop)*blackHoleSize,(300+blackHoleBop)*blackHoleSize)  ); // orange circles
    }
popMatrix();    

pushMatrix(); // saves matrix position
translate(width/2,height/2,2); // moves origin point to center of screen // this is repeated to stop the rotations    
rotateX(blackHoleAngle);

  for(I=0;I<40;I++){
    stroke(random(5,45),255,random(150,255),150);
    circle(0,0,  random((300+blackHoleBop)*blackHoleSize,  (700+blackHoleBop)*blackHoleSize)); // horizontal circles
  }
/*  for(I=0;I<40;I++){
    stroke(random(5,45),255,random(150,255),150);
    arc(0,0,  random((300+blackHoleBop)*blackHoleSize,  (700+blackHoleBop)*blackHoleSize),random(50,100)*blackHoleSize  ,0,  PI); // front half elipse
  }
  */
popMatrix();


//particles portion
pushMatrix();
  translate(0,0,-1000);
  fill(0,0,0,10);
  rect(-1200,-600,width+2500,height+1200);
  popMatrix();
  pushMatrix();
  translate(width/2,height/2);
  stormA.particles();
  if(BHend)
  stormA.update(6);//this is the run for the finish bit
  else
  {stormA.update(blackHoleBop/100);//this is the number for speed
  stormA.spawn(int(blackHoleBop/100));}
  //rotateX(blackHoleAngle);
  stormB.particles();
  if(BHend)
  {
  stormB.update(6);
  }
  else
  {
  stormB.update(blackHoleBop/100);
  stormB.spawn(int(blackHoleBop/100));
  }
  popMatrix();

noStroke();
}
