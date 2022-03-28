float funkyBWSize=10;
float funkyBWCenterX = 0;
float funkyBWCenterY = 0;
float funkyBWRandomAngle = 0;
float funkyBWRandomDistance = 0;
float angleDiff = 0;
float sizeDiff = 0;


void drawFunkyBW(float hue, float brightness, float offsetX, float offsetY){
  
fill(hue);
stroke(hue,255,brightness);
funkyBWSize = 20 + abs(ab.get(0)*75); // size based off sound

pushMatrix();
translate(offsetX,offsetY,0); // offsets for the gold part



line(funkyBWCenterX-2,funkyBWCenterY,    funkyBWCenterX-2,    funkyBWCenterY -10 * funkyBWSize);
line(funkyBWCenterX+2,funkyBWCenterY,    funkyBWCenterX+2,    funkyBWCenterY +10 * funkyBWSize); // vertical epicentre

stroke(0);
 
for(I=0;I<4;I++){
  
  funkyBWRandomAngle = random(0,PI/4);
  funkyBWRandomDistance = random(60,600) + funkyBWSize; // randomizes the angle and sizes

  line(funkyBWCenterX,funkyBWCenterY,    funkyBWCenterX + funkyBWRandomDistance * cos(-PI/8 + funkyBWRandomAngle) , funkyBWCenterY + funkyBWRandomDistance * sin(-PI/8 + funkyBWRandomAngle) ); // rhs line spam
  
  funkyBWRandomDistance = random(60,900) + funkyBWSize;
  
  line(funkyBWCenterX,funkyBWCenterY,    funkyBWCenterX - funkyBWRandomDistance * cos(-PI/8 + funkyBWRandomAngle) , funkyBWCenterY - funkyBWRandomDistance * sin(-PI/8 + funkyBWRandomAngle) ); // lhs line spam
  
}

pushMatrix();

translate(funkyBWCenterX,0);
angleDiff += PI/800;
sizeDiff = 0;
sizeDiff += random(-5,5); // decides how fast the circle turns and jitters in size

noFill();
stroke(hue,255,brightness);

drawFunkyCircle(100,PI/3,-1);
drawFunkyCircle(50,PI/4,3);
drawFunkyCircle(125,2*PI,2);

popMatrix();
popMatrix();
}

void drawFunkyCircle(float size, float angle, float angleDiffMultiplier)
{
  pushMatrix();
  rotateY(angle + angleDiff * angleDiffMultiplier);
  circle(size* 1.3 + sizeDiff,funkyBWCenterY,size + sizeDiff*3);
  popMatrix();
  
}
