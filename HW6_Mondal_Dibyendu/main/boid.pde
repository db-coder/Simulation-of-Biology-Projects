class boid
{
  float x=0, y=0;
  float vx=0, vy=0;
  float mass = 1.0;
  float force = 0.0;
  float acceleration = 0.0;
  float damp = 0.3;
  float r = 0.0;
  float g = 2;
  
  boid(float X, float Y, float m, float d, float size) 
  {
    x = X;
    y = Y;
    mass = m;
    damp = d;
    r = size;
  }
  void drawShape()
  {
    stroke(255);
    ellipse(6*x, 6*y, r, r);
  }
  void update()
  {
    if((x+dt*vx) > 99 || (x+dt*vx) < 0)
    {
      vx = -0.8*vx;
    }
    
    x += dt*vx;
    
    if((y+dt*vy) > 99 || (y+dt*vy) < 0)
    {
      vy = -0.8*vy;
    }
    
    y += dt*vy;
    
    force = -damp*vy;
    acceleration = force/mass;
    vy += (acceleration)*dt;
    
    force = -damp*vx;
    acceleration = force/mass;
    vx += acceleration*dt;
  }
}
