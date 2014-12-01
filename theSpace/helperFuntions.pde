

boolean pointRect(int px, int py, int rx, int ry, int rw, int rh) {
  
  // test for collision
  if (px >= rx-rw/2 && px <= rx+rw/2 && py >= ry-rh/2 && py <= ry+rh/2) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}



float distanceToLineSegment(float sX, float sY, float sXX, float sYY, float pX, float pY) {
  
   float distance1 = dist(sX, sY, pX, pY);
  float distance2 = dist(sXX, sYY, pX, pY);
   
   float segLength = dist(sX,sY,sXX,sYY)*1.1; //lets give it a little breathing room with the 1.2;
   
   if (distance1<segLength && distance2<segLength) {
     
     println(pX + " " + pY);
     
        float x,x2, pnX;  //getting the parrallel distance (act as if pX, pY is on the line)
          float lerpAmount = 0;
          float closeX, closeY;
          if (sX == sXX) {
           closeX = sX; 
             closeY = pY; 
              
          } else {
             closeY = sY;
             closeX = pX;
          }
          
           return dist(closeX, closeY, pX, pY);
            
          } else {
            
           return -1; 
          }
          
          
}
          
    

