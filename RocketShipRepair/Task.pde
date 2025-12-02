class Task {
  boolean isComplete = false;
  PVector position;
  PVector tasksize;
  PVector size;
  Task (PVector newpos)
  {
    position = newpos;
  }
  
  void move(float dir) {
    position.x += dir;
    if (position.x < -width)
    {
      position.x = width*2;
    } else if (position.x > width*2) {
      position.x = -width;
    }
  }
  
  void interact(PVector interactionLocation) {}
  
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
