float cewbRotate = 0;
int cewbCount = 20; // the number of cubes across one row
float cewbSpace = 20;
float[][][] cewbTimer;
float[][][] cewbSize;
float[][][] cewbLSize;
float[][][] cewbBrightness;
int cewbSaturation = 200;
int cewbHue = 200;

void initialiseCewb()
{
  cewbTimer = new float[cewbCount][cewbCount][cewbCount];
  cewbSize = new float[cewbCount][cewbCount][cewbCount];
  cewbLSize = new float[cewbCount][cewbCount][cewbCount];
  cewbBrightness = new float[cewbCount][cewbCount][cewbCount];
  
 for(int x=0;x<cewbCount;x++){
   for(int y=0;y<cewbCount;y++){
     for(int z=0;z<cewbCount;z++){
        cewbTimer[x][y][z] = 6;
        cewbSize[x][y][z] = cewbSpace/2;
        cewbSize[x][y][z] = cewbSpace/2;
        cewbBrightness[x][y][z] = 155;
     }
   }
 }
}


void drawCewb(){
  background(255);  
  pushMatrix();
  translate(width/2,height/2);
  rotateY(cewbRotate);
  rotateX(-radians(45));  
  rotateY(radians(45));

  stroke(0);
  noFill();
 // box(cewbCount*cewbSpace);
  
 noStroke(); 
  
  translate(-cewbSpace/2-cewbSpace*cewbCount/2,cewbSpace/2-cewbSpace*cewbCount/2,cewbSpace/2-cewbSpace*cewbCount/2); // moves to the back,top left box
  pushMatrix();
  for(int x=0;x<cewbCount;x++){
    translate( cewbSpace,0,0); // moves along the x axis
    
    pushMatrix();
    translate(0,-cewbSpace,0);
    
     for(int y=0;  y<cewbCount;  y++){
       translate(0,cewbSpace,0); // moves down the y axis
       
       pushMatrix();
       translate(0,0,-cewbSpace);
       
       for(int z=0; z<cewbCount; z++){
          translate(0,0,cewbSpace);   // generates a row along the z axis
          if(cewbTimer[x][y][z] < 0){
            cewbTimer[x][y][z] = random(3,5);
            cewbSize[x][y][z] = random(cewbSpace/10,cewbSpace*1.2); // if the cubes timer is lower than zero, randomise it and change the size
            cewbBrightness[x][y][z] = random(50,170);
          }
          else{
            cewbTimer[x][y][z] -= 0.1;
          }
          cewbLSize[x][y][z] = lerp(cewbLSize[x][y][z],cewbSize[x][y][z],0.1); // lerp the size to the other size
          
          fill(cewbHue,cewbSaturation,cewbBrightness[x][y][z]);
          stroke(x*15+y*15,255,255);
          
          box(cewbLSize[x][y][z]); // draw the cewbs
      }
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
  
  
 cewbRotate+=PI/(60*6);
  popMatrix();
}
