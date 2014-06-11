	
// Example by Tom Igoe

import processing.serial.*;

Serial myPort;  // The serial port

PFont f;                          // STEP 2 Declare PFont variable
String inBuffer;

String evil;
String good;
String alright;
int goodness=-1;

String Rating;

void setup() {
  // List all the available serial ports
  println(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, "COM7", 9600);
  
  size(1200,1000);
    background(255);

  f = createFont("Arial",100,true); // STEP 3 Create Font
  inBuffer = "Hello";
  evil ="004D8BB20D79";
   good = "690025EC51F1";
   alright = "6A008FAC4F06";
Rating = "Scan to see evil or good";

}

void draw() {

  background(0,240,255);
  textFont(f,16);                 // STEP 4 Specify font to be used
  fill(0);                        // STEP 5 Specify font color 
  textSize(60);

//  text(inBuffer,10,100);  // STEP 6 Display Text
  text("Scan to see good or evil!",10,100);  // STEP 6 Display Text

 inBuffer = myPort.readStringUntil(10);   
    if (inBuffer != null) {
      println(inBuffer);
        text(inBuffer,10,100);  // STEP 6 Display Text

    }
    else{inBuffer = "nothing";}
    

  
  if(inBuffer.indexOf(good)!=-1) {
goodness=1;
  }
  
    if(inBuffer.indexOf(evil)!=-1) {
      goodness=0;
    }
   if(inBuffer.indexOf(alright)!=-1) {
      goodness=2;
    }
  
  
  if(goodness ==0){
    
           textSize(180);
fill(255,0,0);
      text("EVIL",40,400);  // STEP 6 Display Text


  }
  
  else if(goodness==1){
           textSize(150);
fill(0,0,255);
      text("GOOD",40,400);  // STEP 6 Display Text
  }
    else if(goodness==2){
           textSize(150);
fill(0,0,255);
      text(" It's Alright",40,400);  // STEP 6 Display Text
  }
  else{
    
               textSize(80);
fill(0,255,255);
//      text("Scan to see good or evil",40,400);  // STEP 6 Display Text
    
  }

}


