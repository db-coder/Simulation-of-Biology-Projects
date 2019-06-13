void keyPressed()
{
  if(key == 'r') 
    reset();
  if(key == '-')
  {
    if(cellSize > 1)
    {
      cellSize--;
      reset();
    }
  }
  if(key == '=')
  {
    if(cellSize < 16)
    {
      cellSize++;
      reset();
    }
  }
  if(key == ' ')
  {
    animating = !animating;
  }
  if(key == 's')
  {
    step = !step;
  }
}

void mousePressed()
{
  int x = (int)mouseX/cellSize;
  int y = (int)mouseY/cellSize;
  
  for(int j = 0; j < sharks.size(); j++)
  {
    organism shark = sharks.get(j);
    if(shark.x == x && shark.y == y)
    {
      println("fish: ", shark.age);
    }
  }
}
