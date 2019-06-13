boolean animating = true;

boolean pressed = false;
boolean step = false;

float velMin = 5, velMax = 10;
float dt = 0.05;

ArrayList<boid> boids = new ArrayList<boid>();
spring[][] springs;
int[][] muscle;

ArrayList<boid> boids2 = new ArrayList<boid>();
spring[][] springs2;
int[][] muscle2;

void setup()
{
  size(600, 600);

  background(#FFFFFF);

  boids.add(new boid(50, 89, 50, 0.3, 6));
  boids.add(new boid(70, 89, 50, 0.3, 6));
  boids.add(new boid(60, 89-sqrt(300), 50, 0.3, 6));
  boids.add(new boid(50, 99, 50, 0.3, 6));
  boids.add(new boid(70, 99, 50, 0.3, 6));
  boids.add(new boid(60, 89, 50, 0.3, 6));
  boids.add(new boid(60, 99, 50, 0.3, 6));

  springs = new spring[7][7];
  muscle = new int[7][7];
  for (int i = 0; i < 7; i++)
  {
    for (int j = 0; j < 7; j++)
    {
      muscle[i][j] = 0;
    }
  }
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      if (i != j)
        springs[i][j] = new spring(boids.get(i), boids.get(j), 20, 20);
    }
  }

  springs[3][0] = new spring(boids.get(3), boids.get(0), 10, 30);
  muscle[3][0] = 1;

  springs[4][1] = new spring(boids.get(4), boids.get(1), 10, 30);
  muscle[4][1] = 1;

  springs[5][0] = new spring(boids.get(5), boids.get(0), 1.8, 30);
  muscle[5][0] = 1;
  springs[5][1] = new spring(boids.get(5), boids.get(1), 0.1, 30);
  muscle[5][1] = 1;
  //springs[5][3] = new spring(boids.get(5), boids.get(3), sqrt(200), 30);
  //muscle[5][3] = 1;
  //springs[5][4] = new spring(boids.get(5), boids.get(4), sqrt(200), 30);
  //muscle[5][4] = 1;

  springs[6][0] = new spring(boids.get(6), boids.get(0), 10, 30);
  muscle[6][0] = 1;
  springs[6][1] = new spring(boids.get(6), boids.get(1), 10, 30);
  muscle[6][1] = 1;
  springs[6][3] = new spring(boids.get(6), boids.get(3), 10, 30);
  muscle[6][3] = 1;
  springs[6][4] = new spring(boids.get(6), boids.get(4), sqrt(200), 30);
  muscle[6][4] = 1;
  springs[6][5] = new spring(boids.get(6), boids.get(5), sqrt(200), 30);
  muscle[6][5] = 1;

  springs[5][0].setDetails(1, 0, 2);
  springs[5][1].setDetails(1, PI, 2);

  //boids2.add(new boid(50, 50, 50, 0.3, 6));
  //boids2.add(new boid(60, 50, 50, 0.3, 6));
  //boids2.add(new boid(60+5*sqrt(2), 50+5*sqrt(2), 50, 0.3, 6));
  //boids2.add(new boid(60+5*sqrt(2), 60+5*sqrt(2), 50, 0.3, 6));
  //boids2.add(new boid(60, 60+10*sqrt(2), 50, 0.3, 6));
  //boids2.add(new boid(50, 60+10*sqrt(2), 50, 0.3, 6));
  //boids2.add(new boid(50-5*sqrt(2), 60+5*sqrt(2), 50, 0.3, 6));
  //boids2.add(new boid(50-5*sqrt(2), 50+5*sqrt(2), 50, 0.3, 6));

  //boids2.add(new boid(50, 50+15, 50, 0.3, 6));
  //boids2.add(new boid(60, 50+15, 50, 0.3, 6));
  //boids2.add(new boid(60+5*sqrt(2), 50+5*sqrt(2)+15, 50, 0.3, 6));
  //boids2.add(new boid(60+5*sqrt(2), 60+5*sqrt(2)+15, 50, 0.3, 6));
  //boids2.add(new boid(60, 60+10*sqrt(2)+15, 50, 0.3, 6));
  //boids2.add(new boid(50, 60+10*sqrt(2)+15, 50, 0.3, 6));
  //boids2.add(new boid(50-5*sqrt(2), 60+5*sqrt(2)+15, 50, 0.3, 6));
  //boids2.add(new boid(50-5*sqrt(2), 50+5*sqrt(2)+15, 50, 0.3, 6));

  //springs2 = new spring[16][16];
  //muscle2 = new int[16][16];
  //for(int i = 0; i < 16; i++)
  //{
  //  for(int j = 0; j < 16; j++)
  //  {
  //    muscle2[i][j] = 0;
  //  }
  //}
  //for(int i = 0; i < 8; i++)
  //{
  //  springs2[i][(i+1)%8] = new spring(boids2.get(i), boids2.get((i+1)%8), 10, 30);
  //  springs2[(i+1)%8][i] = new spring(boids2.get((i+1)%8), boids2.get(i), 10, 30);
  //  muscle2[i][(i+1)%8] = 2;
  //  muscle2[(i+1)%8][i] = 2;
  //  if(i%2 == 0)
  //  {
  //    springs2[i][(i+5)%8] = new spring(boids2.get(i), boids2.get((i+5)%8), 10+10*sqrt(2), 30);
  //    muscle2[i][(i+5)%8] = 2;
  //  }
  //  else
  //  {
  //    springs2[i][(i+3)%8] = new spring(boids2.get(i), boids2.get((i+3)%8), 10+10*sqrt(2), 30);
  //    muscle2[i][(i+3)%8] = 2;
  //  }
  //}
  
  ////println(muscle2[7][0]);
  //for(int i = 0; i < 8; i++)
  //{
  //  springs2[i][i+8] = new spring(boids2.get(i), boids2.get(i+8), 15, 30);
  //  muscle2[i][i+8] = 1;
  //}

  //for(int i = 0; i < 8; i+=2)
  //{
  //  springs2[i+8][i+1+8] = new spring(boids2.get(i+8), boids2.get(i+1+8), 10, 30);
  //  muscle2[i+8][i+1+8] = 1;
  //}

  //springs2[2][10].setDetails(1, 0, 2);
  //springs2[3][11].setDetails(1, PI, 2);
  //springs2[6][14].setDetails(1, 0, 2);
  //springs2[7][15].setDetails(1, PI, 2);

  float damp = 4;
  boids2.add(new boid(50, 50, 50, damp, 6));
  boids2.add(new boid(50-5*sqrt(3), 45, 50, damp, 6));
  boids2.add(new boid(50-10*sqrt(3), 50, 50, damp, 6));
  boids2.add(new boid(50-5*sqrt(3), 55, 50, damp, 6));
  boids2.add(new boid(50-10*sqrt(3)-5*sqrt(3)/2, 50-5/2, 50, damp, 6));
  boids2.add(new boid(50-10*sqrt(3)-5*sqrt(3)/2, 50+5/2, 50, damp, 6));
  boids2.add(new boid(50-10*sqrt(3)-5*sqrt(3)/2, 50, 50, damp, 6));

  springs2 = new spring[7][7];
  muscle2 = new int[7][7];

  for (int i = 0; i < 7; i++)
  {
    for (int j = 0; j < 7; j++)
    {
      muscle2[i][j] = 0;
    }
  }
  for (int i = 0; i < 4; i++)
  {
    springs2[i][(i+1)%4] = new spring(boids2.get(i), boids2.get((i+1)%4), 10, 20);
    springs2[(i+1)%4][i] = new spring(boids2.get((i+1)%4), boids2.get(i), 10, 20);
    muscle2[i][(i+1)%4] = 2;
    muscle2[(i+1)%4][i] = 2;
  }
  springs2[1][3] = new spring(boids2.get(1), boids2.get(3), 10, 20);
  muscle2[1][3] = 2;
  springs2[3][1] = new spring(boids2.get(3), boids2.get(1), 10, 20);
  muscle2[3][1] = 2;
  
  springs2[0][2] = new spring(boids2.get(0), boids2.get(2), 10*sqrt(3), 20);
  muscle2[0][2] = 2;
  springs2[2][0] = new spring(boids2.get(2), boids2.get(0), 10*sqrt(3), 20);
  muscle2[2][0] = 2;

  springs2[2][4] = new spring(boids2.get(2), boids2.get(4), 5, 30);
  muscle2[2][4] = 1;
  springs2[2][5] = new spring(boids2.get(2), boids2.get(5), 5, 30);
  muscle2[2][5] = 1;
  springs2[2][6] = new spring(boids2.get(2), boids2.get(6), 5*sqrt(3)/2, 30);
  muscle2[2][6] = 1;
  
  springs2[4][6] = new spring(boids2.get(4), boids2.get(6), 5/2, 30);
  muscle2[4][6] = 1;
  springs2[5][6] = new spring(boids2.get(5), boids2.get(6), 5/2, 30);
  muscle2[5][6] = 1;

  //springs2[2][4].setDetails(1, 0, 2);
  //springs2[2][5].setDetails(1, PI, 2);
  springs2[4][6].setDetails(1, 0, 2);
  springs2[5][6].setDetails(1, PI, 2);
}
void draw()
{
  if (animating)
  {
    background(70, 201, 255);
    for(int i = 0; i < boids.size(); i++)
    {
      boid b = boids.get(i); 
      if(i < 3)
      {
        fill(0, 255, 0);
        b.drawShape();
        float fSpringx = 0.0;
        float fSpringy = 0.0;
        float fSpring = 0.0;
        for(int j = 0; j <boids.size(); j++)
        {
          if(j < 3 && i != j)
          {
            boid b1 = boids.get(j);
            //fill(200, 100, 200);
            stroke(0, 255, 0);
            line(6*b.x, 6*b.y, 6*b1.x, 6*b1.y);
            float d = sqrt((b.x-b1.x)*(b.x-b1.x)+(b.y-b1.y)*(b.y-b1.y));
            if(d != 0)
            {
              fSpring = -springs[i][j].k*(d-springs[i][j].rest);
              fSpringx -= fSpring*(b1.x-b.x);
              fSpringy -= fSpring*(b1.y-b.y);
            }
          }
        }
        b.vx += dt*fSpringx/b.mass;
        b.vy += dt*fSpringy/b.mass;
        b.update(); 
      }
      else
      {
        fill(255, 0, 0);
        b.drawShape();
        for(int j = 0; j < boids.size(); j++)
        {
          if(muscle[i][j] == 1)
          {
            boid b1 = boids.get(j);
            stroke(255, 0, 0);
            line(6*b.x, 6*b.y, 6*b1.x, 6*b1.y);
            springs[i][j].updateLength();

            float fSpringx = 0.0;
            float fSpringy = 0.0;
            float fSpring = 0.0;

            float d = sqrt((b.x-b1.x)*(b.x-b1.x)+(b.y-b1.y)*(b.y-b1.y));
            if(d != 0)
            {
              fSpring = -springs[i][j].k*(d-springs[i][j].rest);
              fSpringx -= fSpring*(b1.x-b.x);
              fSpringy -= fSpring*(b1.y-b.y);
            }
            b.vx += dt*fSpringx/b.mass;
            b.vy += dt*fSpringy/b.mass;
            b.update(); 
            b1.vx -= dt*fSpringx/b.mass;
            b1.vy -= dt*fSpringy/b.mass;
            b1.update(); 
          }
        }
      }
    }

    for (int i = 0; i < boids2.size(); i++)
    {
      boid b = boids2.get(i); 
      fill(0, 0, 255);
      b.drawShape();
      float fSpringx = 0.0;
      float fSpringy = 0.0;
      float fSpring = 0.0;
      for (int j = 0; j <boids2.size(); j++)
      {
        if (j < 3 && i != j && muscle2[i][j] == 2)
        {
          boid b1 = boids2.get(j);
          stroke(0, 0, 255);
          line(6*b.x, 6*b.y, 6*b1.x, 6*b1.y);
          float d = sqrt((b.x-b1.x)*(b.x-b1.x)+(b.y-b1.y)*(b.y-b1.y));
          if (d != 0)
          {
            fSpring = -springs2[i][j].k*(d-springs2[i][j].rest);
            fSpringx -= fSpring*(b1.x-b.x);
            fSpringy -= fSpring*(b1.y-b.y);
          }
        }
      }
      b.vx += dt*fSpringx/b.mass;
      b.vy += dt*fSpringy/b.mass;
      b.update(); 

      for (int j = 3; j < boids2.size(); j++)
      {
        if (muscle2[i][j] == 1)
        {
          boid b1 = boids2.get(j);
          stroke(31, 31, 31);
          line(6*b.x, 6*b.y, 6*b1.x, 6*b1.y);
          springs2[i][j].updateLength();

          fSpringx = 0.0;
          fSpringy = 0.0;
          fSpring = 0.0;

          float d = sqrt((b.x-b1.x)*(b.x-b1.x)+(b.y-b1.y)*(b.y-b1.y));
          if (d != 0)
          {
            fSpring = -springs2[i][j].k*(d-springs2[i][j].rest);
            fSpringx -= fSpring*(b1.x-b.x);
            fSpringy -= fSpring*(b1.y-b.y);
          }
          b.vx += dt*fSpringx/b.mass;
          b.vy += dt*fSpringy/b.mass;
          b.update(); 
          b1.vx -= dt*fSpringx/b.mass;
          b1.vy -= dt*fSpringy/b.mass;
          b1.update();
        }
      }
    }

    if (step)
      animating=false;
  }
}
