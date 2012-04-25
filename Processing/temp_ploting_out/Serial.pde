void setupserial(){
  /*--- setup serial comm with arduino ---*/
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.bufferUntil(10);
  if (outputFileName!="") {
    output = createWriter(outputFileName);
    output.println("millis,label,row,probe1,probe2,probe3");
}




//take the string the arduino sends us and parse it
void serialEvent(Serial myPort)
{
  println("event recieved");
  readserial = myPort.readStringUntil(10);
  println(readserial);
  if(outputFileName!="") {
    output.print(str(millis())+ ","+readserial);
  }
  String[] s = split(readserial, ",");
  int j = int(s[1]);
  print(j);
  print(" ");
  println(s.length);
  float probe1=float(s[2]);
  float probe2=float(s[3]);
  float probe3=float(s[4]);
  print(probe1);
  print(" ");
  print(probe2);
  print(" ");
  println(probe3);
  if (j>=10) {
    println("break");
    output.flush(); // Writes the remaining data to the file
    output.close();
    exit();
  }
  else {
    println("no");
  }
}



/*--- comented out as not sending yet


// Sending Floating point values to the arduino
// is a huge pain.  if anyone knows an easier
// way please let know.  the way I'm doing it:
// - Take the 6 floats we need to send and
//   put them in a 6 member float array.
// - using the java ByteBuffer class, convert
//   that array to a 24 member byte array
// - send those bytes to the arduino



byte[] floatArrayToByteArray(float[] input)
{
  int len = 4*input.length;
  int index=0;
  byte[] b = new byte[4];
  byte[] out = new byte[len];
  ByteBuffer buf = ByteBuffer.wrap(b);
  for(int i=0;i<input.length;i++) 
  {
    buf.position(0);
    buf.putFloat(input[i]);
    for(int j=0;j<4;j++) 
    {
      out[j+i*4]=b[3-j];
  }
  return out;
}



void Send_To_Arduino()
{
  float[] toSend = new float[6];

  toSend[0] = float(SPField.getText());
  toSend[1] = float(InField.getText());
  toSend[2] = float(OutField.getText());
  toSend[3] = float(PField.getText());
  toSend[4] = float(IField.getText());
  toSend[5] = float(DField.getText());
  Byte a = (AMLabel.valueLabel().getText()=="Manual")?(byte)0:(byte)1;
  Byte d = (DRLabel.valueLabel().getText()=="Direct")?(byte)0:(byte)1;
  myPort.write(a);
  myPort.write(d);
  myPort.write(floatArrayToByteArray(toSend));
  justSent=true;
} 
end comenting out ---*/
