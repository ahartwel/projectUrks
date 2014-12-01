class Camera {
    float fov, cameraZ, cameraX, cameraY, eyeX,eyeY, eyeZ, angle, distance;
  
     Camera() {
      
        fov = PI/2;
        
      cameraZ = 0;
      cameraX = width/2;
      cameraY = height/2;
      
      angle = -90;
      
      eyeX = width/2;
      eyeY = height/2;
      eyeZ = (height/2);
      
      
      distance = dist(eyeX,eyeZ,cameraX,cameraZ);
     // perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
      camera(eyeX, eyeY, eyeZ, cameraX, cameraY, cameraZ, 0, 1, 0);
      
     } 
  
  
  void film() {
    if (mouseX>.7*width && mouseX<.9*width) {
     changeAngle(2);
    } else if (mouseX<.3*width && mouseX>.1*width) {
     changeAngle(-2);
    }
    
//    println(angle);
    
    
//   



//    if (mouseY>.7*height) {
//     changeAngle(2); 
//    } else if (mouseY<.3*height) {
//     changeAngle(-2);
//    }
    
    
    float deltaX = cameraX - eyeX;
    float deltaZ = cameraZ - eyeZ;
      
    //  angle = atan(deltaZ/deltaX) * (180/PI);
       distance = dist(eyeX,eyeZ,cameraX,cameraZ);
     // println(angle);
      
      //cameraX = lerp(cameraX, (float(mouseX)/width) * width, .3); 
           
     // cameraY = (float(mouseY)/height) * height;
    //println(float(mouseX)/width);
     //perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
      camera(eyeX, eyeY, eyeZ, cameraX, cameraY, cameraZ, 0, 1, 0);
      perspective(PI/2, width/height, 2, width*8);
    lights();
    directionalLight(230,255,230,-1,1,0);
    directionalLight(230,255,230,1,0,0);
    directionalLight(230,255,230,0,1,0);
    directionalLight(230,255,230,0,1,0);
    //directionalLight(230,255,230,-1,1,0);
    directionalLight(230,255,230,0,-1,1);
    //directionalLight(230,255,230,0,-1,0);
    
     
   //directionalLight(230,255,230,0,-1,0);
   //directionalLight(230,255,230,1,0,0);
   //directionalLight(230,255,230,-1,0,0);
    
  }
  
  void changeAngle(float amount) {
   angle+=amount;
  
  if (angle>0) {
   angle = -360 + angle; 
  }
  
  if (angle<-360) {
   angle = 0 - (-360 - angle); 
  }
      
      cameraX=eyeX + cos(radians(angle)) * distance;
    
    
     
      cameraZ=eyeZ + sin(radians(angle)) * distance;
        
   
    
    
  }
  
  
  
  void move(float amount, float amountHor) {
      float eZAdd, eXAdd, cZAdd, cXAdd;
    if (amountHor==0) {
    if (angle>0) {
      eXAdd = -cos(radians(angle)) * amount;
      cXAdd = -cos(radians(angle)) * amount;
      
    
      eZAdd  = sin(radians(angle)) * amount;
      cZAdd = sin(radians(angle)) * amount;
    } else { 
     
       eXAdd = -cos(radians(angle)) * amount;
      cXAdd = -cos(radians(angle)) * amount;
    
    
      eZAdd = -sin(radians(angle)) * amount;
      cZAdd = -sin(radians(angle)) * amount;
      
    }
    
    } else {
       amount = amountHor;
      if (angle>0) {
      eXAdd = -sin(radians(angle)) * amount;
      cXAdd = -sin(radians(angle)) * amount;
    
    
      eZAdd = cos(radians(angle)) * amount;
      cZAdd = cos(radians(angle)) * amount;
    } else { 
       eXAdd = -sin(radians(angle)) * amount;
      cXAdd = -sin(radians(angle)) * amount;
    
    
      eZAdd = cos(radians(angle)) * amount;
      cZAdd = cos(radians(angle)) * amount;
      
    }
    }
    
    cameraX += cXAdd;
    cameraZ += cZAdd;
    eyeX += eXAdd;
    eyeZ+= eZAdd;
    
    
    if (undoMove()) {
      cameraX -= cXAdd;
    cameraZ -= cZAdd;
    eyeX -= eXAdd;
    eyeZ-= eZAdd;
      
    }
    
  }
  
  
  boolean undoMove() {
    println("aaaahhh");
    for (int i = 0; i<walls.size(); i++) {
      Wall w = walls.get(i);
      if (w.isWall) {
      println(i);
      float dd = distanceToLineSegment(w.rectX, w.rectZ, w.rectX2, w.rectZ2, eyeX, eyeZ); 
 
      if (dd<400 && dd>-1) {
        println("---");
      println(i);
       println(dd);
       return true;
      }
      }
    }
     return false;
  }
  
  
}
