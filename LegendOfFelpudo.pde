int[] cores = {#ab9758, #d00b1c, #A50303, #EAB00E, #ECFF27, #86C13B, #31A4CB, #B532F7, #E34E8C, #606060, #FEFEFE, #428B18};
float[][] gridPontos;
boolean invencivel=false;
String tiles_string;
JSONObject json;
ArrayList<Scene> cenas;

String mensagem;
String mensagemFofura;

CenaIntroducao cenaIntro;
CenaGame cenaGame;
Hud hud;

int tempo;
int score;
int inimigos;
int peninhas;
int moedas;
int vidas=9;

int n_moedas;
int n_peninhas;
int n_inimigos;


String mensagemEndGame="xxx";


boolean acabou;

String produto;
float versao;
String lancamento;
boolean demo;

float margem_esq;
float margem_dir;
float margem_sup;
float margem_inf;

float colunas;
float itens;

//int q_moeda;
//int q_inimigo;
//int q_tiro;
//int q_tempo;

int cont = 0;

void settings() {
  size(720, 486);
  //fullScreen();
}

void setup() {
  frameRate(30);
  carregaJson();
  gridPontos = new float[int(itens)][2];
  desenhaGrid(false, false, false, false, false);

  cenas = new ArrayList<Scene>();
  cenas.add(new Scene(cores[0], false));
  cenas.add(new Scene(cores[1], false));
  cenas.add(new Scene(cores[2], false));
  cenaIntro = new CenaIntroducao(cores[0], true);
  cenaGame = new CenaGame(0, false); 
  hud = new Hud(true, true, true, 60);
}

void draw() { 

  if (cenaIntro.ativa) {
    cenaIntro.update();
    cenaIntro.display();
  }

  if (cenaGame.ativa) { 
    cenaGame.update();
    cenaGame.display();
    desenhaGrid( false,false, false, false, false);
    hud.update();
    hud.display();
  }
}
void keyTyped() { 
  if (int(key)==120) { 
    if (!cenaGame.ativa) {
      clear();
      cenaIntro.ativa=false;
      cenaGame.ativa=true;
    }
  }
}

void carregaJson() {
  json = loadJSONObject("dados.json"); 

  JSONObject margens = new JSONObject() ;
  JSONObject quantidades = new JSONObject() ;
  JSONObject textos_box = new JSONObject() ;

  margens = json.getJSONObject("margens"); 
  quantidades = json.getJSONObject("quantidades");
  textos_box = json.getJSONObject("textos_box");

  tiles_string = json.getString("tile_objetos");

  produto=json.getString("produto");
  versao=json.getFloat("versao");
  lancamento=json.getString("releaseDate");
  demo=json.getBoolean("demo"); 

  mensagem = textos_box.getString("msg_felpudo1");
  mensagemFofura = textos_box.getString("msg_fofura1");

  margem_esq = margens.getFloat("margem_esq");
  margem_dir = margens.getFloat("margem_dir");
  margem_sup = margens.getFloat("margem_sup");
  margem_inf = margens.getFloat("margem_inf");

  colunas = quantidades.getFloat("colunas");
  itens = quantidades.getFloat("itens"); 

  //moedas=quantidades.getInt("moedas");
  //inimigos=quantidades.getInt("inimigos");
  //peninhas=quantidades.getInt("tiros");
  tempo=quantidades.getInt("tempo");
}

void desenhaGrid(boolean displayBorder, boolean displayGrid, boolean displayPoints, boolean displayColors, boolean displayMousePosition) {

  int linhas = floor(itens/colunas);
  float espacol = (width-margem_esq-margem_dir)/colunas;
  float espacoa = (height-margem_sup-margem_inf)/linhas;

  if (displayGrid) {
    strokeWeight(1);
    stroke(cores[3]); 
    for (int i=0; i<=colunas; i++) {
      line(margem_esq+i*espacol, margem_sup, margem_esq+i*espacol, height-margem_inf);
    }

    for (int i=0; i<=linhas; i++) {
      line(margem_esq, margem_sup+i*espacoa, width-margem_dir, margem_sup+i*espacoa);
    }
  }


  if (displayBorder) {
    strokeWeight(3);
    stroke(cores[4]);
    noFill(); 
    rect(margem_esq, margem_sup, width-margem_dir-margem_esq, height-margem_inf-margem_sup);
  }

  stroke(cores[4]);
  strokeWeight(5);
  for (int i=0; i<itens; i++) {
    float _px = i%colunas*espacol+margem_esq+espacol*0.5;
    float _py = margem_sup+espacoa*0.5+ (floor(i/colunas))*espacoa;
    gridPontos[i][0]=_px;
    gridPontos[i][1]=_py;
    if (displayPoints) { 
      point(_px, _py);
    }
  }

  if (displayColors) {
    for (int i=0; i<cores.length; i++) {
      fill(cores[i]);
      stroke(0);
      strokeWeight(3);
      rect(i*width/cores.length, height-30, width/cores.length, 30);
      fill(30);
      textAlign(CENTER, CENTER);
      textSize(12);
      text(""+i, i*width/cores.length, height-30, width/cores.length, 30);
    }
  }

  if (displayMousePosition) {
    textAlign(TOP, RIGHT);
    textSize(12);
    fill(255);
    text("x-"+mouseX+" y-"+mouseY, 10, height-30, 120, 20);
    if (mousePressed) {
      println(""+mouseX+","+mouseY);
    }
  }
}


void keyPressed() {
  if (!acabou) {
    cenaGame.apertouBotao(keyCode);
  }
}
void keyReleased() { 
  if (!acabou) {
    cenaGame.soltouBotao();
  }
}
