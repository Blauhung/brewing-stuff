/*-----( setup onewire )-----*/
#include <OneWire.h> //communication
#include <DallasTemperature.h> //read temperature
#define ONE_WIRE_BUS 2 //default pin 2
OneWire MyWireBus(ONE_WIRE_BUS); //start OneWire library using pin defined as bus
DallasTemperature sensors(&MyWireBus); //pass bus to DStemp library
const int NUM_TS=3;
float tempC[NUM_TS];
float tempF[NUM_TS];
int starttime, ttime;

/*----( setup LCD )----*/
#include <LiquidCrystal.h>
LiquidCrystal lcd(24,25,26,27,28,29); //init pins


void tempInit() {
  MyWireBus.reset();
  sensors.begin();
}

void updatetemp() {
  Serial.print("Requesting temperature...");
  sensors.requestTemperatures(); // Send the command to get temperatures
  Serial.println("DONE");	
  for (int i=0; i<NUM_TS; i++) {
    tempC[i]=sensors.getTempCByIndex(i);
    tempF[i] =(tempC[i]*1.8)+32;
    Serial.print("C=");
    Serial.print(tempC[i]);
    Serial.print("  F=");
    Serial.println(tempF[i]);
  }
}

void setupLCD() {
  lcd.begin(20,4);
  lcd.clear();
  lcd.home();
  lcd.print("Tony's Temps        ");
}

void updateLCD() {
  lcd.setCursor(0,1);
  lcd.print("probe1 probe2 probe3");
  for (int i=0; i<NUM_TS; i++) {
    lcd.setCursor(i*7,2);
    lcd.print(tempC[i]);
    lcd.print("C");
    lcd.setCursor(i*7,3);
    lcd.print(tempF[i]);
    lcd.print("F");
  }
}
  
void setup() {
  Serial.begin(9600);
  Serial.println("Tony's temp test");
  tempInit();
  setupLCD();  
}

void loop() {
  starttime=millis();
  updatetemp();
  updateLCD();
  ttime=millis()-starttime;
  Serial.print("Time elapsed=");
  Serial.println(ttime);
  lcd.setCursor(17,0);
  lcd.print(ttime);
}
