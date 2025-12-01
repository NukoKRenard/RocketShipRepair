class WireTask extends Task {
  ArrayList<PVector> wires;
  
  WireTask (PVector newpos) {
   super(newpos);
   
   wires = new ArrayList();
   for (int i = parseInt(random(3,6)); i > 0; i-=1 ){
     wires.add(new PVector(10,10));
   } 
   int i = 0;
   for (PVector wire : wires)
   {
     wire.y = (tasksize.y/float(wires.size()))*i;
     i++;
   }
  }  
  void interact(PVector interactionLocation, boolean click) {
  
  }
  
  void display(float parentx) {
    super.display(parentx);
    
    PVector newpos = new PVector(parentx + position.x, position.y);
    int i = 0;
    for (PVector wire : wires) {
      stroke((1+noise(i*1))/2*255,(1+noise(i*3432))/2*255,(1+noise(i*92))/2*255);
      noFill();
      strokeWeight(10);
      circle(newpos.x+wire.x,newpos.y+wire.y,10);
      i++;
    }
    
    float newx = parentx+position.x;
    
  }
}
