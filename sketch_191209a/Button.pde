class Button {
  float xpos, ypos;       // x and y position of button
  float radius;           // x position of slider
  String text;            // text on button
  boolean over;           // is the mouse over the slider?
  boolean locked;
  color col;

  Button(float xp, float yp, float ra, String t, int r, int g, int b) {
    xpos = xp;
    ypos = yp;
    radius = ra;
    text = t;
    col = color(r,g,b);
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    /*if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }*/
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    /*if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {*/
    if (dist(xpos, ypos, mouseX, mouseY) < radius*0.5){   //dist(x1, y1, x2, y2)
      return true;
    } else {
      return false;
    }
  }

  void display() {
    stroke(255);
    fill(128);
    //rect(xpos, ypos, swidth, sheight);
    ellipseMode(CENTER);
    //fill(col);
    ellipse(xpos, ypos, radius, radius);
    
    /*fill(0);
    textAlign(CENTER,CENTER);
    text(text, xpos, ypos);*/
    
    if (over || locked) {
      fill(0);
    } else {
      fill(128);
    }
    //rect(spos, ypos, sheight, sheight);
    ellipse(xpos, ypos, radius, radius);
    
    textSize(12);
        textAlign(CENTER,CENTER);
        fill(255); 
        text(text, xpos, ypos);
  }

        
}
