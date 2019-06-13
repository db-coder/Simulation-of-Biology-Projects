void keyPressed()
{
  if(key == 'i') 
    reset();
  if(key == 'd')
    diffusion = !diffusion;
  if(key == 'u')
  {
    drawU = true;
    drawV = false;
  }
  if(key == 'v')
  {
    drawV = true;
    drawU = false;
  }
  if(key == ' ')
  {
    animating = !animating;
  }
  if(key == 'p')
  {
    spatial = !spatial;
  }
  if(key == '1')    //spots
  {
    k = 0.0625;
    f = 0.035;
  }
  if(key == '2')    //stripes
  {
    k = 0.06;
    f = 0.035;
  }
  if(key == '3')    //spirals
  {
    k = 0.0475;
    f = 0.0118;
  }
  if(key == '4')    //coral growth
  {
    k = 0.062;
    f = 0.0545;
  }
  if(key == '5')    //mitosis
  {
    k = 0.0649;
    f = 0.0367;
  }
}

void mousePressed()
{
  int x = (int)mouseX/cellSize;
  int y = (int)mouseY/cellSize;
  
  println("u: ", u[x][y], " v: ", v[x][y]);
}
