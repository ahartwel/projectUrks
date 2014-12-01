class Box {
  
  ArrayList<Point> point;
  Wall parent;
  int id=0;
   Box(ArrayList<Point> ps, int idd) {
    id = idd;
     point = ps;
     //println(point);
    
    
   } 
  
  
  
    
    void display() {
       beginShape();
       
       
       texture(canvas);
       
       noStroke();
       //fill(255,255,255);
       vertex(point.get(0).x, point.get(0).y, point.get(0).z, point.get(0).movieX, point.get(0).movieY);
       vertex(point.get(1).x, point.get(1).y, point.get(1).z, point.get(1).movieX, point.get(1).movieY);
       vertex(point.get(3).x, point.get(3).y, point.get(3).z, point.get(3).movieX, point.get(3).movieY);
       endShape();
       
       beginShape();
      // noStroke();
       texture(canvas);
       
       vertex(point.get(3).x, point.get(3).y, point.get(3).z, point.get(3).movieX, point.get(3).movieY);
       vertex(point.get(1).x, point.get(1).y, point.get(1).z, point.get(1).movieX, point.get(1).movieY);
       vertex(point.get(2).x, point.get(2).y, point.get(2).z, point.get(2).movieX, point.get(2).movieY);
       
      endShape();
      
    }
    
    
    void update() {
     
      
    }
  
  
  
  
}
