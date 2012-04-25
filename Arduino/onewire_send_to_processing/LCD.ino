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
