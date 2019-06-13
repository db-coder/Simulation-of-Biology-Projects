void keyPressed()
{
  if(key == 'c' || key == 'C') 
    reset();
  if(key == 'r' || key == 'R')
    randomize();
  if(key == 'g' || key == 'G')
  {
    continuous = !continuous;
    if(continuous)
      singleStep = true;
  }
  if(key == ' ')
  {
    continuous = false;
    singleStep = true;
  }
}

void mousePressed()
{
  int x = (int)mouseX/6;
  int y = (int)mouseY/6;
  if(cell[x][y] == 255)
    cell[x][y] = 0;
  else
    cell[x][y] = 255;
}

void mouseDragged()
{
  int x = (int)mouseX/6;
  int y = (int)mouseY/6;
  if(cell[x][y] == 255)
    cell[x][y] = 0;
  else
    cell[x][y] = 255;
}
