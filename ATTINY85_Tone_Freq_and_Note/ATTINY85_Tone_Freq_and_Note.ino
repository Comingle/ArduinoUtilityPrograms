// code for sound and led output on an ATtiny85
// Cleand up code from Kobakant
// using leah buechley’s sound code, taken from: http://web.media.mit.edu/~leah/LilyPad/07_sound_code.html
int speakerPin = 0;

void setup()
{
pinMode(speakerPin, OUTPUT);
}

void loop() {
beep(speakerPin, 2800, 1000);	//plays frequency of 2800 for 1 second
scale('E');	//plays note C for half a second
}

void scale (char note)
{
if(note == 'C')
beep(speakerPin,2093,500); //C: play the note C (C7 from the chart linked to above) for 500ms
if(note == 'D')
beep(speakerPin,2349,500); //D
if(note == 'E')
beep(speakerPin,2637,500); //E
if(note == 'F')
beep(speakerPin,2793,500); //F
if(note == 'G')
beep(speakerPin,3136,500); //G
if(note == 'A')
beep(speakerPin,3520,500); //A
if(note == 'B')
beep(speakerPin,3951,500); //B
if(note == 'H')
beep(speakerPin,4186,500); //C
}

void beep (unsigned char speakerPin, int frequencyInHertz, long timeInMilliseconds) // the sound producing function
{
int x;
long delayAmount = (long)(1000000/frequencyInHertz);
long loopTime = (long)((timeInMilliseconds*1000)/(delayAmount*2));
 for (x=0;x<loopTime;x++){
digitalWrite(speakerPin,HIGH);
delayMicroseconds(delayAmount);
digitalWrite(speakerPin,LOW);
delayMicroseconds(delayAmount);
//break;
}

}

