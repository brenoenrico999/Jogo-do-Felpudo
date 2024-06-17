class Particle {
  float x;
  float y;
  float l;
  float a;

  float imgl;
  float imga;

  PImage imagem;
  float contador;
  boolean ativo=true;
  
  Particle(float x, float y, float l, float a) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.a = a; 
    imagem = loadImage("particle.png"); 
    imgl = imagem.width;
    imga = imagem.height;
  }

  void update() {
    contador+=0.17f;
  }

  void display() { 
    if (contador<=0.9f) { 
      image(imagem, x-imgl/4, y-imga/4, imgl/2, imga/2);
    } else {
      ativo=false;
    }
  }
}
