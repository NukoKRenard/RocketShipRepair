class Panel {
  ArrayList<Task> tasks;
  float xcoord;
  ArrayList<Panel> panels;
  int id;
  
  Panel(ArrayList<Panel> newpanels, float pos, ArrayList addedtasks) {
    xcoord = pos;
    tasks = addedtasks;
    panels = newpanels;
    id = newpanels.size();
  }
  
  void movex(float value)
  {
    xcoord += value;
    xcoord = ((xcoord+width)%(width*panels.size()));
    xcoord -= width;
  }
  void interact(PVector mouseposition) {
    for (Task task : tasks) {
      task.interact(mouseposition,xcoord);
    }
  }
  
  void display() {
    rectMode(CORNER);
    noStroke();
    fill(100);
    rect(xcoord,0,width,height);
    for (Task task : tasks)
    {
      task.display(xcoord);
    }
  }
}
