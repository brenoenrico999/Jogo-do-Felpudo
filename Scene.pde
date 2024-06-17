class Scene {
  boolean ativa;
  color bg ; 

  Scene(color bg, boolean ativa) {
    this.bg = bg;
    this.ativa = ativa;
  }

  void display() {
    background(bg);
  }
  void update() {
  }
}
