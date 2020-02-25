import processing.sound.*;
import processing.video.*;
import java.awt.*;
import gab.opencv.*;

HScrollbar hs1;
Button b1;
Button b2;
Button b3;
  
PGraphics pg;
PImage img;
 
float x1 = 160;
float y1 = 120;
float x2;
float y2;
int stranica;
float a;

//float a1 = 300;
//float b1 = 500;
float r;
int type = 3;
int shapeType = 1;

Capture cam;
OpenCV opencv;
int stSlik = 0;
 
Amplitude amp;
AudioIn in;
float ampt;
float ampMeja = 0.1;
float switchAmp = 0.480;

boolean risanje = false;
 
void setup(){
  //fullScreen();
  size (640,480);
  smooth();
  background(255);
  
  hs1 = new HScrollbar(50, 60/2-8, width-100, 16, 8);
  b1 = new Button(width-40, height-40, 40, "Gumb", 256, 0, 0);
  b2 = new Button(width-40, height-100, 40, "Gumb", 256, 0, 0);
  b3 = new Button(width-40, 60, 50, "Reset", 256, 0, 0);
  
  img = loadImage("colors.png");
  cam = new Capture(this, 640/2, 480/2, 30); //this, w,h  framerate
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  cam.start();
 
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  if(in != null){
    in.start();
    amp.input(in);
  }else{
   println("No audio devices");
   exit();
  } 
}


 

 void draw(){
  
  //opencv.loadImage(cam);
 // scale(2);
  //image(cam, 0, 0 );
  //scale(0.5);
  
  ampt = amp.analyze();
  if(ampt > switchAmp){
    switchShapeType();
  }
  
  println(ampt);
  //x1 = map();
  //y1 = map();
  //color c = cam.get(int(x1/2),int(y1/2));
  color c = img.get(int(x1/2),int(y1/2));
  /*if (ampt>0.16) line(0.2, c, 4);
  if (ampt>0.12) line(0.1, c, 2);
  if (ampt>0.08) line(0.05, c, 1);*/
  line(ampMeja, c, 1);
  
  if (risanje == false){
    delay(1000);
    image(cam, 0, 0 );
    img = get();
    background(255);
    risanje = true;
  }
  
  /*if (ampt>0.030) { 
float x2 = x1 + random(-20,20);
float y2 = y1 + random(-20,20);
//float a2 = a1 + random(-20,20);
//float b2 = b1 +random(-20,20);
 
line(x1,y1,x2,y2);
//line (a1,b1,a2,b2);
stroke (255);
 
x1 = x2;
y1 = y2;
//a1= a2;
//b1=b2;
  }*/
  // Constrain all points to the screen
  x1 = constrain(x1, 0, width);
  y1 = constrain(y1, 0, height);
  
  
  
    
    /*switch(type){
      case 1:
        stroke(255);
        fill(128);
        rect(0, height-50, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("Naključno", 40, height-40);
        break;
      case 2:
        stroke(255);
        fill(128);
        rect(0, height-50, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("Miška", 40, height-40);
        break;
       case 3:
        stroke(255);
        fill(128);
        rect(0, height-50, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("FaceDet", 0, height-40);
        break;
    }*/
    
    switch(shapeType){
      case 1:
        stroke(255);
        fill(128);
        rect(width-80, 6, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("Krog", width-40, 15);
        break;
      case 2:
        stroke(255);
        fill(128);
        rect(width-80, 6, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("Kvadrat", width-40, 15);
        break;
      /*case 3:
        stroke(255);
        fill(128);
        rect(width-80, 6, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("Trikotnik", width-40, 15);
        break;*/
      case 3:
        stroke(255);
        fill(128);
        rect(width-80, 6, 80, 20);
        textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text("Šestkotnik", width-40, 15);
        break;
        
    }
    
    
    //hs1.update();
    //hs1.display();
    //b1.update();
    //b1.display();
    //b2.update();
    //b2.display();
    b3.update();
    b3.display();
    //image(img, 0, 0, width/2, height/2);
 }

 
void captureEvent(Capture cam){
  cam.read();
}


//klik miske
 void mousePressed(){
   if (b1.overEvent() == true){
      //fill(255, 0, 0);
      //ellipse(width/2, height/2, 100, 100);
      type += 1; 
      if(type > 3){
        type = 1;
      }
    }
   if (b2.overEvent() == true){
      //fill(255, 0, 0);
      //ellipse(width/2, height/2, 100, 100);
      //img = get();
      //img = get();
      //saveFrame("img-"+stSlik+".tif");
      shapeType += 1; 
      if(shapeType > 2){
        shapeType = 1;
      }
    }
    if (b3.overEvent() == true){
      //fill(255, 0, 0);
      //ellipse(width/2, height/2, 100, 100);
        reset();
    }
 }
 
 void line(float meja, int col, int b){
   if (ampt>meja) {
    
     //if(ampt>
   
    //Scrollbar position
    float pos = hs1.getPos();
    r = map(pos, 50,width-50, 3, 100); 
    
    //pozicija novega krogca
    if(type == 1){
      x2 = x1 + random(-r*0.5,r*0.5);
      y2 = y1 + random(-r*0.5,r*0.5);
    //float a2 = a1 + random(-20,20);
    //float b2 = b1 +random(-20,20);
    }
    if(type == 2){
      x2 = mouseX;
      y2 = mouseY;
    }
    if(type == 3){
      int[] cors = faceDetection();
      x2 = width-cors[0]*4;
      y2 = cors[1]*4;
      stranica = cors[2];
      a = map(stranica,60,100, 10,80);
      //scale(0.5);
    }

    //IZRIS
    //line(x1,y1,x2,y2);
    noStroke();
    //line (a1,b1,a2,b2);
    //strokeWeight(b);
    fill(col);
    //ellipseMode(CENTER);
      //ellipse( x2, y2, r, r);
    if (type != 3){ //random + miska
        if (shapeType == 1){
          ellipseMode(CENTER);
          ellipse( x2, y2, r, r);
        }if(shapeType == 2){
          //rectMode(CENTER);
          rect(x2-r*0.5, y2-r*0.5, r, r);
          //rect(x2-r*0.5, y2-r*0.5, a, a);
        }
    }      //izbira oblik
    else{ 
      if (shapeType == 1){    //krog
        ellipseMode(CENTER);
        ellipse(x2, y2, a, a);
      }if(shapeType == 2){    //kvadrat
        //rectMode(CENTER);
        //rect(x2-r*0.5, y2-r*0.5, r, r);
        rect(x2-r*0.5, y2-r*0.5, a, a);
      }/*if(shapeType == 3){    //trikotnik
        rotate(PI/6);
        polygon(x2+50, y2, a*0.7, 3);
        rotate(-PI/6);
      }*/if(shapeType == 3){    //6-kotnik
        polygon(x2+50, y2, a*0.7, 6);
      }
    }
     
    x1 = x2;
    y1 = y2;
    //a1= a2;
    //b1=b2;
  }
  // Constrain all points to the screen
  x1 = constrain(x1, 0, width);
  y1 = constrain(y1, 0, height);
 
 }
 
 
 //detekcija obrazov
int[] faceDetection(){
  //scale(2); 
  opencv.loadImage(cam);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  int[] cor= new int[3];
  
  if(faces.length > 0){
    cor[0] = faces[0].x;
    cor[1] = faces[0].y;
    cor[2] = faces[0].width;
  }
  
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
 return cor;
 }
 
 
 void switchShapeType(){
   shapeType = shapeType%3 +1;
 }
 
 //reset funkcija
void reset(){
  risanje = false; 
}


//izris veckotnikov
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  noStroke();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
