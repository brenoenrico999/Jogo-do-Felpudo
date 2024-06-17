class CenaIntroducao extends Scene {
  int tempo = 60;
  int lastTime ;
  int delta = 0;
  PFont fonteHUD;
  PImage img_felpudo;

  float fl;
  float fa;
  MessageBox msg;
  CenaIntroducao(color bg, boolean ativa) {
    super(bg, ativa);
    lastTime = second();
    img_felpudo = loadImage("felpudo_google_glass.png");
    fl = img_felpudo.width*0.75;
    fa = img_felpudo.height*0.75;

    msg = new MessageBox(mensagem, "icone_felpudo.png");
  }

  void display() {
    textSize(52);
    fill(bg);
    background(bg);
    fill(50);
    tempo = (second()-lastTime);
    noStroke();
    fill(30);
    rect( 0, 40, width, 80);

    fonteHUD = createFont("Ringbearer.ttf", 52);
    textAlign(CENTER, TOP);
    textFont(fonteHUD);
    fill(cores[1]);
    text("The Legend of Felpudo", 0, 50, width, 160); 




    pushMatrix(); 
    scale(-1, 1.0); 
    image(img_felpudo, -width/2-fl/2, height/2-fa/2, fl, fa);
    popMatrix();
    
    msg.update();
  }
}
