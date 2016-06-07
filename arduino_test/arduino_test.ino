#include <MIDI.h>


//unsigned long tmp;

unsigned long send_data[8];

void setup() {
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
//Serial.begin(9600);
  //tmp = 1238940914;
 // dataout((analogRead(0)*25)+500);

  MIDI.begin();
  MIDI.setInputChannel(MIDI_CHANNEL_OMNI);
  
}

void loop() {

 uint8_t ch,data1,data2,Channel;

  if (MIDI.read()) {
    //MIDI.setInputChannel(1);
    
    switch (MIDI.getType()) {
      case NoteOn:
        data1 = MIDI.getData1();    // note no
        data2 = MIDI.getData2();    // velocity
        ev_noteon(MIDI.getChannel(), data1);
        break;
      case NoteOff:
        data1 = MIDI.getData1();    // note no
        ev_noteoff(MIDI.getChannel(), data1);
        break;
      case ControlChange:
        data1 = MIDI.getData1();
        switch (data1){
          case 120: //All Sound Off
          case 123: //All Notes Off
            ev_allnoteoff();
            break;
        }
        break;
      case Stop:
        ev_allnoteoff();
        break;
    }


  }

  unsigned long ontime1;
  unsigned long ontime2;
  ontime1 = (analogRead(0)*25)+500;
  ontime2 = (analogRead(3)*25)+500;
  unsigned long offtime1;
  unsigned long offtime2;
  offtime1 = (analogRead(1));
  offtime2 = (analogRead(4));
  dataout(ontime1,ontime2,offtime1,offtime2,0,0,0,0,0);

  unsigned long gen0lim;
  unsigned long gen4lim;
  gen0lim = ((unsigned long)(1023 - analogRead(2)) * 2000) + 100000;
  gen4lim = ((unsigned long)(1023 - analogRead(5)) * 2000) + 100000;
  //dataout(gen0lim,0,0,0,gen4lim,0,0,0,1);
  //Serial.println(gen0lim);
}

void ev_noteon(byte ch, byte note){
  unsigned long freq;
  freq = 440.0 * pow(2.0, (note - 69.0) / 12.0);
  freq = 50000000/freq;
  send_data[ch] = freq;
  dataout(send_data[0],send_data[1],send_data[2],send_data[3],send_data[4],send_data[5],send_data[6],send_data[7],1);
}

void ev_noteoff(byte ch, byte note){
  send_data[ch] = 0;
  dataout(send_data[0],send_data[1],send_data[2],send_data[3],send_data[4],send_data[5],send_data[6],send_data[7],1);
}

void ev_allnoteoff(){
  dataout(0,0,0,0,0,0,0,0,1);
}

void dataout(
  unsigned long data1,
  unsigned long data2,
  unsigned long data3,
  unsigned long data4,
  unsigned long data5,
  unsigned long data6,
  unsigned long data7,
  unsigned long data8,
  byte mode){

byte d1[4];
d1[0] = data1;
data1 = data1 >> 8;
d1[1] = data1;
data1 = data1 >> 8;
d1[2] = data1;
data1 = data1 >> 8;
d1[3] = data1;

byte d2[4];
d2[0] = data2;
data2 = data2 >> 8;
d2[1] = data2;
data2 = data2 >> 8;
d2[2] = data2;
data2 = data2 >> 8;
d2[3] = data2;

byte d3[4];
d3[0] = data3;
data3 = data3 >> 8;
d3[1] = data3;
data3 = data3 >> 8;
d3[2] = data3;
data3 = data3 >> 8;
d3[3] = data3;

byte d4[4];
d4[0] = data4;
data4 = data4 >> 8;
d4[1] = data4;
data4 = data4 >> 8;
d4[2] = data4;
data4 = data4 >> 8;
d4[3] = data4;

byte d5[4];
d5[0] = data5;
data5 = data5 >> 8;
d5[1] = data5;
data5 = data5 >> 8;
d5[2] = data5;
data5 = data5 >> 8;
d5[3] = data5;

byte d6[4];
d6[0] = data6;
data6 = data6 >> 8;
d6[1] = data6;
data6 = data6 >> 8;
d6[2] = data6;
data6 = data6 >> 8;
d6[3] = data6;

byte d7[4];
d7[0] = data7;
data7 = data7 >> 8;
d7[1] = data7;
data7 = data7 >> 8;
d7[2] = data7;
data7 = data7 >> 8;
d7[3] = data7;

byte d8[4];
d8[0] = data8;
data8 = data8 >> 8;
d8[1] = data8;
data8 = data8 >> 8;
d8[2] = data8;
data8 = data8 >> 8;
d8[3] = data8;

switch(mode) {
  case 0:
    digitalWrite(12, LOW);
    digitalWrite(13, LOW);
    break;
  case 1:
    digitalWrite(12, LOW);
    digitalWrite(13, HIGH);
    break;
}

digitalWrite(11, HIGH);
byteout(d1[0]);
digitalWrite(11, LOW);
byteout(d1[1]);
byteout(d1[2]);
byteout(d1[3]);
byteout(d2[0]);
byteout(d2[1]);
byteout(d2[2]);
byteout(d2[3]);
byteout(d3[0]);
byteout(d3[1]);
byteout(d3[2]);
byteout(d3[3]);
byteout(d4[0]);
byteout(d4[1]);
byteout(d4[2]);
byteout(d4[3]);
byteout(d5[0]);
byteout(d5[1]);
byteout(d5[2]);
byteout(d5[3]);
byteout(d6[0]);
byteout(d6[1]);
byteout(d6[2]);
byteout(d6[3]);
byteout(d7[0]);
byteout(d7[1]);
byteout(d7[2]);
byteout(d7[3]);
byteout(d8[0]);
byteout(d8[1]);
byteout(d8[2]);
byteout(d8[3]);
}


void byteout(byte data){

digitalWrite(2, bitRead(data,0));
digitalWrite(3, bitRead(data,1));
digitalWrite(4, bitRead(data,2));
digitalWrite(5, bitRead(data,3));
digitalWrite(6, bitRead(data,4));
digitalWrite(7, bitRead(data,5));
digitalWrite(8, bitRead(data,6));
digitalWrite(9, bitRead(data,7));

// WriteEnable
delayMicroseconds(10);
digitalWrite(10, HIGH);
delayMicroseconds(10);
digitalWrite(10, LOW);

}

