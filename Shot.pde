class Shot {

  float x;
  float y;
  float dx;
  float dy;
  float velocidade=15;
  float largura;
  float altura;
  boolean ativo=false;

  PImage img;

  Shot(float x, float y, int dx, int dy) {
    this.x=x;
    this.y=y;
    this.dx=dx;
    this.dy=dy;
    this.ativo=true;
    img = loadImage("SHOT.png");
    largura = img.width*0.75;
    altura = img.height*0.75;
  }
  void update() {

    x+=velocidade*dx;
    y+=velocidade*dy;
    if (((x>width+100)||(x<-100))||((y>height+100)||(y<-100))) {
      ativo=false;
    }
  }
  void display() { 
    strokeWeight(3);
    //stroke(#7436C6);
    //fill(#588BCB);
    //ellipse(x, y, 20, 20);
    pushMatrix(); 
    translate(x, y);
    if (dx<0) {
      scale(-1.0, 1.0);
    } else if (dx>0) {
      scale(1.0, 1.0);
    }else if (dy<0) {
      rotate(-HALF_PI);
    } else {
      rotate(HALF_PI);
    }
    
    
    image(img, 0-largura/2, 0-altura/2, largura, altura);

    popMatrix();
  }
}
