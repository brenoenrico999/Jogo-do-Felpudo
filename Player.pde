class Player {

  float x;
  float y;
  float escalaX;
  float escalaY;

  String imagem;
  boolean ativo;
  boolean borda;
  float limites;
  int frames;
  float tempo;
  int direcaoX;
  int direcaoY;

  float velocidade;
  PImage img;
  float imgL;
  float imgA;

  String strAnim="IDLE";
  String strDir="DOWN";
  float contadorFrames=1;

  int tempoInicial;
  boolean piscaHit;
  float hit = 0.0f;

  Player(String imagem, float x, float y, float escalaX, float escalaY, boolean borda, int frames, float tempo, float velocidade, float limites ) {
    this.imagem = imagem;
    this.x = x;
    this.y = y;
    this.escalaX = escalaX;
    this.escalaY = escalaY; 
    this.borda = borda;
    this.frames = frames;
    this.tempo = tempo;
    this.velocidade = velocidade;

    this.ativo = true;
    this.limites = limites;
    img = loadImage(imagem+"/"+strAnim+"/"+strDir+"/"+int(contadorFrames)+".png");
    imgL=img.width;
    imgA=img.height;

    tempoInicial = second();
  }

  void update() {

    contadorFrames+=0.5f;
    if (contadorFrames>frames) {
      contadorFrames=1;
    }

    x+=velocidade*direcaoX;
    y+=velocidade*direcaoY;

    if (x>width-imgL*escalaX) {
      direcaoX=-1;
      x=width-imgL*escalaX;
    } else if (x<0) {
      direcaoX=1;
      x=0;
    }

    if (y>height-imgA*escalaY) {
      direcaoY=-1;
      y=height-imgA*escalaY;
    } else if (y<0) {
      direcaoY=1;
      y=0;
    }

    switch(direcaoX) {
    case -1:
      strAnim="WALK";
      strDir="LEFT"; 
      break;
    case 1:
      strAnim="WALK";
      strDir="RIGHT"; 
      break;
    }

    switch(direcaoY) {
    case -1:
      strAnim="WALK";
      strDir="UP"; 
      break;
    case 1:
      strAnim="WALK";
      strDir="DOWN"; 
      break;
    }
  }

  void display() { 

    if (piscaHit) {
      hit = 360;
      piscaHit=false;
      invencivel=true;
    }

    if (hit>0.5f) {
      hit-=15.0f;
      if (((millis()/100)%2==0)) {
        tint(255, 0, 0, 150);
      } else {
        tint(255, 0, 0, 255);
      }
    } else {
      invencivel=false;
    }






    img = loadImage(imagem+"/"+strAnim+"/"+strDir+"/"+int(contadorFrames)+".png");
    image(img, x-(imgL*escalaX)/2, y-(imgA*escalaY)/2, imgL*escalaX, imgA*escalaY);
    noTint();


    if (borda) {
      fill(color(255, 255, 0, 255));
      stroke(255);
      strokeWeight(1);
      //rect(x, y, imgL*escalaX, imgA*escalaY, 12);

      noFill();
      strokeWeight(2);
      stroke(color(255, 255, 0)); 
      ellipse(  x, y, limites, limites);

      stroke(255, 255, 0);
      strokeWeight(5);
      point(x, y);
    };
  }
}
