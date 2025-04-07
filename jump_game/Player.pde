class Player {
  
  float x, y, sizeX, sizeY;
  
  float gravity;
  float vy = 0;
  float jump;
  boolean onGround = false;
  
  Player (float x, float y, float sizeX, float sizeY) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    
    gravity = 800*px;
    jump = -500*px;
  }
  
  void draw () {
    if (!game.gameOver) {
      updateFisica();
    }
    rect(x, y, sizeX, sizeY, 10*px);
  }
  
  void updateFisica () {
    if (!onGround) {
      vy += gravity*deltaTime;
      y += vy*deltaTime;
    }
  }
  
}
