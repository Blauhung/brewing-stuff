




void drawGraph(){
  //gridlines
  stroke(0);
  fill(230);
  rect(ioLeft, graphTop, ioWidth-1, graphHeight);
  
  //Section Titles
  stroke(210);
  textFont(TitleFont);
  fill(255);
  text("Temperature °C",(int)ioLeft+10,(int)graphTop-5);
  
  //GridLines and Titles
  textFont(AxisFont);
  
//horizontal grid lines
  int interval = (int)graphHeight/5;
  for(int i=0;i<6;i++){
    if(i>0&&i<5) line(ioLeft+1,graphTop+i*interval,ioRight-2,graphTop+i*interval);
    text(str((InScaleMax-InScaleMin)/5*(float)(5-i)+InScaleMin),ioRight+5,graphTop+i*interval+4);
  }
  
  //vertical grid lines and TimeStamps
  int elapsedTime = millis();
  interval = (int)ioWidth/vertCount;
  int shift = elapsedTime*(int)ioWidth / windowSpan;
  shift %=interval;

  int iTimeInterval = windowSpan/vertCount;
  float firstDisplay = (float)(iTimeInterval*(elapsedTime/iTimeInterval))/displayFactor;
  float timeInterval = (float)(iTimeInterval)/displayFactor;
  for(int i=0;i<vertCount;i++){
    int x = (int)ioRight-shift-2-i*interval;
    line(x,graphTop+1,x,graphTop+graphHeight-1);
    float t = firstDisplay-(float)i*timeInterval;
    if(t>=0)  text(str(t),x,graphTop+graphHeight+10);
  }
  
  //add data to array
  if(millis() > nextRefresh && madeContact)
  {
    nextRefresh += refreshRate;

    for(int i=nPoints-1;i>0;i--)
    {
      probe1Data[i]=probe1Data[i-1];
      probe2Data[i]=probe2Data[i-1];
      probe3Data[i]=probe3Data[i-1];
    }
    if (nPoints < arrayLength) nPoints++;

    probe1Data[0] = int(graphHeight)-int(graphHeight*(probe1temp-InScaleMin)/(InScaleMax-InScaleMin));
    probe2Data[0] = int(graphHeight)-int(graphHeight*(probe2temp-InScaleMin)/(InScaleMax-InScaleMin));
    probe3Data[0] = int(graphHeight)-int(graphHeight*(probe3temp-InScaleMin)/(InScaleMax-InScaleMin));
  }

}
