//The cursor position, controlled by the arrow keys.
PVector mousePos = new PVector();

//A global variable used to enhance colour differences in tasks.
int globaltaski = 0;

//The different tasks
ArrayList<Task> tasks = new ArrayList();
int frames = 0;

//Grabbing data
boolean grabbing = false;
boolean grabbedsomething = false;
boolean clickedLFrame = false;

//Mouse acelleration data.
boolean accelmode = true;
PVector mouseaccel;
PVector mousevelocity;

//Round timing.
int starttime = 0;
int maxtime = 1000*60*10;

public enum GameState {
  MAIN_MENU, IN_GAME, WIN, LOOSE;
}

//Tells the game to open the main menu.
GameState programState = GameState.MAIN_MENU;

void setup() {
  size(1280,1024);
}

void firstFrame() {
  //Variable setup on game start.
  mousePos = new PVector(width/2,height/2);
  starttime = millis();
  tasks = new ArrayList();
  grabbing = false;
  
  //Create acertain amount of tasks
  for (int i = 5; i >=0; i-=1)
  {
    //Puts the task at a random position.
    PVector position = new PVector(random(-width+250,width*2-250),random(300,height-300));
    
    //A variable to find the smallest distance.
    float smallestDist = 10000;
    //Keeps repositioning the new task untill it is not intersecting with another task.
    do {
      smallestDist = 10000;
      position = new PVector(random(-width+250,width*2-250),random(300,height-300));
      
      //Tests the new task's position against all of the other tasks.
      for (Task task : tasks) {
        float newdist = position.dist(task.position);
        if (newdist < smallestDist)
        {
          smallestDist = newdist;
        }
      }
    } while (smallestDist < 500);
    
    //Adds the task to the list (Generally this would add a different task based on a random number, but I do not have time to create more tasks)
    switch (parseInt(random(1)))
    {
      case 0:
      tasks.add(new WireTask(position));
      break;
    }
  }
  
  //Resets the mouse variables.
  mouseaccel = new PVector(0,0);
  mousevelocity = new PVector(0,0);
  mousePos = new PVector(width/2,height/2);
}

void draw() {
  //Tests weither the user is in a game, or menu.
  switch (programState) {
    //When the user is in the game.
    case IN_GAME:
    globaltaski = 0;
    
    //Same as the background function, used to get motion blur.
    fill(10,10,20,50);
    rectMode(CORNER);
    rect(0,0,width,height);
    
    //This matrix makes the gamera shake.
    pushMatrix();
    //Rocks the screen
    rotate(sin(millis()/1000.0)*(millis()-starttime)/float(maxtime)*.5);
    //Jiggles the screen.
    translate(random((millis()-starttime)/float(maxtime)*100),random((millis()-starttime)/float(maxtime)*100));
    //If the game is on the first frame, then fire the first frame function.
    if (frames == 0) {
      firstFrame();
    }
    
    //The !accelmode replaces mouse velocity with position. It is far easier and only used for debugging.
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
    //Accelerates the mouse based on user input.
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
    
    //Reduces the mouse velocity over time so it doesn't slide as much and is slighly easier to controll.
    if (accelmode)
    {
      mousePos.add(mousevelocity);
      mousevelocity.add(mouseaccel);
      mousevelocity.sub(mousevelocity.copy().div(50));
      mousevelocity.add(new PVector(0,5));
      mouseaccel = new PVector(0,0);
    }
    
    //Constrains the mouse to stay on the screen.
    mousePos.x = constrain(mousePos.x,0,width);
    mousePos.y = constrain(mousePos.y,0,height);
    
    
    //Toggles grab when the space key is pressed.
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
    
    //Display and allow the mouse to interact with each task..
    for (Task task : tasks)
    {
      globaltaski++;
      task.display();
      task.interact(mousePos);
      
    //Moves the camera based on user input.
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
    
    //Tests if any tasks are not complete.
    boolean anyincomplete = false;
    for (Task task : tasks)
    {
      if (!task.isComplete)
      {
        anyincomplete = true;
        break;
      }
    }
    
    //If all of the tasks are completed, then move to the win screen.
    if (!anyincomplete)
    {
      programState = GameState.WIN;
      frames = 0;
    }
    
    //If the player runs our of time, move to the loose screen.
    else if ((millis()-starttime) > maxtime)
    {
      programState = GameState.LOOSE;
      frames = 0;
    }
    
    
    //Draws the timer bar based off of how long the game has gon on for.
    rectMode(CENTER);
    fill(20);
    rect(width/2,50,width-200,50);
    noStroke();
    fill(0,100,100);
    rect(width/2,50,(width-200)*((maxtime-(millis()-starttime))/float(maxtime)),50);
    
    //Draws the mouse cursor.
    stroke(255,0,0);
    noFill();
    strokeWeight(10);
    circle(mousePos.x,mousePos.y,30);
    frames++;
    popMatrix();
    
    if (!grabbedsomething) {
      grabbing = false;
    }
    grabbedsomething = false;
    
    break;
      
    //If the user is on the start screen.
    case MAIN_MENU:
    Menu("Press any button to begin!","Controlls: Arrow keys to move cursor, a and d to move camera, space to grab and release" ,color(200,100,0));
    //Start the game is when a key is pressed.
    if (keyPressed)
    {
      programState = GameState.IN_GAME;
    }
    frames = 0;
    break;
    
    //If the user winds
    case WIN:
    //Play the win screen for a 3 seconds, and then go back to the main menu.
    Menu("You Win!","You completed all the tasks!",color(0,100,0));
    if (frames > 60*3)
    {
      programState = GameState.MAIN_MENU;
    }
    frames++;
    break;
    
    //If the user looses.
    case LOOSE:
    //Play the loss screen for a 3 seconds, and then go back to the main menu.
    Menu("You Lost :(","The timer ran out and you blew up :(",color(0,0,100));
    if (frames > 60*3)
    {
      programState = GameState.MAIN_MENU;
    }
    frames++;
    break;
      
    
  }
}
