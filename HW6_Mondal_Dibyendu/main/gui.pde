void keyPressed()
{
  if(key == 's')
  {
    step = !step;
    //animating = true;
  }
  if(key == ' ')
  {
    animating = !animating;
    //step = false;
  }
}
void mouseDragged()
{
  pressed = true;
  //posX = mouseX;
  //posY = mouseY;
}
void mouseReleased()
{
  pressed = false;
}
