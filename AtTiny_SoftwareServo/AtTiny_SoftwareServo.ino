#include <SoftwareServo.h>  //IMPORTANT! You might need to change the SoftwareServo.h file to make it work with new Arduino

SoftwareServo servo;

int potpin = 0;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin 
void setup()
{ 
  servo.attach(0);}

void loop() {
  
  
   val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
  val = map(val, 0, 1023, 0, 179);     // scale it to use it with the servo (value between 0 and 180) 

    servo.write(val);
        
        SoftwareServo::refresh();//This row....
    delay(50);  
}
