float cewbRotate = 0;
int cewbCount = 5; // the number of cubes across one row
float cewbSpace = 100;


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
  
  
  
  translate(-cewbSpace/2-cewbSpace*cewbCount/2,cewbSpace/2-cewbSpace*cewbCount/2,cewbSpace/2-cewbSpace*cewbCount/2); // moves to the back,top left box
  pushMatrix();
  for(I=0;I<cewbCount;I++){
    translate( cewbSpace,0,0); // moves along the x axis
    
    pushMatrix();
    translate(0,-cewbSpace,0);
    
     for(int y=0;  y<cewbCount;  y++){
       translate(0,cewbSpace,0); // moves down the y axis
       
       pushMatrix();
       translate(0,0,-cewbSpace);
       
       for(int z=0; z<cewbCount; z++){
          translate(0,0,cewbSpace);   // generates a row along the z axis
          
          fill(0,0,z*30);
          stroke(I*15+y*15,255,255);
          box(cewbSpace/2);
      }
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
  
  
 cewbRotate+=PI/(60*1);
  popMatrix();
}
