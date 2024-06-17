class Explosao {
  float x;
  float y;
  float l;
  float a;

  float imgl;
  float imga;

  ArrayList<PImage> imagens;

  int frames = 10;
  float tempo = 100;
  boolean ativo = true;

  Explosao(String imgUrl, float x, float y, float l, float a) { 
    this.x = x;
    this.y = y;
    this.l=l;
    this.a=a;

    imagens = new ArrayList<PImage>();

    for (int i=1; i<=frames; i++) {
      PImage img = loadImage(imgUrl+"/"+imgUrl+i+".png");
      imagens.add(img);
      imgl = img.width;
      imga = img.height;
    }
  }


  void update() {
  }
  void display() {
    if (ativo) {
      int contador = int((millis()/tempo)%frames);

      PImage imx = imagens.get(contador);
      image(imx, x-(l*imgl)/2, y-(a*imga)/2, l*imgl, a*imga);

      if (contador==7) {
        ativo=false;
      }
    }
  }
}
