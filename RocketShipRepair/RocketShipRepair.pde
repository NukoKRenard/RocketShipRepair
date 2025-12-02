boolean isInGame = false;

PVector mousePos = new PVector();

ArrayList<Task> tasks = new ArrayList();
int frames = 0;

boolean grabbing = false;
boolean clickedLFrame = false;

boolean accelmode = true;
PVector mouseaccel;
PVector mousevelocity;

void setup() {
  size(1280,1024);
}

void firstFrame() {
  mousePos = new PVector(width/2,height/2);
  
  for (int i = 1; i >=0; i-=1)
  {
    PVector position = new PVector(random(-width,width*2),random(300,height-300));
    
    float smallestDist = 10000;
    do {
      smallestDist = 10000;
      position = new PVector(random(-width,width*2),random(300,height-300));
      for (Task task : tasks) {
        float newdist = position.dist(task.position);
        if (newdist < smallestDist)
        {
          smallestDist = newdist;
        }
      }
    } while (smallestDist < 500);
    switch (parseInt(random(1)))
    {
      case 0:
      tasks.add(new WireTask(position));
      break;
    }
    
    mouseaccel = new PVector(0,0);
    mousevelocity = new PVector(0,0);
    mousePos = new PVector(width/2,height/2);
  }

  println("Frame1");
}

void draw() {


  if (isInGame) {
    pushMatrix();
    translate(random(10),random(10));
    background(200,200,200);
    if (frames == 0) {
      firstFrame();
    }
    
    if (keyPressed && !accelmode)
    {
      if (keyCode == UP)
      {mousePos.y-=5;}
      else if (keyCode == DOWN)
      {mousePos.y+=5;}
      else if (keyCode == LEFT)
      {mousePos.x-=5;}
      else if (keyCode == RIGHT)
      {mousePos.x+=5;}
    }
    else if (keyPressed)
    {
      if (keyCode == UP)
      {mouseaccel.y-=.5;}
      else if (keyCode == DOWN)
      {mouseaccel.y+=.5;}
      else if (keyCode == LEFT)
      {mouseaccel.x-=.5;}
      else if (keyCode == RIGHT)
      {mouseaccel.x+=.5;}
    }
    
    if (accelmode)
    {
      mousePos.add(mousevelocity);
      mousevelocity.add(mouseaccel);
      mouseaccel = new PVector(0,0);
    }
    
    mousePos.x = constrain(mousePos.x,0,width);
    mousePos.y = constrain(mousePos.y,0,height);
    
    
    if (keyPressed) {
      if (key == ' ')
      {
        if (!clickedLFrame) 
        {
          grabbing = !grabbing;
        }
      }
      clickedLFrame = key == ' ';
    }
    else {
      clickedLFrame = false;
    }
    for (Task task : tasks)
    {
      task.display();
      task.interact(mousePos);
      
      if (keyPressed)
      {
        if (key == 'a')
        {
           task.move(-10); 
        }
        else if (key == 'd')
        {
          task.move(10);
        }
      }
    }
    stroke(255,0,0);
    noFill();
    strokeWeight(10);
    circle(mousePos.x,mousePos.y,30);
    frames++;
    popMatrix();
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
