class dust
{
  float[] size;
  PVector[] location;
  float[] clr;
  float xRotat; //the angle of the plane the dust is on (0, by default) (so that the rotation can be undone if desired) (put in another value if you so wish)
  float zRotat; // the rotation of the plane (changes with time)
  float dZRotat; //d is for delta
  
  float spawnMin = 100, spawnMax = 500; //range in which particles can spawn
  float spawnCRMin, spawnCRMax; //colour range of spawned particles
  float spawnSMin = 10, spawnSMax = 10; //size range of spawned particles
    
  //assume the dust is drawn from the center of it's plane after rotation
  
  dust(int count, float minRad, float maxRad, float minSize, float maxSize, float minCol, float maxCol, float delta, float rotat)
  {
    /*
    each particle must spawn in at random times, then move according to the formula
      -there's initial ones, and ones that spawn in to beatdetection
    also the speed at which they are pulled in needs a steeper ramp
      -done (changed a number)
    reduce the verticle particle number by more than half, then make them bigger and brighter
      -issue with brightness, as 255 is the maximum and they're there already, upped sat instead
    
    speed up the horizontal particles
      -done (there's a number to adjust to your liking)
    
    we need to bring everything closer to the camera and make them smaller to make sure they dont dissappear behind the background
      -done, by moving the rect that was acting as bg backwards by a distance.
      
    make it so that on a trigger, they all shlorp in quite fast
      -done, but shlorp speed may need adjusting
    */
    
    float range = maxRad-minRad;
    spawnMax = maxRad;
//    println(spawnMax);
    spawnMin = minRad + 0.8*range;
//    println(spawnMin);
    spawnCRMax = maxCol;
    spawnCRMin = 0.8*(maxCol-minCol);
 //   println(spawnCRMax + " " + spawnCRMin);
    spawnSMin = minSize;
    spawnSMax = maxSize;
//    println(minSize + " " + spawnSMin + " " + maxSize + " " + spawnSMax);
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
      //size[i] = map(minRad+diff*i, minRad, maxRad, minSize, maxSize); //the inner ones are small and the outer ones are lorge
      size[i] = random(minSize, maxSize); //random distribution
      clr[i] = map(minRad+diff*i, minRad, maxRad, minCol, maxCol);
    }
    
  }
  
  dust(int count, float minRad, float maxRad, float minSize, float maxSize, float minCol, float maxCol, float delta)
  { //This constructor is literally the same as above, but has no rotat set
    float range = maxRad-minRad;
    spawnMax = maxRad;
  //  println(spawnMax);
    spawnMin = minRad + 0.8*range;
 //   println(spawnMin);
    spawnCRMax = maxCol;
    spawnCRMin = 0.8*(maxCol-minCol);
  //  println(spawnCRMax + " " + spawnCRMin);
    spawnSMin = minSize;
    spawnSMax = maxSize;
 //   println(minSize + " " + spawnSMin + " " + maxSize + " " + spawnSMax);
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
      //size[i] = map(minRad+diff*i, minRad, maxRad, minSize, maxSize); //the inner ones are small and the outer ones are lorge
      size[i] = random(minSize, maxSize); //random distribution
      clr[i] = map(minRad+diff*i, minRad, maxRad, minCol, maxCol);
    }
  }

  void particles()
  {
    noStroke();
    pushMatrix();
    rotateZ(zRotat);
    //println(location.length);
    for (int i=0; i<location.length; i++)
    {
      //println(i);
      if(location[i].magSq()>50)
      {
      pushMatrix();
      translate(location[i].x, location[i].y);
      rotateX(-xRotat);

      fill(clr[i],255,255);//colour
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
  
  void spawn(int count)
  {
    if(count<=0)
    return;
    PVector[] newloc = new PVector[count];
    float[] newcol = new float[count];
    float[] newsize = new float[count];
    for(int i = 0; i < count; i++)
    {
      newloc[i] = PVector.random2D();
      float dist = random(spawnMin, spawnMax);
      //print(dist + " ");
      newloc[i].mult(dist);
      //print(newloc[i].magSq());
      newcol[i] = map(dist, spawnMin, spawnMax, spawnCRMin, spawnCRMax);
      newsize[i] = random(spawnSMin, spawnSMax);
    }
    int counter = location.length + count;
    for(int i=0; i<location.length; i++)
    {
      if(location[i].magSq()<=25)
      counter--;
    }
    PVector[] updatedloc = new PVector[counter];
    float[] updatedcol = new float[counter];
    float[] updatedsize = new float[counter];
    int j = 0;
    for(int i=0; i<location.length; i++)
    {
      if(location[i].magSq()>25)
      {
        updatedloc[j] = location[i];//.copy();
        updatedcol[j] = clr[i];
        updatedsize[j] = size[i];
        j++;
      }
    }
    for(int i=0; i<count; i++)
    {
      //println(i + " " + j + " " + counter + " " + location.length);
      updatedloc[j] = newloc[i].copy();
      updatedcol[j] = newcol[i];
      updatedsize[j] = newsize[i];
      j++; 
    }
    /*
    location = new PVector[counter];
    for(int i=0; i<location.length; i++)
    {
      println(i);
    location[i] = updatedloc[i].copy();
    }
    */
    location = updatedloc;
    clr = updatedcol;
    size = updatedsize;
  }
  
  
  
  
  
  
  
  
}
