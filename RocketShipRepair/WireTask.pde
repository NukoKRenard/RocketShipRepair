class WireTask extends Task {
  ArrayList<PVector> wires;
  ArrayList<PVector> wiresStart;
  ArrayList<PVector> sockets;
  
  WireTask (PVector newpos) {
   super(newpos);
   tasksize = new PVector(500,250);
   
   wires = new ArrayList();
   for (int i = parseInt(random(3,6)); i > 0; i-=1 ){
     wires.add(new PVector(-250,10));
   } 
   int i = 0;
   for (PVector wire : wires)
   {
     wire.y = ((tasksize.y/float(wires.size()-1)-10)*i-tasksize.y/2)+10;
     i++;
   }
   wiresStart = new ArrayList();
   for (PVector wire : wires)
   {
     wiresStart.add(wire.copy());
   }
   
   sockets = new ArrayList();
   for (PVector wire : wires)
   {
     sockets.add(new PVector(250,10));
   }
   i = 0;
   float offset = random(tasksize.y);
   for (PVector socket : sockets)
   {
     socket.y = (((tasksize.y/float(sockets.size()-1)-10)*i-tasksize.y/2)+10+tasksize.y/2+offset)%(tasksize.y)-tasksize.y/2;
     i++;
   }

  }  
  void interact(PVector interactionLocation) {
    PVector newpos = interactionLocation.copy().sub(position);
    
    for (PVector wire : wires)
    {
      if (newpos.dist(wire) < 30.0 && grabbing 
      && newpos.x > -tasksize.x/2
      && newpos.x < +tasksize.x/2
      && newpos.y > -tasksize.y/2
      && newpos.y < +tasksize.y/2
      )
      {
        wire.x = newpos.x;
        wire.y = newpos.y;
        break; //Breaks so it will only ever grab one item
      }
    }
  }
  
  void display() {
    super.display();
    
    int i = 0;
    for (PVector wire : wires)
    {
      noStroke();
      fill(0,100,255);
      circle(position.x+wire.x,position.y+wire.y,10);
      
      strokeWeight(5);
      stroke(0,100,255);
      line(wiresStart.get(i).x+position.x,wiresStart.get(i).y+position.y,wires.get(i).x+position.x,wires.get(i).y+position.y);
      i++;
  }
    
    i = 0;
    for (PVector socket : sockets)
    {
      stroke(255,0,0);
      strokeWeight(10);
      noFill();
      circle(position.x+socket.x,position.y+socket.y,20);
      i++;
    }
  }
}
