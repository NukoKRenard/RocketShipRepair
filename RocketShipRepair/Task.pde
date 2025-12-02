PVector tasksize = new PVector(500,250);

class Task {
  boolean isComplete;
  PVector position;
  PVector size;
  Task (PVector newpos)
  {
    position = newpos;
  }
  
  void interact(PVector interactionLocation, float parentx) {}
  
  void display(float parentx) {
    rectMode(CENTER);
    fill(10,10,10);
    noStroke();
    rect(position.x + parentx, position.y, tasksize.x, tasksize.y);
  }
}
