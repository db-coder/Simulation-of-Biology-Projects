void keyPressed()
{
  if(key == 'i') 
    reset();
  if(key == ' ')
  {
    animating = !animating;
  }
  if(key == '0')
  {
    dla = true;
    stick = 0.5;
    initialize();
    int i = int(random(cols));
    int j = int(random(rows));
    cell[i][j] = 1.0;
    
    i = int(random(cols));
    j = int(random(rows));
    cell[i][j] = 1.0;
  }
  if(key == '1')
  {
    dla = true;
    stick = 1.0;
    initialize();
  }
  if(key == '2')
  {
    dla = true;
    stick = 0.1;
    initialize();
  }
  if(key == '3')
  {
    dla = true;
    stick = 0.01;
    initialize();
  }
  if(key == '4')
  {
    dla = false;
    eta = 0;
    initialize();
  }
  if(key == '5')
  {
    dla = false;
    eta = 3;
    initialize();
  }
  if(key == '6')
  {
    dla = false;
    eta = 6;
    initialize();
  }
}

void mousePressed()
{
  int x = (int)mouseX/cellSize;
  int y = (int)mouseY/cellSize;
  
  println("u: ", cell[x][y]);
}
