boolean isInGame = false;

ArrayList<Panel> Panels = new ArrayList();
PVector mousePos = new PVector();

void setup() {
  size(1280,1024);
  for (int pi = 0; pi < 1; pi++) 
  {
    ArrayList<Task> newtasks = new ArrayList();
    
    for (int ti = 0; ti < 1; ti++)
    {
      newtasks.add(new WireTask(new PVector(width/2,ti*(height/3)+tasksize.y/2)));
    }
    
    Panels.add(new Panel(Panels,width*pi,newtasks));
  }
}

int frames = 0;
void firstFrame() {
  mousePos = new PVector(width/2,height/2);
  println("Frame1");
}

void draw() {
  background(255,0,255);

  if (isInGame) 
  {
    
    if (frames == 0) {
      firstFrame();
    }
    
    
    if (keyPressed) {
    int moveamt = 5;
    if (keyCode == UP)
    {
      mousePos.y -= moveamt;
    }
    if (keyCode == DOWN)
    {
      mousePos.y += moveamt;
    }
    if (keyCode == LEFT)
    {
      mousePos.x -= moveamt;
    }
    if (keyCode == RIGHT)
    {
      mousePos.x += moveamt; 
    }
    }
    
    for (Panel panel : Panels) {
      if (keyPressed)
      {
        if (key == 'a')
        {
          panel.movex(10);
        }
        else if (key == 'd')
        {
          panel.movex(-10);
        }
      }
      panel.display();
      panel.interact(mousePos);
    }
    
    circle(mousePos.x,mousePos.y,30);
    frames++;
  }
  else
  {
    switch(mainMenu()) {
      case NO_EVENT:
      frames = 0;
      break;
      
      case START_GAME:
      isInGame = true;
      break;
      
      default:
      break;
    }
  }
}
