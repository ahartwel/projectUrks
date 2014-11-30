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
      perspective(PI/2, width/height, 2, width*4);
    lights();
    directionalLight(230,255,230,0,1,0);
   directionalLight(230,255,230,0,-1,0);
   directionalLight(230,255,230,1,0,0);
   directionalLight(230,255,230,-1,0,0);
    
  }
  
  void changeAngle(float amount) {
   angle+=amount;
  
      
      cameraX=eyeX + cos(radians(angle)) * distance;
    
    
     
      cameraZ=eyeZ + sin(radians(angle)) * distance;
        
   
    
    
  }
  
  
  void move(float amount, float amountHor) {
    if (amountHor==0) {
    if (angle>0) {
      eyeX-=cos(radians(angle)) * amount;
      cameraX-=cos(radians(angle)) * amount;
    
    
      eyeZ+=sin(radians(angle)) * amount;
      cameraZ+=sin(radians(angle)) * amount;
    } else { 
     
       eyeX-=cos(radians(angle)) * amount;
      cameraX-=cos(radians(angle)) * amount;
    
    
      eyeZ-=sin(radians(angle)) * amount;
      cameraZ-=sin(radians(angle)) * amount;
      
    }
    
    } else {
       amount = amountHor;
      if (angle>0) {
      eyeX-=sin(radians(angle)) * amount;
      cameraX-=sin(radians(angle)) * amount;
    
    
      eyeZ+=cos(radians(angle)) * amount;
      cameraZ+=cos(radians(angle)) * amount;
    } else { 
       eyeX-=sin(radians(angle)) * amount;
      cameraX-=sin(radians(angle)) * amount;
    
    
      eyeZ+=cos(radians(angle)) * amount;
      cameraZ+=cos(radians(angle)) * amount;
      
    }
    }
    
  }
  
  
  
  
}
