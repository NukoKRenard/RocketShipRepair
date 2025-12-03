void Menu(String text, String tooltip, color Color) {
  
  fill(Color);
  rectMode(CORNER);
  rect(0,0,width,height);
  
  fill(255,255,255);
  textAlign(CENTER,CENTER);
  textSize(50);
  if ((millis()/500)%2 == 0) {
    text(text,0,0,width,height);
  }
  textSize(20);
  text(tooltip,0,width/2,width,50);
}
