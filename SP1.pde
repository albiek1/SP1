/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */
 
import java.util.Random;

Game game = new Game(30, 20, 5, 5);
PFont font;
int gameState = 0;
String winner;

public void settings() {
  size(1201, 801);
}

void setup()
{
  frameRate(10);
  font = createFont("Arial", 16, true);
  textFont(font, 16);
}

void keyReleased()
{
  game.onKeyReleased(key);
}

void keyPressed()
{
  game.onKeyPressed(key);
}

void draw()
{
  if(gameState == 0){
    menuScreen();
  }else if(gameState == 1){
    gameScreen();
  }else if(gameState == 2){
    gameOver();
  }
}

void menuScreen(){
  game.playerLife = 100;
  game.player2Life = 100;
  background(0);
  textSize(60);
  fill(255, 0, 0);
  text("S.P.1", width/2-100, height/2);
  fill(255);
  textSize(50);
  text("Click to start", width/2-150, height/2+100);
  rectMode(CENTER);
  fill(0, 0, 255);
  rect(200, height/2, 200, 200);
  fill(255, 255, 0);
  rect(1000, height/2, 200, 200);
  if(mousePressed){
      gameState = 1;
    
  }
}

void gameScreen(){  
  game.update();
  background(0);
  //Black
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  rectMode(CORNER);
  int[][] board = game.getBoard();
  for (int y = 0; y < game.getHeight(); y++)
  {
    for (int x = 0; x < game.getWidth(); x++)
    {
      if(board[x][y] == 0)
      {
        fill(0,0,0);
      }
      else if(board[x][y] == 1)
      {
        fill(0,0,255);
      }
      else if(board[x][y] == 2)
      {
        fill(255,0,0);
      }
      else if(board[x][y] == 3)
      {
        fill(0,255,0);
      }
      else if(board[x][y] == 4){
        fill(255, 255, 0);
      }
      stroke(100,100,100);
      rect(x*40, y*40, 40, 40);
    }
  }
  fill(255);
  textSize(16);
  text("Lifes: "+game.getPlayerLife(), 25,25);
  text("Lifes: "+game.getPlayer2Life(), 1100, 25);
  if(game.playerLife <= 0){
    winner = "player 2";
    gameState = 2; 
  }
  if(game.player2Life <= 0){
    winner = "Player 1";
    gameState = 2;
  }
}

void gameOver(){
  background(255);
  fill(0);
  textSize(50);
  text(winner + " wins!", width/2-200, height/2);
  if(mousePressed){
    gameState = 0;
  }
}
