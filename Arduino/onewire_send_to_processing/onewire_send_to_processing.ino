/*-----( setup onewire )-----*/
#include <OneWire.h> //communication
#include <DallasTemperature.h> //read temperature
#define ONE_WIRE_BUS 2 //default pin 2
OneWire MyWireBus(ONE_WIRE_BUS); //start OneWire library using pin defined as bus
DallasTemperature sensors(&MyWireBus); //pass bus to DStemp library
const int NUM_TS=3;
float tempC[NUM_TS];
float temp1;
float tempF[NUM_TS];
int starttime, ttime;

/*----( setup LCD )----*/
#include <LiquidCrystal.h>
LiquidCrystal lcd(24,25,26,27,28,29); //init pins

int j = 1;


/*----( Main setup )----*/
void setup() {
  setuptemp();
  setupLCD(); 
  setupserial(); 
}

/*----( Main Loop )----*/
void loop() {
  
  starttime=millis(); //start loop timer
  
  updatetemp();
  updateLCD();
//  serialRecieve();
  serialSend();
  
  ttime=millis()-starttime; //end and print loop time
  lcd.setCursor(17,0);
  lcd.print(ttime);
}
