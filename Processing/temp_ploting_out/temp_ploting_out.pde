import controlP5.*;
import java.nio.ByteBuffer;
import processing.serial.*;
Serial myPort;

float temps[];
String readserial;


/***********************************************
 * User spcification section
 **********************************************/
int windowWidth = 900;      // set the size of the 
int windowHeight = 600;     // form

float InScaleMin = 0;       // set the Y-Axis Min
float InScaleMax = 1024;    // and Max for both
float OutScaleMin = 0;      // the top and 
float OutScaleMax = 255;    // bottom trends


int windowSpan = 300000;    // number of mS into the past you want to display
int refreshRate = 100;      // how often you want the graph to be reDrawn;

//float displayFactor = 1; //display Time as Milliseconds
//float displayFactor = 1000; //display Time as Seconds
float displayFactor = 60000; //display Time as Minutes

String outputFileName = "temps.csv"; //data out filepath

/***********************************************
 * end user spec
 **********************************************/
 
/*  setup controlP5   */
ControlP5 CP5; //initialize controlP5 instance
CP5.Button savebutton, restartbutton; //define buttons
CP5.Textfield probe1field, probe2field, probe3field; //define fields
CP5.Textlabel savelabel, restartlabel, probe1label, probe2label, probe3label; //define labels for buttons and fields

PFont AxisFont, TitleFont;

void setup(){
  frameRate(30);
  size(windowWidth , windowHeight);
  
  probe1field = cP5.addTextfield(
  
  AxisFont = loadFont("axis.vlw");
  TitleFont = loadFont("Titles.vlw");
  
  
  setupserial(); //call serial setup function
}

void draw(){
}

void keypressed() {
  output.flush(); // Writes the remaining data to the file
  output.close();
  exit();
}
