//This is one of the possible tasks, the wires task.
class WireTask extends Task {
  //The wires and their target sockets.
  ArrayList<PVector> wires;
  ArrayList<PVector> wiresStart;
  ArrayList<PVector> sockets;
  
  //Updates the printer task.
  WireTask (PVector newpos) {
   super(newpos);
   tasksize = new PVector(500,250);
   
   //Adds a nandom number of wires.
   wires = new ArrayList();
   for (int i = parseInt(random(3,6)); i > 0; i-=1 ){
     wires.add(new PVector(-200,10));
   } 
   //Repositions each wire's y.
   int i = 0;
   for (PVector wire : wires)
   {
     wire.y = ((tasksize.y/float(wires.size()-1)-10)*i-tasksize.y/2)+10;
     i++;
   }
   
   //Stores the start position of each wire for drawing the line.
   wiresStart = new ArrayList();
   for (PVector wire : wires)
   {
     wiresStart.add(wire.copy());
   }
   
   //Creates a socket for each wire.
   sockets = new ArrayList();
   for (PVector wire : wires)
   {
     sockets.add(new PVector(200,10));
   }
   i = 0;
   //Randomly offsets each socket so the wires crisscross.
   float offset = random(tasksize.y);
   for (PVector socket : sockets)
   {
     socket.y = (((tasksize.y/float(sockets.size()-1)-10)*i-tasksize.y/2)+10+tasksize.y/2+offset)%(tasksize.y)-tasksize.y/2;
     i++;
   }

  }  
  
  //Overwriting the interact function to use the mouse position to drag wires.
  void interact(PVector interactionLocation) {
    PVector newpos = interactionLocation.copy().sub(position);
    
    //For each wire it tests if the wire is being dragged, and if it's still in the panel.
    for (PVector wire : wires)
    {
      if (newpos.dist(wire) < 30.0 && grabbing 
      && newpos.x > -tasksize.x/2
      && newpos.x < +tasksize.x/2
      && newpos.y > -tasksize.y/2
      && newpos.y < +tasksize.y/2
      )
      {
        //Moves the wire position to the relative mouse position.
        wire.x = newpos.x;
        wire.y = newpos.y;
        
        //Lets the progeam know something has been grabbed.
        grabbedsomething = true;
        
        break; //Breaks so it will only ever grab one item
      }
    }
    
    //Tests if any of the tasks are incomplete.
    int i = 0;
    boolean anyincomplete = false;
    for (PVector wire : wires)
    {
      if (wire.dist(sockets.get(i)) < 30)
      {
        wire = sockets.get(i);
      }
      else {
        anyincomplete = true;
      }
      //If all of the wires are used, then set the task as complete
      isComplete = !anyincomplete;
      i++;
    }
  }
  
  //Draw the task to the screen
  void display() {
    //Display the task background.
    super.display();
    
    //Draw all of the wires.
    int i = 0;
    for (PVector wire : wires)
    {
      noStroke();
      fill(25+noise(i*32)*200,25+noise(i*338)*200,25+noise(i*727)*200);
      circle(position.x+wire.x,position.y+wire.y,10);
      
      strokeWeight(5);
      stroke(25+noise(i*32)*200,25+noise(i*338)*200,25+noise(i*727)*200);
      line(wiresStart.get(i).x+position.x,wiresStart.get(i).y+position.y,wires.get(i).x+position.x,wires.get(i).y+position.y);
      i++;
  }
    
    //Draw all of the sockets
    i = 0;
    for (PVector socket : sockets)
    {
      if (socket.dist(wires.get(i)) < 30.0)
      {
        fill(0,255,0);
      }
      else {
        noFill();
      }
      stroke(25+noise(i*32)*200,25+noise(i*338)*200,25+noise(i*727)*200);
      strokeWeight(10);
      
      circle(position.x+socket.x,position.y+socket.y,20);
      i++;
    }
  }
}
