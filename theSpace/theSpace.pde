import codeanticode.syphon.*;


import processing.video.*;


import ddf.minim.analysis.*;
import ddf.minim.*;

 float numOfBoxes = 10; 
 float boxCount = sq(numOfBoxes);
  float boxW;
  float boxH;

 SyphonClient client;
  PGraphics canvas;
   
//Movie myMovie;
  Camera cam;
  
  float importWidth = 640;
  float importHeight = 480;
  
  boolean justStarted = true;
  
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
  
  client = new SyphonClient(this, "", "Processing");
  
  cam = new Camera();
  //myMovie = new Movie(this, "test2.mov"); 
  //myMovie.loop();
  boxW = width/numOfBoxes;
  boxH = height/numOfBoxes;



 walls = new ArrayList<Wall>();
 walls.add( new Wall(width*3, height*3, 
 0,0,0, 
 0, .5 * height, -width*1.5, 
 90,0, 0) );
 
 walls.add(new Wall(width*2, height*3,
 0,0,0,
 width, .5 * height, -1 * walls.get(0).actualWidth(),
 0,0,0
 ));
 
 walls.add(new Wall(width*2, height*3,
 0,0,0,
 walls.get(1).actualWidth(),.5*height,-walls.get(0).actualWidth() + width,
 270,0,0));
 
 //walls.add( new Wall(width, height*2, 0,0,0, 0, 0, (numOfBoxes-2) * -walls.get(0).boxW, 0,0, 0) );
 
 //walls.add( new Wall(width, height*2, 0,0,0, walls.get(1).boxW * numOfBoxes,0, ((numOfBoxes-2) * -walls.get(0).boxW)*1.25,-90,0,0)); 
 
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
  
  if (justStarted==false) {
    getImage();
  background(0,0,0);
 //lights();
 //directionalLight(230,255,230,0,1,0);
 //directionalLight(230,255,230,0,-1,0);
 //directionalLight(230,255,230,1,0,0);
 //directionalLight(230,255,230,-1,0,0);
 //ambientLight(255,255,0);
 
 cam.film();


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
  
      int value = int(fft.getAvg(p)*-5.6);
      walls.get(i).setZ(int(whichP), value);
}
    
    
  }
  
  

  
 
 
  } else {
    
     if (client.available()) {
    canvas = client.getGraphics(canvas);
    //image(canvas, 0, 0, canvas.width, canvas.height);    
    println(canvas.width + " " + canvas.height);
  justStarted=false;  
} 
    
  }

}


void getImage() {
  
    if (client.available()) {
    canvas = client.getGraphics(canvas);
    //image(canvas, 0, 0, canvas.width, canvas.height);    
   // println(canvas.width + " " + canvas.height);  
} 
  
}

void movieEvent(Movie m) {
  m.read();
  
  
}


void keyPressed() {
 if (key == CODED) {
    if (keyCode == UP) {
     cam.move(-30,0); 
      
    } else if (keyCode==DOWN) {
     cam.move(30,0); 
    } else if (keyCode==LEFT) {
      println("ahhhh");
     cam.move(0,-30); 
    } else if (keyCode==RIGHT) {
      cam.move(0,30); 
    }
  
  
 } 
  
  
}
