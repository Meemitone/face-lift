dust stormA;
dust stormB;

// dust(int count, float minRad, float maxRad, float minSize, float maxSize, float minCol, float maxCol, float delta, float rotat)

void setup()
{
  fullScreen(P3D);
  colorMode(3);
  background(0);
  stormA = new dust(1000, 50, 1000, 5,10,0,30,-0.005);
  stormB = new dust(1000, 50, 1000, 5,10,0,40,0.0025, PI/3);
}

void draw()
{
  //background(0);
  pushMatrix();
  translate(0,0,-1000);
  fill(0,0,0,10);
  rect(-1200,-600,width+2500,height+1200);
  popMatrix();
  translate(width/2,height/2);
  stormA.particles();
  stormA.update(0.125);
  rotateX(PI/3);
  stormB.particles();
  stormB.update(0.125);
}
