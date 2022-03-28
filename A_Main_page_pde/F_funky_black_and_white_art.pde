float funkyBWSize=10;
float funkyBWCenterX = 0;
float funkyBWCenterY = 0;
float funkyBWRandomAngle = 0;
float funkyBWRandomDistance = 0;
float angleDiff = 0;
float sizeDiff = 0;
float verticalLineSize = 0;
float angleGrow = 0;
float funkyTilt = 0;

void drawFunkyBW(float hue, float brightness, float offsetX, float offsetY){
  funkyTilt += 0.001;
  
fill(hue);

funkyBWSize = 20 + abs(ab.get(0)*75); // size based off sound

pushMatrix();
translate(offsetX,offsetY,0); // offsets for the gold part
translate(funkyBWCenterX,funkyBWCenterY);
rotateX(funkyTilt);

stroke(0);

for(I=0;I<10;I++){
      verticalLineSize = random(0,500);
line(0+4 - verticalLineSize,0,    0+4- verticalLineSize,    0 -10 * funkyBWSize/ verticalLineSize*8);
line(0-4 + verticalLineSize,0,    0-4+ verticalLineSize,    0 +10 * funkyBWSize/ verticalLineSize*8); // black vertical lines generated from epicentre
}
stroke(hue,255,brightness);

line(0-2,0,    0-2,    0 -10 * funkyBWSize); // vertical up
line(0+2,0,    0+2,    0 +10 * funkyBWSize); // vertical epicentre down





stroke(random(10,40),255,random(150,255));
 
 if(isBeat){
    for(I=0;I<4;I++){ // ----------------horizontal line spams
  
      funkyBWRandomAngle = random(0,PI/4);
      funkyBWRandomDistance = random(60,600) + funkyBWSize; // randomizes the angle and sizes
      
      line(0,0,    0 + funkyBWRandomDistance * cos(-PI/8 + funkyBWRandomAngle) , 0 + funkyBWRandomDistance * sin(-PI/8 + funkyBWRandomAngle) ); // rhs line spam
  
      funkyBWRandomDistance = random(60,900) + funkyBWSize;
  
      line(0,0,    0 - funkyBWRandomDistance * cos(-PI/8 + funkyBWRandomAngle) , 0 - funkyBWRandomDistance * sin(-PI/8 + funkyBWRandomAngle) ); // lhs line spam
 }
}




 // ---------------setups for the circles
angleDiff += PI/800;
sizeDiff = 0;
angleDiff += abs(ab.get(0)/4); // decides how fast the circle turns and jitters in size

noFill();
stroke(hue,255,brightness);

drawFunkyCircle(100,PI/3,-1);
drawFunkyCircle(50,PI/4,3);
drawFunkyCircle(125,2*PI,2); // decides size and speed of circles


stroke(hue,0,brightness);
if(isBeat){stroke(40,255,255);}

  angleGrow += PI/1000;

drawFunkyArc(600,PI/4,-PI/2,1,1,0);
drawFunkyArc(900,PI/4,-PI/4,1,1,0);
drawFunkyArc(300,PI/4,-PI*0.8,1,1,-0);
drawFunkyArc(1200,PI/4,-PI,1,1,0);
drawFunkyArc(500,PI/4,PI/3,1,1,0);





popMatrix();
}






void drawFunkyCircle(float size, float angle, float angleDiffMultiplier) // draws rotating circles
{
  pushMatrix();
  translate(0,-funkyBWCenterY);
  rotateY(angle + angleDiff * angleDiffMultiplier);
  circle(size + sizeDiff*3,funkyBWCenterY,size + sizeDiff*3);
  popMatrix();
  
}

void drawFunkyArc(float size, float angleWidth, float rotateAngle, float heightMultiplier, float angleGrowMultiplier, float heightOffset)
{
  pushMatrix();
  translate(0,-funkyBWCenterY);
  rotateY(rotateAngle);
  
  size += abs(ab.get(0)*100);
  
  

  arc(size/2,funkyBWCenterY + heightOffset, size, size*heightMultiplier, PI-(angleWidth + angleGrow * angleGrowMultiplier), PI);
//arc(a, b, c, d, start, stop)
  
  popMatrix();
}
