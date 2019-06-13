void keyPressed()
{
  if(key == '1') 
  {
    centering = !centering;
    println("Centering:", centering, "Collisions:", colAvoidance, "Velocity matching:", vMatching, "Wandering:", wandering);
  }
  if(key == '2') 
  {
    vMatching = !vMatching;
    println("Centering:", centering, "Collisions:", colAvoidance, "Velocity matching:", vMatching, "Wandering:", wandering);
  }
  if(key == '3') 
  {
    colAvoidance = !colAvoidance;
    println("Centering:", centering, "Collisions:", colAvoidance, "Velocity matching:", vMatching, "Wandering:", wandering);
  }
  if(key == '4') 
  {
    wandering = !wandering;
    println("Centering:", centering, "Collisions:", colAvoidance, "Velocity matching:", vMatching, "Wandering:", wandering);
  }
  if(key == 'c')
  {
    clear = true;
    animating = false;
  }
  if(key == 'p')
    leavePath = !leavePath;
  if(key == 's')
  {
   randomize();
  }
  if(key == ' ')
  {
    animating = !animating;
  }
  if(key == 'a')
  {
    attract = true;
  }
  if(key == 'r')
  {
    attract = false;
  }
  if(key == '+' || key == '=')
  {
    if(boids.size() <= 100)
    {
      boids.add(new boid(random(600),random(600)));
      boid b = boids.get(boids.size() - 1);
      b.vx = random(-velMax, velMax);
      b.vy = random(-velMax, velMax);
    }
    else
      println("Reached 100 boids!");
  }
  if(key == '-')
  {
   if(boids.size() != 0)
   {
     boids.remove(boids.size() - 1);
   }
   else
     println("No boids to delete!");
  }
}
void mouseDragged()
{
  pressed = true;
  posX = mouseX;
  posY = mouseY;
}
void mouseReleased()
{
  pressed = false;
}
