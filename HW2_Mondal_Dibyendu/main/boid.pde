class boid
{
  float x=0, y=0;
  float vx, vy;
  float fwx, fwy;  //wandering force
  float ffcx, ffcy;  //flock centering
  float fcax, fcay;  //collision avoidance
  float fvmx, fvmy;  //velocity matching
  float fmx, fmy;    //mouse force
  float mass= 1.0;
  
  boid(float X, float Y) 
  {
    x = X;
    y = Y;
  }
  void drawShape(int r)
  {
    PVector p = new PVector(vx,vy);
    float theta = p.heading() + radians(90);
    fill(200, 100, 200);
    stroke(255);
    pushMatrix();
    translate(x, y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
    //ellipse(x, y, r, r);
  }
}
