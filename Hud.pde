class Hud {

  boolean showLife;
  boolean showCoins;
  boolean showScore;


  boolean comecou;


  ArrayList<PImage> imagensLife;
  PImage imgCoin;
  PImage imgPena;
  PImage imgLife;

  PFont fonteHud;
  int time;
  int initTime;
  int timePast;

  Hud(boolean showLife, boolean showCoins, boolean showScore, int time) {
    this.showLife = showLife;
    this.showCoins = showCoins;
    this.showScore = showScore;
    this.time = time;

    imgCoin=loadImage("MOEDA/MOEDA1.png");


    imgLife=loadImage("HUD/HUD"+vidas+".png");
    imgPena=loadImage("PENINHA/PENINHA1.png");

    fonteHud = createFont("trueCrimes.ttf", 21);
    initTime = second();
  }

  void update() {
    time=second()-initTime;
  }
  void display() {
    fill(30, 30, 30, 50);
    strokeWeight(1);
    stroke(255);

    //rect(36, 45, 182, 45, 12);
    //rect(519, 45, 165, 45, 12);
    imgLife=loadImage("HUD/HUD"+vidas+".png");
    image(imgLife, 7, 7, 96, 96);

    fill(255);
    textSize(21);
    textAlign(LEFT, CENTER);
    textFont(fonteHud);

    text("Score: "+score, 121, 35, 200, 30);
    text("Tempo: "+time, 122, 70, 200, 30 );
    text("x "+moedas, 592, 35, 200, 30 );
    text("x "+peninhas, 593, 70, 200, 30 );


    image(imgCoin, 554, 41, imgCoin.width/1.3f, imgCoin.height/1.3f);
    image(imgPena, 547, 69, imgPena.width/1.5f, imgPena.height/1.5f);

    //text(""+vidas, 46, 22);
    //text("x"+moedas, 125+imgCoin.width/1.3f+3, 47+imgCoin.height/1.3f/2);
    //text("x"+peninhas, 547+imgPena.width/1.5f+3, 47+imgPena.height/1.5f/2);
  }

  void pegouPena() {
    score+=20;
    peninhas++;
  }
  void pegouMoeda() {
    score+=10;
    moedas++;
  }
  void matouInimigo() {
    score+=100;
    n_inimigos--;
    if (n_inimigos==0) {
      
      mensagemEndGame = "Voce GANHOU!\n\nCréditos:\nBreno\nLeonardo";
      acabou=true;
    }
  }
  void tomouPancada() {
    
    if (vidas==1) {
      fimDeJogo();
    } 
  }
  void fimDeJogo() {
    acabou=true;
    if (vidas==1) {
      mensagemEndGame = "Voce PERDEU!\n\nCréditos:\nBreno\nLeonardo";
    } 
    
     
  }
}
