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



int U = 4; // stages of the programm
int beatTimeMin = 12; // 12 is stable, 20 is ideal but doesnt work



// ----------------------------------------------------------------------------------------------customisables end------------------------------------------------------------------------------




int I = 0; // int I for all loopy purposes
int frameNum = 0; // number of frames that have passed

boolean colourRandomiser = false; // this changes the hue of the head on every beat if it is true, set false to turn off


void setup(){ // -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - -  -  -  -  -  -  -  -  -  -  -  - start of void setup
  colorMode(HSB);
  fullScreen(P3D);
  println(width + " " + height); // usually 1920 x 1080
  println("Hello World"); // general screen setup, hello world goes at the start of each run, so we know which error report is from which run
  
funkyBWCenterX = 2*width/3;
funkyBWCenterY = height/2; // centerpoint of the funky shits

gayPhoto = loadImage("Gay image.png");
  
  minim = new Minim(this);
  ap = minim.loadFile("Sweet Dreams.mp3");
  ab = ap.mix;   // regular minim setups

  h1 = new Head (1,  0.7,  0.5,  -1.5,  1,  true,  180);
//Head(int headRandomSpawn, float headScale,  float nodDistance, float headWireframe, float wireSize, boolean headFill, int headHue)

if(U==0){ap.cue(0);}
if(U==1){ap.cue(0);}
if(U==2){ap.cue(27000);}
if(U==3){ap.cue(58040);}
if(U==4){ap.cue(92000);}

} // -------------------------------------------------------------------------------------------------------------------------------end of void setup

Head h1;




void draw(){ // -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -start of void draw


  frameNum += 1;
 // background(0);  
          if(mousePressed == true){println(ap.position());} // prints position        if(mousePressed == true){println(ap.position());} // prints position

  
switch(U)  {
  case 0: // ----------------------------------------------------------------------------------------------------menu
        background(0);
        
        stroke(0,0,255);
        fill(0,0,255);
        textSize(50);
        textAlign(CENTER);
        text("click to start",width/2,height - 100); // click to start text
        
        if(mousePressed == true){U = 1;}
         
  break; // -----------------------------------------------------------------------------------------------------------head
  
  case 1:  
        background(0);

        beatDetect(); // implements the beat detecter, visual circle can be turned off in music tab
        if(ap.position() > 27000){ U = 2; } // moves to next stage
        playMusic();

        h1.render();
        
  break;//--------------------------------------------------------------------------------------------------------------blackhole
  
  case 2:
        fill(0,0,0,30);
        rect(-1,-1,width+2, height+2);
        
        if(ap.position() < 52800){
        drawBlackHole((ap.position() - 27000.0)/5000.0); 
        }
        playMusic();
        
        if(ap.position() > 52800){ drawBlackHole(1 - ((ap.position() - 52800)/5240)); } // 5240
        if(ap.position() > 58040){background(150); U = 3; }
        // 0: 57 seconds into the song
        
  break;
  
  case 3://--------------------------------------------------------------------------------------------------------------funky scheisse-----------

        background(100);
        playMusic();
        
 //       void drawFunkyBW(float hue, float brightness, float offsetX, float offsetY){
        drawFunkyBW(0,0,0,0);
        drawFunkyBW(40,200,-2,-3);
        beatDetect();
        
        if(ap.position() > 92000){ U = 4; background(100); }       
  
  break;
  
  case 4://-----------------------------------------------------------------------------------------------------------------------gay circles mnnnnnnnnnnn ---------------------
  
        playMusic();

        background(0);
       
        
        for(float i = gayZpos; i < 10000; i+=500)
        
        //void gayRing(float gayDist, float gayRadius,   int gayCount = 12;){
        gayRing(i, 1000, 12);
        gayZpos-=40;
        if(gayZpos > 500)
        gayZpos = -500;
  break;
  }
  
  
  
  
//  drawPoints(300,0);
} // ------------------------------------------------------------------------------------------------------------------------end of void draw
