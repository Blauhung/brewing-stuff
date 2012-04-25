




void drawGraph() {
  //gridlines
  stroke(0);
  strokeWeight(1);
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

    probe1Data[0] = int(probe1temp);
    probe2Data[0] = int(probe2temp);
    probe3Data[0] = int(probe3temp);
  }
  
  //draw lines
  strokeWeight(2);
  for (int i=0; i<nPoints-2; i++){
    int X1 = int(ioRight-2-float(i)*pointWidth);
    int X2 = int(ioRight-2-float(i+1)*pointWidth);
    boolean y1Above, y1Below, y2Above, y2Below;
    
    /* probe 1 */
    boolean drawLine=true;
    stroke(255,0,0);
    int Y1 = probe1Data[i];
    int Y2 = probe1Data[i+1];
    y1Above = (Y1>graphHeight); 
    y1Below = (Y1<0); 
    y2Above = (Y2>graphHeight); 
    y2Below = (Y2<0); 
    if(y1Above) {
      if(y2Above) drawLine=false;
      else if(y2Below) {
        Y1 = (int)graphHeight;
        Y2 = 0;
      }
      else Y1 = (int)graphHeight;
    }
    else if(y1Below){
      if(y2Below) drawLine=false;
      else if(y2Above) {
        Y1 = 0;
        Y2 = (int)graphHeight;
      }
      else Y1 = 0;
    }
    else {
      if(y2Below) Y2 = 0;
      else if(y2Above) Y2 = (int)graphHeight;
    }
    if(drawLine)
    {
      line(X1,Y1+graphTop, X2, Y2+graphTop);
    }
    
    /* probe 2 */
    drawLine=true;
    stroke(0,255,0);
    Y1 = probe2Data[i];
    Y2 = probe2Data[i+1];
    y1Above = (Y1>graphHeight); 
    y1Below = (Y1<0); 
    y2Above = (Y2>graphHeight); 
    y2Below = (Y2<0); 
    if(y1Above) {
      if(y2Above) drawLine=false;
      else if(y2Below) {
        Y1 = (int)graphHeight;
        Y2 = 0;
      }
      else Y1 = (int)graphHeight;
    }
    else if(y1Below){
      if(y2Below) drawLine=false;
      else if(y2Above) {
        Y1 = 0;
        Y2 = (int)graphHeight;
      }
      else Y1 = 0;
    }
    else {
      if(y2Below) Y2 = 0;
      else if(y2Above) Y2 = (int)graphHeight;
    }
    if(drawLine)
    {
      line(X1,Y1+graphTop, X2, Y2+graphTop);
    }
    
    /* probe 3 */
    drawLine=true;
    stroke(0,0,255);
    Y1 = probe3Data[i];
    Y2 = probe3Data[i+1];
    y1Above = (Y1>graphHeight); 
    y1Below = (Y1<0); 
    y2Above = (Y2>graphHeight); 
    y2Below = (Y2<0); 
    if(y1Above) {
      if(y2Above) drawLine=false;
      else if(y2Below) {
        Y1 = (int)graphHeight;
        Y2 = 0;
      }
      else Y1 = (int)graphHeight;
    }
    else if(y1Below){
      if(y2Below) drawLine=false;
      else if(y2Above) {
        Y1 = 0;
        Y2 = (int)graphHeight;
      }
      else Y1 = 0;
    }
    else {
      if(y2Below) Y2 = 0;
      else if(y2Above) Y2 = (int)graphHeight;
    }
    if(drawLine)
    {
      line(X1,Y1+graphTop, X2, Y2+graphTop);
    }
    
  }

}
