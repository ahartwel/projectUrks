class Point {
  
  float x, y, z, movieX, movieY;
  int id;
  
  float newZ;
  boolean stayInPlace = false;
  Wall parent;
     Point(Wall p, float xx, float yy, float zz, int idd) {
      x = xx;
      y = yy;
      z = zz;
      newZ = z;
      parent = p;
      movieX = (x/parent.wid) * canvas.width;
      movieY = (y/parent.hei) * canvas.height;
      id = idd;
      
      x = x - (parent.wid/2);
      y = y - (parent.hei/2);
      if (id%numOfBoxes==0 || id%numOfBoxes==numOfBoxes-1) {
       stayInPlace = true; 
      }
     }
      
      
     
    
    
    
    
    void update() {
     if (stayInPlace) {
      z=0; 
     } else {
      
     z = lerp(z,newZ,.05);
     
    } 
    }
  
  
  
  
  
}
