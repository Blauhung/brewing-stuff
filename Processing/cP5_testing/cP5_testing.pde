import controlP5.*;


/***********************************************
 * User spcification section
 **********************************************/
int windowWidth = 900;      // set the size of the 
int windowHeight = 600;     // form

float InScaleMin = 15;       // set the Y-Axis Min
float InScaleMax = 35;    // and Max for both
float OutScaleMin = 0;      // the top and 
float OutScaleMax = 255;    // bottom trends


int windowSpanMin = 60, // number of minutes into the past you want to display
    windowSpan = windowSpanMin * 60000;    
int refreshRate = 100;      // how often you want the graph to be reDrawn;

//float displayFactor = 1; //display Time as Milliseconds
//float displayFactor = 1000; //display Time as Seconds
float displayFactor = 60000; //display Time as Minutes

//other declared variables
int nextRefresh; //sets refresh rate counter
int arrayLength = windowSpan / refreshRate+1;
int[] probe1Data = new int[arrayLength];     //temperature arrays
int[] probe2Data = new int[arrayLength];  
int[] probe3Data = new int[arrayLength];

float graphTop = 25;
float graphHeight = (windowHeight-70);
//float outputTop = inputHeight+50;
//float outputHeight = (windowHeight-70)*1/3;

float ioLeft = 150, ioWidth = windowWidth-ioLeft-50;
float ioRight = ioLeft+ioWidth;
float pointWidth= (ioWidth)/float(arrayLength-1);
int vertCount = 10;

/***********************************************
 * end user spec
 **********************************************/
 
int nPoints =0;
int debugcount = 0;
float probe1temp, probe2temp, probe3temp; //declare temps
boolean madeContact = false, justSent = true, firstrun=true; //declare comm bools

 
/*  setup controlP5   */
ControlP5 cP5; //initialize controlP5 instance
controlP5.Button savebutton, restartbutton; //define buttons
controlP5.Textfield probe1field, probe2field, probe3field; //define fields
controlP5.Textlabel savelabel, restartlabel, probe1label, probe2label, probe3label; //define labels for buttons and fields


PFont AxisFont, TitleFont;


void setup(){
  frameRate(30);
  size(windowWidth , windowHeight);
  
  AxisFont = loadFont("axis.vlw");
  TitleFont = loadFont("Titles.vlw");
  
  cP5 = new ControlP5(this);
  probe1field = cP5.addTextfield("Probe 1")
     .setPosition(10,20)
     .setSize(100,20)
     .setFont(TitleFont)
     .setFocus(true)
     .setColor(color(255,0,0));
  
  probe2field = cP5.addTextfield("Probe 2")
     .setPosition(10,60)
     .setSize(100,20)
     .setFont(TitleFont)
     .setFocus(true)
     .setColor(color(0,255,0));
  
  probe3field = cP5.addTextfield("Probe 3")
     .setPosition(10,100)
     .setSize(100,20)
     .setFont(TitleFont)
     .setFocus(true)
     .setColor(color(0,0,255));
     
  savebutton = cP5.addButton("Save_Data")
     .setValue(0.0)
     .setPosition(10,560)
     .setSize(100,20);
  
  restartbutton = cP5.addButton("Restart_Acquisition")
     .setValue(0.0)
     .setPosition(10,520)
     .setSize(100,20);







  nextRefresh=millis();
  
 // setupserial(); //call serial setup function
}

void draw(){
  background(0);
  fill(255);
  
  print("run ");
  println(debugcount);
  fakeData();
  
  drawGraph();
  
  
  debugcount++;
}


void fakeData(){
  
  if (debugcount==0) {
    probe1temp=20;
    probe2temp=25;
    probe3temp=16;
    firstrun=false;
    print("first run: ");
  }
  if (debugcount>0){
    if (probe1temp <= 20){
      probe1temp += random(-0.2,1);
      //print("probe1 low");
    }
    if (probe1temp > 20 && probe1temp < 30) {
      probe1temp += random(-1,1);
      //print("probe1 med");
    }
    if (probe1temp >= 30) {
      probe1temp += random(-1,0.2);
      //print("probe1 high");
    }
    
    if (probe2temp <= 20){
      probe2temp += random(-0.2,1);
    }
    if (probe2temp > 20 && probe2temp < 30) {
      probe2temp += random(-1,1);
    }
    if (probe2temp >= 30) {
      probe2temp += random(-1,0.2);
    }
    
    if (probe3temp <= 20){
      probe3temp += random(-0.2,1);
    }
    if (probe3temp > 20 && probe3temp < 30) {
      probe3temp += random(-1,1);
    }
    if (probe3temp >= 30) {
      probe3temp += random(-1,0.2);
    }
    
  }
  probe1field.setText(nf(probe1temp,2,2));
  probe2field.setText(nf(probe2temp,2,2));
  probe3field.setText(nf(probe3temp,2,2));
      
}

/*
void Save_Data(){
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}

void Restart_Acquisition(){
  //--- setup serial comm with arduino 
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.bufferUntil(10);
  if (outputFileName!="") {
    output = createWriter(outputFileName);
    output.println("millis,label,row,probe1,probe2,probe3");
  }
}
*/
