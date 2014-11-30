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
      movieX = (x/parent.wid) * importWidth;
      movieY = (y/parent.hei) * importHeight;
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
      if (newZ>z) {
     z = lerp(z,newZ,.1);
     
   }
    } 
    }
  
  
  
  
  
}
