Game game;

float px;
int background = 0;

void setup () {
  fullScreen(P2D);
  //size(640, 360, P2D);
  frameRate(60);
  screenOptimization();
  initClasses();
  timeStart();
}

void draw () {
  timeUpdate();
  background(background);
  game.render();
}

void mousePressed () {
  game.mousePressed();
}

void keyPressed () {
  game.keyPressed();
}

void keyReleased () {
  game.keyReleased();
}

void initClasses () {
  game = new Game();
}

void screenOptimization () {
  if (width < height) {
    px = (float) width/720;
  } else {
    px = (float) height/720;
  }
}
