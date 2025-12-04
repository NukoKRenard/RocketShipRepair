//A parent class for a task, which can have child tasks.
class Task {
  //A global is complete value.
  boolean isComplete = false;
  
  //Variables relating to transformation.
  PVector position;
  PVector tasksize;
  PVector size;
  
  //Default constructor.
  Task (PVector newpos)
  {
    position = newpos;
  }
  
  //This is how they scroll around and loop back.
  void move(float dir) {
    position.x += dir;
    if (position.x < -width)
    {
      position.x = width*2;
    } else if (position.x > width*2) {
      position.x = -width;
    }
  }
  
  //An unused function, meant as a template for children to overwrite.
  void interact(PVector interactionLocation) {}
  
  //Draws the task background.
  void display() {
    stroke(255,0,0);
    if (isComplete)
    {
      stroke(0,255,0);
    }
    rectMode(CENTER);
    fill(10,10,10);
    rect(position.x, position.y, tasksize.x, tasksize.y);
  }
}
