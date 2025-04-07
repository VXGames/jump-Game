class Button {
  
  float x, y, sizeX, sizeY, crop;
  
  Button (float x, float y, float sizeX, float sizeY, float crop) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.crop = crop;
  }
  
  
  void draw () {
    rect(x, y, sizeX, sizeY, crop);
  }
  
  boolean active () {
    if (mouseX >= x && mouseX <= x + sizeX && mouseY >= y && mouseY <= y + sizeY) {
      return true;
    }
    return false;
  }
}
