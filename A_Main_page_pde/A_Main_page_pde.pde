import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioBuffer ab;
AudioInput ai;
AudioPlayer ap;
BeatDetect beat; // ----minim setups



// ----------------------------------------------------------------------------------------------customisables start----------------------------------------------------------------------------


int triangleNum = 383;
int headRandomSpawn = 1; // set to 0 for no random spawn effect

float headScale = 0.7;
float nodDistance = 0.5; // multiplier of distance moved by head nods, looks best at around 0.3 so far

float headWireframe = -1.5; // 2 for black borders, 0 for no borders, -2 for white borders.
float wireSize = 1; // stroke weight on the triangles
boolean headFill = true; // true for filled triangles, false for no fill

int headHue = 180; // Hue of the head, 147 is default

int beatTimeMin = 12; // 12 is stable, 20 is ideal but doesnt work



// ----------------------------------------------------------------------------------------------customisables end------------------------------------------------------------------------------



int U = 0; // stages of the programm
int I = 0; // int I for all loopy purposes
int frameNum = 0; // number of frames that have passed

boolean colourRandomiser = false; // this changes the hue of the head on every beat if it is true, set false to turn off


void setup(){ // -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - -  -  -  -  -  -  -  -  -  -  -  - start of void setup
  colorMode(HSB);
  fullScreen();
  println("Hello World"); // general screen setup, hello world goes at the start of each run, so we know which error report is from which run
  
  minim = new Minim(this);
  ap = minim.loadFile("Sweet Dreams.mp3");
  ab = ap.mix;   // regular minim setups

  initialiseTriangleOrder();// creates a shuffled intlist named triangleOrder, for use in randomising the spawning of head parts
} // -------------------------------------------------------------------------------------------------------------------------------end of void setup






void draw(){ // -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -start of void draw


  frameNum += 1;
 // background(0);  
  

  
switch(U)  {
  case 0:
        background(0);
        
        stroke(0,0,255);
        fill(0,0,255);
        textSize(50);
        textAlign(CENTER);
        text("click to start",width/2,height - 100); // click to start text
        
        if(mousePressed == true){U = 1;}
         
  break; // -----------------------------------------------------------------------------------------------------------
  
  case 1:  
        background(0);

        beatDetect(); // implements the beat detecter, visual circle can be turned off in music tab
        drawTriangles(450,  50,  abs(beatTimer - beatTimeMin/2)*2  ); // draws the head based on the settings given
        if(isHeadComplete == true){playMusic();}
        
        if(ap.position() > 8200){colourRandomiser = true;} // starts randomizing colour
        if(ap.position() > 21400 && zoomIn == false){zoomIn = true; eyeZoom = -0.001;} // zooms in at given time
        if(ap.position() > 27000){ U = 2; } // moves to next stage
        if(mousePressed == true){println(ap.position());} // prints position
        
  break;//--------------------------------------------------------------------------------------------------------------
  
  case 2:
        fill(0,0,0,30);
        rect(-1,-1,width+2, height+2);
        
        drawBlackHole((ap.position() - 27000.0)/5000.0); 
        playMusic();
        
  break;//--------------------------------------------------------------------------------------------------------------
  }
  
  
  
  
//  drawPoints(300,0);
} // ------------------------------------------------------------------------------------------------------------------------end of void draw
