import processing.video.*;


import ddf.minim.analysis.*;
import ddf.minim.*;

 float numOfBoxes = 12; 
 float boxCount = sq(numOfBoxes);
  float boxW;
  float boxH;

 
Movie myMovie;
  
  
  float movieW = 956;
  float movieH = 808;
Minim minim;
//AudioPlayer music;
AudioInput music;
ddf.minim.analysis.FFT fft;


ArrayList<Wall> walls;
Wall theWall, wall2, wall3, ceiling;



void setup() {
 size(1600,1024,P3D);
background(0);
  

  
  myMovie = new Movie(this, "test2.mov"); 
  myMovie.loop();
  boxW = width/numOfBoxes;
  boxH = height/numOfBoxes;



 walls = new ArrayList<Wall>();
 walls.add( new Wall(width, height, 0,0,0, 0, 0, 0, 90,0, 0) );
 
 walls.add( new Wall(width, height, 0,0,0, 0, 0, (numOfBoxes-2) * -boxW, 0,0, 0) );
 
 walls.add( new Wall(width, height, 0,0,0, (numOfBoxes-1) * boxW,0, -width, 270,0, 0) );
 
 walls.add( new Wall(width, height, 0,0,0, width, 0, 0, 0,-90, 90) ); 
 walls.add( new Wall(width, height, 0,0,0, width/2, 0, 0, 0,-90, 90) ); 
  
 
    minim = new Minim(this);
  
  //music = minim.loadFile("thetruth.mp3", 2048);
  music = minim.getLineIn(minim.STEREO,2048);
  // loop the file
  //music.loop();
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // and a sample rate that is the same as jingle's
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fft = new ddf.minim.analysis.FFT(music.bufferSize(), music.sampleRate());
  // use 128 averages.
  // the maximum number of averages we could ask for is half the spectrum size. 
  fft.linAverages(128);
    
  
}


void draw() {
  background(0,0,0);
 lights();
 directionalLight(230,255,230,0,1,0);
 directionalLight(230,255,230,0,-1,0);
 //directionalLight(230,255,230,1,0,0);
 directionalLight(230,255,230,-1,0,0);
 //ambientLight(255,255,0);
  float fov = PI/2;
float cameraZ = (height/2.0) / tan(fov/2.0);
perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
 camera(width/1.4, height/1.4, 25, width/2, height/2, -.5 * width, 0, 1, 0);


   fft.forward(music.mix);
  int w = int(fft.specSize()/256);
  fill(0);
 int w2 = 2*2;
 int w4 = w*5;
  
  for (int i = 0; i<walls.size(); i++) {
    walls.get(i).display();  
    walls.get(i).update();
    for(int p = 0; p < fft.avgSize()/5; p++)
  {
    float whichP = (float(p)/(fft.avgSize()/5))* (boxCount-10);
  
      int value = int(fft.getAvg(p)*-20.6);
      walls.get(i).setZ(int(whichP), value);
}
    
    
  }
  
  

   
 
 
  

}

void movieEvent(Movie m) {
  m.read();
  
  
}

class Box {
  
  ArrayList<Point> point;
  Wall parent;
  int id=0;
   Box(ArrayList<Point> ps, int idd) {
    id = idd;
     point = ps;
     println(point);
    
    
   } 
  
  
  
    
    void display() {
       beginShape();
       
       texture(myMovie);
       
       //noStroke();
       //fill(255,255,255);
       vertex(point.get(0).x, point.get(0).y, point.get(0).z, point.get(0).movieX, point.get(0).movieY);
       vertex(point.get(1).x, point.get(1).y, point.get(1).z, point.get(1).movieX, point.get(1).movieY);
       vertex(point.get(3).x, point.get(3).y, point.get(3).z, point.get(3).movieX, point.get(3).movieY);
       endShape();
       
       beginShape();
      // noStroke();
       texture(myMovie);
       
       vertex(point.get(3).x, point.get(3).y, point.get(3).z, point.get(3).movieX, point.get(3).movieY);
       vertex(point.get(1).x, point.get(1).y, point.get(1).z, point.get(1).movieX, point.get(1).movieY);
       vertex(point.get(2).x, point.get(2).y, point.get(2).z, point.get(2).movieX, point.get(2).movieY);
       
      endShape();
      
    }
    
    
    void update() {
     
      
    }
  
  
  
  
}
class Point {
  
  float x, y, z, movieX, movieY;
  boolean stayInPlace = false;
  Wall parent;
     Point(Wall p, float xx, float yy, float zz) {
      x = xx;
      y = yy;
      z = zz;
      parent = p;
      movieX = (x/parent.wid) * myMovie.width;
      movieY = (y/parent.hei) * myMovie.height;
      
      if (yy<boxH || yy>=parent.hei-(boxH*2)) {
       stayInPlace = true; 
      }
      
      
     }
    
    
    
    
    void update() {
     if (stayInPlace) {
      z=0; 
     } else {
      
     z = lerp(z,0,.01);
     }
    } 
  
  
  
  
  
}
class Wall {
  ArrayList<Point> points;
  ArrayList<Box> boxes;
  
 
 
 int whichP = 0;
  
  float xPos, yPos, zPos, xRot, yRot, zRot, wid, hei;
  
   Wall(float w, float h, float xx, float yy, float zz, float xxx, float yyy, float zzz, float rr, float rrr, float rrrr) {
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
     while(yy<hei+1) {
       
       //boxes.add(new Boxx,yy,zz,boxW,boxH, this, i));
       points.add(new Point(this, xx,yy,zz));
       
       xx+=boxW;
       
       if (xx>=wid) {
        xx=0;
         yy+=boxH;
        
       }
       idd++;
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
       
       
      
       
      println(i%numOfBoxes);
       println(points.size());
     }
      
           
           
      
     
     
     
     
    
    
   }
  
  
  void display() {
    pushMatrix();
    translate(xPos, yPos, zPos);
    rotateY(radians(yRot));
    rotateX(radians(xRot));
    rotateZ(radians(zRot));

   for (int i = 0; i < boxes.size()-1; i++) {
    boxes.get(i).display(); 
   }
   
   popMatrix();
   
  
   
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
    bb.point.get(i).z = value;    
    
  }



// if (random(0,1)<.009) {
//  whichP+=int(random(1,2));
//  if (whichP>points.size()-1) {
//   whichP = 0; 
//  }
// }
} 
  
  
  
}

