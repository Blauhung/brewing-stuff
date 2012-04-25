/*----( initialize temperature sensors )----*/
void setuptemp() {
  MyWireBus.reset();
  sensors.begin();
}

/*----( update temperature array )----*/
void updatetemp() {
  sensors.requestTemperatures(); // Send the command to get temperatures
  for (int i=0; i<NUM_TS; i++) {
    tempC[i]=sensors.getTempCByIndex(i);
    tempF[i] =(tempC[i]*1.8)+32;
  }
}
