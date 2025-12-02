boolean isInGame = false;

ArrayList<Panel> Panels = new ArrayList();

PVector CameraPos;

void setup() {
  size(1280,1024);
  for (int pi = 0; pi < 3; pi++) 
  {
    ArrayList<Task> newtasks = new ArrayList();
    
    for (int ti = 0; ti < 3; ti++)
    {
      newtasks.add(new WireTask(new PVector(height/2,width/2)));
    }
    
    Panels.add(new Panel(Panels,width*pi,newtasks));
  }
  CameraPos = new PVector(0,0);
}

void draw() {
  background(255,0,255);

  if (isInGame) 
  {
    for (Panel panel : Panels) {
      panel.movex(5);
      panel.display();
  }
  }
  else
  {
    switch(mainMenu()) {
      case NO_EVENT:
      break;
      
      case START_GAME:
      isInGame = true;
      break;
      
      default:
      break;
    }
  }
}
