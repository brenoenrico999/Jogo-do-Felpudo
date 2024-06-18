class CenaGame extends Scene {
  PImage img_bg;  
  ArrayList<Actor> actors;
  ArrayList<Particle> particles;
  ArrayList<Enemy> enemies;
  ArrayList<Explosao> explosoes;
  ArrayList<MessageBox> mensagens;

  Player player;
  Actor fofura;

  ArrayList<Shot> shots;
  int lastDx=0;
  int lastDy=1;
  PFont fonteHUD;

  
  CenaGame(color bg, boolean ativa) {
    super(bg, ativa);
    img_bg = loadImage("BACKGROUND.jpg"); 
    int[] itensCena = new int[tiles_string.length()]; 

    for (int i=0; i<tiles_string.length(); i++) {
      char letraVez = tiles_string.charAt(i);
      String stringVez = String.valueOf(letraVez);
      int digitoNumero = Integer.parseInt(stringVez);
      itensCena[i]=digitoNumero;
    }
    player = new Player("PLAYER", gridPontos[0][0], gridPontos[0][1], 0.75f, 0.75f, false, 7, 1.0f, 3.75f, 55.0f);
    fofura = new Actor("FOFURA", width/2+10, 70, 0.8f, 0.8f, false, 25, 7, 1);

    shots = new ArrayList<Shot>();

    actors = new ArrayList<Actor>();
    particles = new ArrayList<Particle>();
    enemies = new ArrayList<Enemy>();
    explosoes = new ArrayList<Explosao>();
    mensagens = new ArrayList<MessageBox>();
   
  
    for (int i=0; i<gridPontos.length; i++) {
      Actor actor;
      switch(itensCena[i]) {
      case 1:      
        actor = new Actor("MOEDA", gridPontos[i][0], gridPontos[i][1], 0.8f, 0.8f, false, 25, 6, 1);
        actors.add(actor);
        n_moedas++;
        break;
      case 2: 
        actor = new Actor("PENINHA", gridPontos[i][0], gridPontos[i][1], 0.8f, 0.8f, false, 25, 6, 2);
        actors.add(actor);
        n_peninhas++;
        break;
      case 3: 
        Enemy enemy = new Enemy("LESMO", gridPontos[i][0], gridPontos[i][1], 0.8f, 0.8f, true, -1, false, 25);
        enemies.add(enemy);
        n_inimigos++;
        break;
      case 4: 
        Enemy enemy2 = new Enemy("LESMO", gridPontos[i][0], gridPontos[i][1], 0.8f, 0.8f, true, 1, false, 25);
        enemies.add(enemy2);
        n_inimigos++;
        break;
      default: 
        break;
      }
    }
  }

  void update() {

    if (!acabou) {
      for (Actor m : actors) { 
        float distCoinm = dist(player.x, player.y, m.x, m.y);
        if (distCoinm<=((player.limites+m.limites)/2)) {
          criaParticula(m.x, m.y);
          m.x=9999;
          m.y=9999;
          switch(m.tipoDeObjeto) {
          case 1: 
            hud.pegouMoeda();
            break; 
          case 2: 
            hud.pegouPena();
            break;
          }
        }
      }
      for (Enemy e : enemies) { 
        for (Shot s : shots) {
          float distEnemy = dist(s.x, s.y, e.x, e.y);
          if (distEnemy<=e.limites) {
            criaExplosao(e.x, e.y);
            e.x=9999;
            e.y=9999;
            s.x=9999;
            s.y=9999;
            hud.matouInimigo();
          }
        }
      }


      for (Enemy e : enemies) {
        if ((dist(player.x, player.y, e.x, e.y)<=50)&& !invencivel) {  
          player.x+=-player.direcaoX*50;
          player.y+=-player.direcaoY*50;
          player.piscaHit=true;
          if (vidas>=2) {
            vidas--;
          } else {
            hud.fimDeJogo();
          }
        }
      }

      float distFof = dist(player.x, player.y, fofura.x, fofura.y);
      if (distFof<=50) {
        if (mensagens.size()<1) {

          MessageBox msgb = new MessageBox(mensagemFofura, "icone_fofura.png");
          mensagens.add(msgb);
        }
      }
    }
  }


  void display() {  

    background(img_bg);

    //background(cores[cores.length-1]);

    //scale(2);
    //image(img_bg, 0, 0, width/2, height/2);
    //scale(1);



    for (int i=0; i<shots.size(); i++) { 
      Shot s = shots.get(i);
      s.update();
      s.display();

      if (!s.ativo) {
        shots.remove(i);
      }
    }

    for (Actor a : actors) { 
      a.update();
      a.display();
    }

    for (int i=0; i<explosoes.size(); i++) { 

      explosoes.get(i).update();
      explosoes.get(i).display();

      if (!explosoes.get(i).ativo) {
        explosoes.remove(i);
      }
    }

    for (Enemy e : enemies) { 
      e.update();
      e.display();
    }


    fofura.update();
    fofura.display();
    player.update();
    player.display();

    for (int i=0; i<particles.size(); i++) { 
      particles.get(i).update();
      particles.get(i).display();
      if (!particles.get(i).ativo) {
        particles.remove(i);
      }
    }

    for (int i=0; i<mensagens.size(); i++) {
      MessageBox m = mensagens.get(i); 
      if (!m.ativo) {
        mensagens.remove(i);
      } else {
        m.update();
      }
    }

    if (acabou) {
      fonteHUD = createFont("Ringbearer.ttf", 52);
      textAlign(CENTER, CENTER);
      fill(cores[3]);
      textFont(fonteHUD);
      textSize(52); 
      text(mensagemEndGame, 0, 0, width, height);
    }
  }

  void criaParticula(float x, float y) {
    Particle particle = new Particle(x, y, 0, 0);
    particles.add(particle);
  }

  void criaExplosao(float x, float y) {
    Explosao explosao = new Explosao("EXPLOSAO", x, y, 1, 1);
    explosoes.add(explosao);
  }






  void apertouBotao(int tecla) { 

    int escolha=0;
    if ((keyCode==87)||(keyCode==38)) {
      escolha=1;
    }
    if ((keyCode==83)||(keyCode==40)) {
      escolha=2;
    }
    if ((keyCode==65)||(keyCode==37)) {
      escolha=3;
    }
    if ((keyCode==68)||(keyCode==39)) {
      escolha=4;
    }
    if ((keyCode==32)) {
      escolha=5;
    }
    switch(escolha) { 
    case 1:
      player.direcaoX=0; 
      player.direcaoY=-1;
      playerm.rewind();
      playerm.play();
      break; 
    case 2:
      player.direcaoX=0; 
      player.direcaoY=1;
      playerx.rewind();
      playerx.play();
      break; 
    case 3:
      player.direcaoX=-1; 
      player.direcaoY=0;
      playery.rewind();
      playery.play();
      break; 
    case 4:
      player.direcaoX=1; 
      player.direcaoY=0;
      playerx.rewind();
      playerx.play();
      break;
    case 5: 
      atira();
      playerw.rewind();
      playerw.play();
      delay(100);
      playerw.pause();
      break;
    }
    if ((player.direcaoX!=0)||(player.direcaoY!=0)) {

      lastDx=player.direcaoX; 
      lastDy=player.direcaoY;
    }
  }

  void atira() {
    if (peninhas>0) {
      peninhas-=1;
      Shot shot = new Shot(player.x, player.y, lastDx, lastDy);
      shots.add(shot);
    }
  }

  public void soltouBotao() {
    if (!keyPressed) {
      player.strAnim="IDLE";
      player.direcaoX=0; 
      player.direcaoY=0;
    }
  }
}
