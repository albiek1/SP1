import java.util.Random;

class Game
{
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  int player2Life;
  private Dot player;
  Dot player2;
  private Dot[] enemies;
  Dot[] food;
  
   
  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if(width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if(numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0,0,width-1, height-1);
    player2 = new Dot(0, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    food = new Dot[numberOfFood];
    for(int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    for(int k = 0; k < numberOfFood; k++){
      food[k] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.player2Life = 100;
  }
  
  public int getWidth()
  {
    return width;
  }
  
  public int getHeight()
  {
    return height;
  }
  
  public int getPlayerLife()
  {
    return playerLife;
  }
  
  public int getPlayer2Life(){
    return player2Life;
  }
  
  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }
  
  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }
  
  public void update()
  {
    updatePlayer();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }
  
  
  
  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }
  
  private void clearBoard()
  {
    for(int y = 0; y < height; ++y)
    {
      for(int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }
  
  private void updatePlayer()
  {
    playerLife = constrain(playerLife, 0, 100);
    player2Life = constrain(player2Life, 0, 100);
    //Update player
    if(keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if(keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if(keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if(keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
    if(keys.upDown() && !keys.dnDown()){
      player2.moveUp();
    }
    if(keys.lfDown() && !keys.rtDown()){
      player2.moveLeft();
    }
    if(keys.dnDown() && !keys.upDown()){
      player2.moveDown();
    }
    if(keys.rtDown() && !keys.lfDown()){
      player2.moveRight();
    }
  }  
  
  void updateFood(){
    for(int i = 0; i < food.length; i++){
      if(dist(player.getX(), player.getY(), food[i].getX(), food[i].getY()) < dist(player2.getX(), player2.getY(), food[i].getX(), food[i].getY())){
        if(int(random(3)) < 2)
        {
          //We follow
          int dx = player.getX() - enemies[i].getX();
          int dy = player.getY() - enemies[i].getY();
          if(abs(dx) > abs(dy))
          {
            if(dx > 0)
            {
              //Player is to the right
              food[i].moveLeft();
            }
            else
            {
              //Player is to the left
              food[i].moveRight();
            }
          }
          else if(dy > 0)
          {
            //Player is down;
            food[i].moveUp();
          }
          else
          {//Player is up;
            food[i].moveDown();
          }
        }
        else
        {
          //We move randomly
          int move = int(random(4));
          if(move == 0)
          {
            //Move right
            food[i].moveRight();
          }
          else if(move == 1)
          {
            //Move left
            food[i].moveLeft();
          }
          else if(move == 2)
          {
            //Move up
            food[i].moveUp();
          }
          else if(move == 3)
          {
            //Move down
            food[i].moveDown();
          }
        }
      }else if(dist(player.getX(), player.getY(), food[i].getX(), food[i].getY()) > dist(player2.getX(), player2.getY(), food[i].getX(), food[i].getY())){
        if(int(random(3)) < 2){
          int dx2 = player2.getX() - food[i].getX();
          int dy2 = player2.getY() - food[i].getY();
          if(abs(dx2) > abs(dy2)){
            if(dx2 > 0){
              food[i].moveLeft();
            }else{
              food[i].moveRight();
            }
          }else if(dy2 > 0){
            food[i].moveUp();
          }else{
            food[i].moveDown();
          }
        }else{
          int move = int(random(4));
          if(move == 0){
            food[i].moveRight();
          }else if(move == 1){
            food[i].moveLeft();
          }else if(move == 2){
            food[i].moveUp();
          }else if(move == 3){
            food[i].moveDown();
          }
        }
      }
    }
  }
  
  private void updateEnemies()
  {
    for(int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if(dist(player.getX(), player.getY(), enemies[i].getX(), enemies[i].getY()) < dist(player2.getX(), player2.getY(), enemies[i].getX(), enemies[i].getY())){
        if(int(random(3)) < 2)
        {
          //We follow
          int dx = player.getX() - enemies[i].getX();
          int dy = player.getY() - enemies[i].getY();
          if(abs(dx) > abs(dy))
          {
            if(dx > 0)
            {
              //Player is to the right
              enemies[i].moveRight();
            }
            else
            {
              //Player is to the left
              enemies[i].moveLeft();
            }
          }
          else if(dy > 0)
          {
            //Player is down;
            enemies[i].moveDown();
          }
          else
          {//Player is up;
            enemies[i].moveUp();
          }
        }
        else
        {
          //We move randomly
          int move = int(random(5));
          if(move == 0)
          {
            //Move right
            enemies[i].moveRight();
          }
          else if(move == 1)
          {
            //Move left
            enemies[i].moveLeft();
          }
          else if(move == 2)
          {
            //Move up
            enemies[i].moveUp();
          }
          else if(move == 3)
          {
            //Move down
            enemies[i].moveDown();
          }
        }
      }else if(dist(player.getX(), player.getY(), enemies[i].getX(), enemies[i].getY()) > dist(player2.getX(), player2.getY(), enemies[i].getX(), enemies[i].getY())){
        if(int(random(3)) < 2){
          int dx2 = player2.getX() - enemies[i].getX();
          int dy2 = player2.getY() - enemies[i].getY();
          if(abs(dx2) > abs(dy2)){
            if(dx2 > 0){
              enemies[i].moveRight();
            }else{
              enemies[i].moveLeft();
            }
            if(dy2 > 0){
              enemies[i].moveDown();
            }else{
              enemies[i].moveUp();
            }
          }else{
            int move = int(random(5));
            if(move == 0)
            {
              //Move right
              enemies[i].moveRight();
            }
            else if(move == 1)
            {
              //Move left
              enemies[i].moveLeft();
            }
            else if(move == 2)
            {
              //Move up
              enemies[i].moveUp();
            }
            else if(move == 3)
            {
              //Move down
              enemies[i].moveDown();
            }
          }
        }
      }
    }
  }
  
  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for(int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    for(int k = 0; k < food.length; k++){
      board[food[k].getX()][food[k].getY()] = 3;
    }
  }
   
  private void checkForCollisions()
  {
    //Check enemy collisions
    for(int i = 0; i < enemies.length; ++i)
    {
      if(enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      }
      if(enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY()){
        player2Life--;
      }
    }
    for(int k = food.length-1; k > 0; k--){
      if(food[k].getX() == player.getX() && food[k].getY() == player.getY()){
        playerLife++;
        food[k].x = int(random(width-1));
        food[k].y = int(random(height-1));
      }
      if(food[k].getX() == player2.getX() && food[k].getY() == player2.getY()){
        player2Life++;
        food[k].x = int(random(width-1));
        food[k].y = int(random(height-1));
      }
    }
  }
}
