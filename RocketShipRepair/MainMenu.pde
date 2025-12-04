//A function that draws a menu to the screen.
void Menu(String text, String tooltip, color Color) {
  
  //Draws the specified colour in the background.
  fill(Color);
  rectMode(CORNER);
  rect(0,0,width,height);
  
  //Draws the specified text.
  fill(255,255,255);
  textAlign(CENTER,CENTER);
  textSize(50);
  
  //Flashes the text on and off.
  if ((millis()/500)%2 == 0) {
    text(text,0,0,width,height);
  }
  
  //Draws the specified description.
  textSize(20);
  text(tooltip,0,width/2,width,50);
}
