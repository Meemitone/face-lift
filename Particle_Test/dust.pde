class dust
{
  float[] size;
  PVector[] location;
  float[] clr;
  float xRotat; //the angle of the plane the dust is on (0, by default) (so that the rotation can be undone if desired) (put in another value if you so wish)
  float zRotat; // the rotation of the plane (changes with time)
  float dZRotat; //d is for delta
  
  //assume the dust is drawn from the center of it's plane after rotation
  
  dust(int count, float minRad, float maxRad, float minSize, float maxSize, float minCol, float maxCol, float delta, float rotat)
  {
    float range = maxRad-minRad;
    xRotat = rotat;
    dZRotat = delta;
    zRotat = 0;
    float diff = range/(float)count;
    location = new PVector[count];
    size = new float[count];
    clr = new float[count];
    
    for(int i = 0; i < count; i++)
    {
      location[i] = PVector.random2D();
      location[i].mult(minRad+diff*i);
      size[i] = map(minRad+diff*i, minRad, maxRad, minSize, maxSize); //currently, the inner ones are small and the outer ones are lorge
      clr[i] = map(minRad+diff*i, minRad, maxRad, minCol, maxCol);
    }
    
  }
  
  dust(int count, float minRad, float maxRad, float minSize, float maxSize, float minCol, float maxCol, float delta)
  { //This constructor is literally the same as above, but has no rotat set
    float range = maxRad-minRad;
    xRotat = 0;
    dZRotat = delta;
    zRotat = 0;
    float diff = range/(float)count;
    location = new PVector[count];
    size = new float[count];
    clr = new float[count];
    
    for(int i = 0; i < count; i++)
    {
      location[i] = PVector.random2D();
      location[i].mult(minRad+diff*i);
      size[i] = map(minRad+diff*i, minRad, maxRad, minSize, maxSize); //currently, the inner ones are small and the outer ones are lorge
      clr[i] = map(minRad+diff*i, minRad, maxRad, minCol, maxCol);
    }
  }

  void particles()
  {
    noStroke();
    pushMatrix();
    rotateZ(zRotat);
    for (int i=0; i<location.length; i++)
    {
      if(location[i].magSq()>1)
      {
      pushMatrix();
      translate(location[i].x, location[i].y);
      rotateX(-xRotat);

      fill(clr[i],200,255);
      circle(0, 0,size[i]);
      popMatrix();
      }
    }
    popMatrix();
  }
  
  void update(float mag)
  {
    //zRotat+=dZRotat;
    for (int i=0; i<location.length; i++)
    {
      PVector move = PVector.fromAngle(location[i].heading()+dZRotat);
      move.mult(location[i].mag());
      //move.mult(-1/move.mag()*mag);
      location[i] = (move);
      move = location[i].copy();
      move.mult(-1/move.mag()*mag);
      location[i].add(move);
    }
  }
}
