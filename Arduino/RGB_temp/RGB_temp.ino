/* YourDuino Electronic Brick Test
Temperature Sensor DS18B20
- Connect cable to Arduino Digital I/O Pin 2
terry@yourduino.com */

/*-----( Import needed libraries )-----*/
#include <OneWire.h>
#include <DallasTemperature.h>

/*-----( Declare Constants )-----*/
#define ONE_WIRE_BUS 2 /*-(Connect to Pin 2 )-*/

/*-----( Declare objects )-----*/
/* Set up a oneWire instance to communicate with any OneWire device*/
OneWire ourWire(ONE_WIRE_BUS);

/* Tell Dallas Temperature Library to use oneWire Library */
DallasTemperature sensors(&ourWire);

/*-----( Declare Variables )-----*/
int redPin = 10;
int bluePin = 8;
int greenPin = 9;

int redVal;
int greenVal;
int blueVal;

float cel;
float far;
float maxfar;
float minfar;
float tempcolor;


void setup() /*----( SETUP: RUNS ONCE )----*/
{
/*-(start serial port to see results )-*/
redVal = 255;
greenVal = 255;
blueVal = 255;
maxfar = 73;
minfar = 72;
tempcolor = 100;

delay(1000);
Serial.begin(9600);
Serial.println("YourDuino.com: Electronic Brick Test Program");
Serial.println("Temperature Sensor DS18B20");
delay(1000);

/*-( Start up the DallasTemperature library )-*/
sensors.begin();
}/*--(end setup )---*/

// This function updates the LED outputs.
void update()
{
  analogWrite(redPin, redVal);
  analogWrite(greenPin, greenVal);
  analogWrite(bluePin, blueVal);
  delay(10);
}

void loop() /*----( LOOP: RUNS CONSTANTLY )----*/
{
Serial.println();
Serial.print("Requesting temperature...");
sensors.requestTemperatures(); // Send the command to get temperatures
Serial.println("DONE");
cel=sensors.getTempCByIndex(0);
far=sensors.getTempFByIndex(0);

Serial.print("Device 1 (index 0) = ");
Serial.print(cel);
Serial.println(" Degrees C");
Serial.print("Device 1 (index 0) = ");
Serial.print(far);
Serial.println(" Degrees F");
if (far > maxfar){
  maxfar = far;
}
if (far < minfar){
  minfar = far;
}
tempcolor = (far-minfar)/((maxfar-minfar)/255);
Serial.print("Tempcolor =");
Serial.print(tempcolor);
Serial.print(" min =");
Serial.print(minfar);
Serial.print(" max =");
Serial.println(maxfar);
blueVal=tempcolor;
redVal=255-tempcolor;
update();
  
}/* --(end main loop )-- */

/* ( THE END ) */
