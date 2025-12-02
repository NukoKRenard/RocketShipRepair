void Menu(String text, color Color) {
  
  fill(Color);
  rectMode(CORNER);
  rect(0,0,width,height);
  
  fill(255,255,255);
  textAlign(CENTER,CENTER);
  textSize(50);
  if ((millis()/500)%2 == 0) {
    text(text,0,0,width,height);
  }
}
