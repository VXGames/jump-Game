class Game {
  
  Button play;
  Button returnToMenu;
  Button again;
  Button settingsButton;
  Button left, right;
  Button activeAutoJump;
  
  Player player;
  
  ArrayList <Block> platforms = new ArrayList<>();
  
  boolean gameOver = false;
  boolean autoJump = true;
  boolean A = false, D = false;
  boolean openSetting = false;
  boolean openvx = false;
  
  int keyMode = 1;
  int maxScore = 0;
  int score = 0;
  float vxopacity = 0;
  float vxtime = 0;
  
  float lastPos = 0;
  float playerSpeed;
  float blockSpeed;
  
  String scene = "vx";
  
  PImage retryImage;
  PImage closeImage;
  PImage settingImage;
  PImage leftImage;
  PImage rightImage;
  PImage activeImage;
  PImage vortexGames;
  
  Game () {
    play = new Button(width/2-150*px, height/2-50*px, 300*px, 100*px, 15*px);
    player = new Player(play.x+play.sizeX/2-25*px, height/2-50*px-50*px, 50*px, 50*px);
    platforms.add(new Block(width/2-150*px, height/2-50*px, 300*px, 100*px));
    returnToMenu = new Button(width/2+50*px, height/2+50*px, 100*px, 100*px, 10*px);
    again = new Button(width/2-150*px, height/2+50*px, 100*px, 100*px, 10*px);
    playerSpeed = 500*px;
    blockSpeed = 5*px;
    retryImage = loadImage("retry.png");
    closeImage = loadImage("x.png");
    settingsButton = new Button(50*px, height-75*px-50*px, 75*px, 75*px, 10*px);
    settingImage = loadImage("settings.png");
    left = new Button(185*px, 270*px, 50*px, 50*px, 10*px);
    right = new Button(400*px, 270*px, 50*px, 50*px, 10*px);
    leftImage = loadImage("left.png");
    rightImage = loadImage("right.png");
    activeAutoJump = new Button(200*px, 340*px, 50*px, 50*px, 10*px);
    activeImage = loadImage("active.png");
    vortexGames = loadImage("vortexGames.png");
  }
  
  void initMenu () {
    scene = "menu";
    gameOver = false;
    if (platforms != null) {
      platforms.clear();
    }
    score = 0;
    lastPos = 0;
    play = new Button(width/2-150*px, height/2-50*px, 300*px, 100*px, 15*px);
    player = new Player(play.x+play.sizeX/2-25*px, height/2-50*px-50*px, 50*px, 50*px);
    platforms.add(new Block(width/2-150*px, height/2-50*px, 300*px, 100*px));
  }
  
  void againGame () {
    if (platforms != null) {
      platforms.clear();
    }
    score = 0;
    lastPos = 0;
    play = new Button(width/2-150*px, height/2-50*px, 300*px, 100*px, 15*px);
    player = new Player(play.x+play.sizeX/2-25*px, height/2-50*px-50*px, 50*px, 50*px);
    platforms.add(new Block(width/2-150*px, height/2-50*px, 300*px, 100*px));
    gameOver = false;
    scene = "game";
  }
  
  void render () {
    vxgames();
    if (scene == "game" || scene == "menu") {
      fill(255);
      play.draw();
      
      
      moveCam();
      playerMove();
      if (scene == "game" && autoJump) {
        jumpGamePlayer();
      }
      player.draw();
      fill(255);
      removePlatforms();
      renderMap();
      fill(0);
      textSize(40*px);
      text("PLAY", width/2-40*px, play.y+play.sizeY/2+10*px);
      
      textSize(35*px);
      fill(255);
      text("MaxScore: " + maxScore, 50*px, 50*px);
      text("Score: " + score, 50*px, 100*px);
      gameOverTab();
      hud();
    }
  }
  
  void playerMove () {
    if (A) {
      player.x -= playerSpeed*deltaTime;
    }
    
    if (D) {
      player.x += playerSpeed*deltaTime;
    }
    
    if (scene == "menu") {
      if (player.y >= height) {
        player.y = 0;
      }
    }
    
    if (player.x <= 0) {
      player.x = 0;
    } else if (player.x + player.sizeX >= width) {
      player.x = width - player.sizeX;
    }
    
    if (player.vy >= 5000) {
      player.vy = 5000;
    }
    
    if (scene == "game" && player.y >= height) {
      gameOver = true;
    }
    
    if (score >= maxScore) {
      maxScore = score;
    }
  }
  
  void isCollision (Block b) {
    if (player.x + player.sizeX >= b.x && player.x <= b.x + b.sizeX && player.y + player.sizeY >= b.y && player.y + player.sizeY - 10 * px <= b.y + b.sizeY && player.vy >= 0 && player.vy >= 0) {
      player.y = b.y - player.sizeY;
      player.vy = 0;
      lastPos = player.y;
      player.onGround = true;
    } else {
      player.onGround = false;
    }
  }
  
  void renderMap () {
    for (Block b : platforms) {
      if (b.y >= -100*px && b.y <= height+100*px) {
        isCollision(b);
        b.draw();
      }
    }
  }
  
  
  
  void jumpMenuPlayer () {
    if (scene == "menu" && player.onGround) {
      player.onGround = false;
      player.vy = player.jump;
    }
  }
  
  void jumpGamePlayer () {
    if (scene == "game" && player.y == lastPos) {
      player.onGround = false;
      player.vy = player.jump;
    }
  }
  
  void moveCam () {
    if (scene == "game") {
      if (player.y <= 200*px) {
        score++;
        play.y+=blockSpeed;
        player.y+=blockSpeed;
        genPlatforms();
        for (Block b : platforms) {
          b.y+=blockSpeed;
        }
      }
    }
  }
  
  void genPlatforms () {
    if (scene == "game") {
      if (platforms.size() < 50) {
       float x = random(100*px, width - 200*px);
       float y = platforms.get(platforms.size() - 1).y - 50*px;
       platforms.add(new Block(x, y, 100*px, 10*px));
      }
    }
  }
  
  void removePlatforms () {
    if (scene == "game") {
      for (int i = platforms.size() - 1; i >= 0; i--) {
        if (platforms.get(i).y >= height) {
            platforms.remove(i);
        }
      }
    }
  }
  
  void gameOverTab () {
    if (scene == "game" && gameOver) {
      fill(255);
      rect(width/2-200*px, height/2-200*px, 400*px, 400*px, 50*px);
      returnToMenu.draw();
      again.draw();
      image(retryImage, again.x+5*px, again.y+5*px, again.sizeX-10*px, again.sizeY-10*px);
      image(closeImage, returnToMenu.x, returnToMenu.y, returnToMenu.sizeX, returnToMenu.sizeY);
      textSize(40*px);
      fill(0);
      text("Game Over", width/2-80*px, height/2-150*px);
      text("Score", width/2-150*px, height/2-100*px);
      text(score, width/2-50*px, height/2-100*px);
      text("MaxScore", width/2-150*px, height/2-50*px);
      text(maxScore, width/2+20*px, height/2-50*px);
    }
    
  }
  
  void hud () {
    if (scene == "menu") {
      settingsButton.draw();
      image(settingImage, settingsButton.x+5*px, settingsButton.y+5*px, settingsButton.sizeX-10*px, settingsButton.sizeY-10*px);
    }
    
    openSettings();
  }
  
  void openSettings () {
    if (openSetting) {
      textSize(30*px);
      text("KeyMode: ", 50*px, 300*px);
      
      if (keyMode == 1) {
        text("A - D", 250*px, 300*px);
        right.x = 320*px;
      } else if (keyMode == 2) {
        text("Left - Right", 250*px, 300*px);
        right.x = 400*px;
      }
      
      left.draw();
      right.draw();
      
      image(leftImage, left.x, left.y+5*px, left.sizeX, left.sizeY-10*px);
      image(rightImage, right.x, right.y+5*px, right.sizeX, right.sizeY-10*px);
      
      text("AutoJump: ", 50*px, 375*px);
      activeAutoJump.draw();
      
      if (autoJump) {
        image(activeImage, activeAutoJump.x, activeAutoJump.y, activeAutoJump.sizeX, activeAutoJump.sizeY);
      }
    }
  }
  
  void vxgames () {
    if (scene == "vx") {
      tint(255, vxopacity);
      image(vortexGames, 0, 0, width, height);
      tint(255, 255);
      
      if (!openvx && vxopacity != 255) {
        vxopacity += 2.5;
      } else if (!openvx && vxopacity == 255) {
        openvx = true;
      } else if (openvx && vxopacity != 0) {
        vxopacity-=2.5;
      } else if (openvx && vxopacity == 0) {
        vxtime += 2 * deltaTime;
        if (vxtime >= 3) {
          background = 32;
          initMenu();
        }
      }
    }
  }
  
  void mousePressed () {
    if (scene == "menu" && play.active() && player.y == play.y - player.sizeY && !openSetting) {
      scene = "game";
    }
    
    if (gameOver && returnToMenu.active()) {
      initMenu();
    }
    
    if (gameOver && again.active()) {
      againGame();
    }
    
    if (settingsButton.active()) {
      if (scene == "menu") {
        if (!openSetting) {
          openSetting = true;
        } else {
          openSetting = false;
        }
      }
    }
    
    if (openSetting && left.active()) {
      keyMode = 1;
    }
    
    if (openSetting && right.active()) {
      keyMode = 2;
    }
    
    if (openSetting && activeAutoJump.active()) {
      if (autoJump) {
        autoJump = false;
      } else {
        autoJump = true;
      }
    }
    
  }
  
  void keyPressed () {
    switch (keyMode) {
      case 1:
      if (key == 'a' || key == 'A') {
        A = true;
      }
      
      if (key == 'd' || key == 'D') {
        D = true;
      }
      
      if (key == ' ') {
        jumpMenuPlayer();
      }
      break;
      
      case 2:
      
      if (keyCode == LEFT) {
        A = true;
      }
      
      if (keyCode == RIGHT) {
        D = true;
      }
      
      break;
    }
    
    if (key == ' ' && !autoJump) {
      jumpGamePlayer();
    }
  }
  
  void keyReleased () {
    switch (keyMode) {
      case 1:
      if (key == 'a' || key == 'A') {
        A = false;
      }
      
      if (key == 'd' || key == 'D') {
        D = false;
      }
      break;
      
      case 2:
      
      if (keyCode == LEFT) {
        A = false;
      }
      
      if (keyCode == RIGHT) {
        D = false;
      }
      
      break;
    }
  }
  
}
