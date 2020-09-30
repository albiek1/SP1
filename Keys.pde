class Keys
{
  boolean wDown = false;
  boolean aDown = false;
  boolean sDown = false;
  boolean dDown = false;
  
  boolean upDown = false;
  boolean lfDown = false;
  boolean dnDown = false;
  boolean rtDown = false;
  
  public Keys(){}
  
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
  public boolean upDown(){
    return upDown;
  }
  
  public boolean lfDown(){
    return lfDown;
  }
  
  public boolean dnDown(){
    return dnDown;
  }
  
  public boolean rtDown(){
    return rtDown;
  }
  
  
  void onKeyPressed(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = true;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = true;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = true;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = true;
    }
    if(key == CODED){
      if(keyCode == UP){
        upDown = true;
      }else if(keyCode == LEFT){
        lfDown = true;
      }else if(keyCode == DOWN){
        dnDown = true;
      }else if(keyCode == RIGHT){
        rtDown = true;
      }
    }
  }
  
  void onKeyReleased(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = false;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = false;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = false;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = false;
    }
    if(key == CODED){
      if(keyCode == UP){
        upDown = false;
      }else if(keyCode == LEFT){
        lfDown = false;
      }else if(keyCode == DOWN){
        dnDown = false;
      }else if(keyCode == RIGHT){
        rtDown = false;
      }
    }
  }
}
