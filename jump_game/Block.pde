class Block {
  
  float x, y, sizeX, sizeY;
  
  Block (float x, float y, float sizeX, float sizeY) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  void draw () {
    rect(x, y, sizeX, sizeY, 15*px);
  }
  
}
