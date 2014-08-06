/*
Multiple Graphs Simultaneously
from http://www.objectdna.com/workshops/2011/10/29/graph-2-0/
but that example isn't actually fully written

here's a difffernt thing: http://teaching.ericforman.com/arduino-to-processing-multiple-sensors-serial-communication/

I took these and combined them to make a decent little utility
2014 A Quitmeyer Public Domain
*/

import processing.serial.*;
 
String delimiterBetweenMultipleValues = "|";
String delimiterBetweenLabelAndValue = ":";
 
int graphStartX = 100;
int textHeight = 15;
int textPadding = 2;
int circleDiameter = 3;
color backgroundColor = color(0, 0, 0, 255);
color graphHeadColor = color(255, 255, 255, 255);
color textColor = color(255, 255, 255, 255);
 
Serial myPort;        // The serial port
int opacity = 100;
 
String[] valuePairs;
 Oscil[] waves;
boolean drawPoint = false;
boolean drawCircle = true;
boolean drawLine = true;
int xPos = graphStartX;         // horizontal position of the graph

int partH;          // partial screen height

int valmin = 0;
int valmax=255;

int numserialreads=0;
boolean audioloaded =false;

/*
Adding Audio Output too, because sometimes you can't look at your sensor and the monitor at the same time
*/
//NOTE with audio, you have to make sure to hit the STOP button in processing (dont just close window)

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil       wavesingle;


 
void setup () {
  // set the window size. (Can be any size you want.  Width should be greater than 100, and height is
  // best when it's at least 32*number of streams)
  size(1200, 1000);        
    
  //Get Serial Setup
  println(Serial.list());
  // Open Serial port at 115200.
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.clear();
  myPort.bufferUntil('\n');
  background(0);
  
  
  //Audio stuff
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
//  wavesingle = new Oscil( 440, 0.5f, Waves.SINE );
//  // patch the Oscil to the output
//  wavesingle.patch( out );
  
}
 

 
void draw () {
  // everything happens in the serialEvent()
}
 
void keyPressed() {
  // If you press 'n'  RESET
  if (key == 'n') {
       xPos = 0;
        background(0);   // erase screen with black
  }

}
 
void serialEvent (Serial myPort) {

  // get the ASCII string:
  String inString = myPort.readStringUntil(10);

 
  if (inString != null) {
  //Throw away the first couple of serial reads cuz they funky sometimes
//TODO make not Hacky
    numserialreads++;

    // trim off any whitespace.
    inString = trim(inString);
    // Show the incoming data string.
    println(inString);
    // split the incoming string into pairs of label+value and store in an array.
    valuePairs = split(inString, delimiterBetweenMultipleValues);
    
    int totalinputs = valuePairs.length;
      partH = height / totalinputs;    // to divide screen up to draw the number of sensors


if (numserialreads==20){ //Reset all the stuff
         xPos = 0;
        background(0);   // erase screen with black
        loadAudio(totalinputs);
}
    
    
    //Parse each value pair for the label and the value
    for (int j=0; j<totalinputs; j++)
 {

   
 String[] pair;
 
 pair = split(valuePairs[j],delimiterBetweenLabelAndValue);
 
 String label;
 
 label = pair[0];
  text(label, 10, partH*(j+1) -10); 

pair[1]=trim(pair[1]);
 int value = int(pair[1]);
 // Write down that label on the axis
 
 //Map the value to the variable partial heights
 
     int graphvalue = int(map(value, valmin, valmax, 0, partH));

 
 //graph its value
// stroke(gimmeTheRightColorForSensorNumber(j));
 
 stroke(255,0,255);
 line(xPos, partH*(j+1), xPos, partH*(j+1)  - graphvalue);

 // draw dividing lines:
      stroke(255);
      line(0, partH*(j+1),   width, partH*(j+1));

  
//   //Audio stuff  

if(audioloaded){
  waves[j].setAmplitude( 0.5f);
  
 // float freq = map( mouseX, 0, width, 110, 880 );
 // 
 
  //Base note for this input 
  //Formula for notes is
 //fn = f0 * (a)^n      
  //a= 1.059463094359
  //fo is base note Starting at a low A (110 A2) 
  // n is number of half steps away for the desired note
  float freq = 220*pow(1.059463094359,j*9); //base note  //j*3 gives a chord-feel, but cramped space for audio
  
   freq = freq+ value; //Modulated with the changes of this input
  
  /*55*pow(2,j)  // Octaves base on A 
 + 55*2^(j+1) - 55*2^(j) ;  //choose a note in this octave

 */
 // I wonder if it makes more sense to do the graph value or the regular?
  waves[j].setFrequency( freq );
  ////
}

}


      // if at the edge of the screen, go back to the beginning:
      if (xPos >= width) {
        xPos = 0;
        background(0);   // erase screen with black
      } 
      else {
        xPos++;          // increment the graph's horizontal position
      }

  }
}

 
void exit() {
  myPort.stop();
}



void loadAudio(int inputs){
  //Audio Setup Stuff
waves= new Oscil[inputs];
  for (int j=0; j<inputs; j++)
 {
   waves[j]=new Oscil( 110*(j+1), 0.5f, Waves.SINE );
     waves[j].patch( out );
 }
audioloaded=true;
 }

color gimmeTheRightColorForSensorNumber (int sensorNumber) {
  color col;
  int modulo8 = (sensorNumber % 8);
  modulo8++;
  if (modulo8 == 0) {
    modulo8 = 6;
  }
  col = color( ((modulo8 >> 2) & 0x01)*255, ((modulo8 >> 1) & 0x01)*255, (modulo8 & 0x01)*255, opacity);
  return col;
}
