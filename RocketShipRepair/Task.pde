class Task {
  boolean isComplete;
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
    rectMode(CENTER);
    fill(10,10,10);
    noStroke();
    rect(position.x, position.y, tasksize.x, tasksize.y);
  }
}
