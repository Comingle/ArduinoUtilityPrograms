/*
  Blink All
  Blinks all the ports on an UNO
 */
 
// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int led = 13;
int loopspeed=300;
// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
for(int j=0; j<14;j++){
  pinMode(j, OUTPUT);

}  
  Serial.begin(9600);
  
}

// the loop routine runs over and over again forever:
void loop() {
Serial.println(led);
  digitalWrite(led, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(loopspeed);               // wait for a second
  digitalWrite(led, LOW);    // turn the LED off by making the voltage LOW
  delay(loopspeed);               // wait for a second
led++;
  if(led >13){led=0;}

}
