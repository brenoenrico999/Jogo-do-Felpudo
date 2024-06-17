class Enemy extends Actor {

  ArrayList<PImage> imagens;

  float tempo=100;
  int direcao = -1;
  float velocidade = 0.95;
  boolean showCollision;
  float limites;
  Enemy(String imagem, float x, float y, float l, float a, boolean ativo, int direcao, boolean showCollision, float limites) {
    super(imagem, x, y, l, a, showCollision, limites, 1, 7); 
    this.limites=limites;
    this.showCollision = showCollision;
    this.direcao = direcao;
    imagens = new ArrayList<PImage>();

    for (int i=1; i<=8; i++) {
      PImage img = loadImage(imagem+"/"+imagem+i+".png");
      imagens.add(img);
      l=img.width*l;
      a=img.height*a;
    }
  }

  @Override void display() { 

    PImage imx = imagens.get(int((millis()/tempo)%8));

  
    if (direcao==1) {
      pushMatrix(); 
      scale(-1, 1.0); 
    //image(imx, -x-scaleX/2, y-scaleY/2, imgl, imga);
      image(imx, -x-imgl/2, y-imga/2, imgl, imga);
      popMatrix();
    } else {
      image(imx, x-imgl/2, y-imga/2, imgl, imga);
    }
    
   
    
    
      
     


    if (showCollision) {
      noFill();
      strokeWeight(2);
      ellipse(x, y, limites, limites);

      stroke(255, 255, 0);
      strokeWeight(5);
      point(x, y);
    }
  }
  void update() {
    switch(direcao) {
    case -1: 
      x=x-velocidade;  
      break;
    case 1: 
      x=x+velocidade; 
      break;
    }

    if (x>width-margem_dir) {
      direcao*=-1;
    }
    if (x<0+margem_esq) {
      direcao*=-1;
    }
    if (y>height-margem_inf) {
      y=0;
    }
    if (y<0) {
      y=height-margem_sup;
    }
  }
}
