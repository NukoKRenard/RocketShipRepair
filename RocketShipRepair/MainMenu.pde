color BACKGROUNDCOLOR = color(200,100,50);
color TEXTCOLOR = color(255,255,255);

public enum MenuEvent {
  NO_EVENT, START_GAME;
}

public MenuEvent mainMenu() {
  
  fill(BACKGROUNDCOLOR);
  rect(0,0,width,height);
  
  fill(TEXTCOLOR);
  textAlign(CENTER,CENTER);
  textSize(50);
  if ((millis()/500)%2 == 0) {
    text("Press Any Button To Play!",0,0,width,height);
  }
  if (keyPressed){
    return MenuEvent.START_GAME;
  }
  return MenuEvent.NO_EVENT;
}
