


float beatTotal = 0;
float avg = 0;
int beatTimer = 0; // used for beat detects
boolean isBeat = false;
int beatNum = 0;


void beatDetect(){
  
  for(I = 0; I < ab.size(); I++)   {  beatTotal += abs(ab.get(I));  } // gets the average volume from the buffer each frame
  
  avg = beatTotal/ab.size();
  beatTotal = 0;
  
  if(avg > 0.135 && beatTimer == 0){
    fill(0,255,255);
    beatTimer = beatTimeMin;
    isBeat = true;
    
  }else{
    beatTimer-=1;
    beatTimer = constrain(beatTimer,0,1000);  // ----------------detects beats (spikes in volume)
    fill(0);
    if(beatTimer == 0){fill(60,255,100);}
    isBeat = false;
  }
  
  
  if(isBeat == true){ beatNum += 1; }
  stroke(255);  textSize(15);
//  circle(50,50+beatTimer,50); fill(255); text(beatNum,40,57+beatTimer);  // ------------------------------------------------------beat indicator, put it in a comment to hide it----
}

void playMusic(){
if(ap.isPlaying() == false){ap.play();}
}
