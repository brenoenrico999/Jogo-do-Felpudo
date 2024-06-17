class Actor {
  float x;
  float y;
  float scaleX;
  float scaleY;
  boolean showCollision; 
  float limites;
  float imgl;
  float imga;

  ArrayList<PImage> imagens;
  int frames;
  float tempo = 100;
  String imgUrl;
  int tipoDeObjeto; //1moeda 2peninha 3inimigo

  Actor(String imgUrl, float x, float y, float scaleX, float scaleY, boolean showCollision, float limites, int frames, int tipoDeObjeto) {
    this.x = x;
    this.y = y;
    this.scaleX = scaleX;
    this.scaleY = scaleY;
    this.frames = frames;
    this.showCollision = showCollision;
    this.tipoDeObjeto = tipoDeObjeto;
    imagens = new ArrayList<PImage>();
    this.limites=limites;
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
    PImage imx = imagens.get(int((millis()/tempo)%frames));

     

    image(imx, x-(scaleX*imgl)/2, y-(scaleY*imga)/2, scaleX*imgl, scaleY*imga);
    

    if (showCollision) {
      noFill();
      strokeWeight(2);
      ellipse(x, y, limites, limites);

      stroke(255, 255, 0);
      strokeWeight(5);
      point(x, y);
    }
  }
}
