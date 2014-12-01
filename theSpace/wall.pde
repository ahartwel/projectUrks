class Wall {
  ArrayList<Point> points;
  ArrayList<Box> boxes;
  
   float boxW;
    float boxH;
 
 int whichP = 0;
  
  float xPos, yPos, zPos, xRot, yRot, zRot, wid, hei;
  
  float rectX, rectZ, rectX2, rectZ2;
  
  boolean isWall = false;
  
   Wall(float w, float h, float xx, float yy, float zz, float xxx, float yyy, float zzz, float rrr,float rr, float rrrr, boolean isAWall) {
      println(numOfBoxes);  
     xPos = xxx;
     yPos = yyy;
     zPos = zzz;
     yRot = rr;
     xRot = rrr;
     zRot = rrrr;
     boxes = new ArrayList<Box>();
     points = new ArrayList<Point>();
     int idd = 0;
     wid = w;
     hei = h;
     
     isWall = isAWall;
     
     
     
     
     boxW = wid/numOfBoxes;
      boxH = hei/numOfBoxes;
      
      
       rectX = 0;
     rectZ = 0;
     
     
     rectX += xPos;
     rectZ += zPos;
     
     rectX2 = rectX;
     rectZ2 = rectZ;
     
     rectX += cos(radians(yRot)) * ((numOfBoxes - 2)/2 * boxW);
     rectX2 -= cos(radians(yRot)) * ((numOfBoxes - 2)/2 * boxW);
     
     rectZ += sin(radians(yRot)) * ((numOfBoxes - 2)/2 * boxW);
     rectZ2 -= sin(radians(yRot)) * ((numOfBoxes - 2)/2 * boxW);
      
      
     int pId = 0;
     while(yy<hei+1) {
       
       //boxes.add(new Boxx,yy,zz,boxW,boxH, this, i));
       points.add(new Point(this, xx,yy,zz, pId));
       
       xx+=boxW;
       
       if (xx>=wid) {
        xx=0;
         yy+=boxH;
        
       }
       idd++;
       pId++;
     }
     
     xx=0;
     yy=0;
     
     for (int i = 0; i<points.size()-numOfBoxes-1; i++) {
       if (i%numOfBoxes>=numOfBoxes-1) {
         i++;
       }
       
       ArrayList<Point> ps = new ArrayList<Point>();
       ps.add( points.get(i) );
       ps.add( points.get(i+1) );
       ps.add( points.get(int(i+numOfBoxes+1)) );
       ps.add( points.get(int(i+numOfBoxes)) );
       
       boxes.add(new Box(ps, i));
       
       
      
       
     // println(i%numOfBoxes);
      // println(points.size());
     }
      
           
           
      
     
     
     
     
    
    
   }
  
  
  float actualWidth() {
    float w = (numOfBoxes-2) * boxW;
   return w;
  }
  
  void display() {
    pushMatrix();
    translate(xPos, yPos, zPos);
    
    rotateX(radians(xRot));
    rotateY(radians(yRot));
    rotateZ(radians(zRot));

   for (int i = 0; i < boxes.size()-1; i++) {
    boxes.get(i).display(); 
   }
   
   popMatrix();
   
   
//  stroke(255,255,255);  //visualize positioning of walls
//  strokeWeight(5);
//   beginShape();
//   vertex(rectX,height,rectZ);
//   vertex(rectX2,height, rectZ2);
//   vertex(rectX2, height , rectZ2);
//   endShape();
    
  
   
  }
 
 
 void update() {
  
  
    for (int i = 0; i <points.size(); i++) {
       
        Point p = points.get(i);
        p.update();
       
      }
  
 }


void setZ(int which, float value) {
//  if (points.get(whichP).stayInPlace) {
//   whichP++; 
//  }
//  
//  if (whichP>points.size()-1) {
//   whichP = 0; 
//  }
//  
  Box bb = boxes.get(whichP);
  if (random(0,1)<.04) {
  whichP+=5;
  if (whichP>boxes.size()-1) {
   whichP=0; 
  }
  }
  for (int i = 0; i<4;i++) {
    bb.point.get(i).newZ = value;    
    bb.point.get(i).z = lerp(bb.point.get(i).z, value,.09);
  }



// if (random(0,1)<.009) {
//  whichP+=int(random(1,2));
//  if (whichP>points.size()-1) {
//   whichP = 0; 
//  }
// }
} 
  
  
  
}
