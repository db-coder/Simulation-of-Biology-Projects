boolean centering = false;
boolean vMatching = false;
boolean colAvoidance = false;
boolean wandering = false;
boolean animating = true;
boolean clear = false;
boolean leavePath = false;
boolean attract = false;
boolean pressed = false;
float posX = 0, posY = 0;

float time = 0;
float totalAnimationTime = 10;
float timeStep = 0;

float velMin = 100, velMax = 200;
double epsilon = 0.000001;

ArrayList<boid> boids = new ArrayList<boid>();

void setup()
{
  size(600, 600);
  //frameRate(30);
  timeStep = 0.008;
  
  background(#FFFFFF);
  for(int x = 0; x < 100; x++)
  {
    boids.add(new boid(random(600),random(600)));
    boid b = boids.get(x);
    b.vx = random(velMin, velMax);
    b.vy = random(velMin, velMax);
  }
}
void draw()
{
  if(clear)
  {
    background(#FFFFFF);
    clear = false;
  }
  if(leavePath)
    background(#FFFFFF);
  for(int i = 0; i < boids.size(); i++)
  {
    //if(i == 0 && animating)
    // println();
    boid b = boids.get(i);
    b.drawShape(5);
    if(animating)
    {
      float sum = 0;
      float centerx = 0, centery = 0;
      float velx = 0, vely = 0;
      float colx = 0, coly = 0;
      for(int j = 0; j < boids.size(); j++)
      {
        if(i != j)
        {
          boid b1 = boids.get(j);
          float dist = sqrt((b.x - b1.x)*(b.x - b1.x) + (b.y - b1.y)*(b.y - b1.y));

          if(dist > 0 && dist < 200)
          {
            sum += 1.0/(dist*dist + epsilon);
            centerx += (b1.x - b.x)/(dist*dist + epsilon);
            centery += (b1.y - b.y)/(dist*dist + epsilon);
          }
            velx += (b1.vx - b.vx)/(dist*dist + epsilon);
            vely += (b1.vy - b.vy)/(dist*dist + epsilon);
          //}
          if(dist > 0 && dist < 100)
          {
            colx += (b.x - b1.x)/(dist*dist + epsilon);
            coly += (b.y - b1.y)/(dist*dist + epsilon);
          }
        }
      }
      
      float mouseDist = sqrt((b.x - posX)*(b.x - posX) + (b.y - posY)*(b.y - posY));
      
      if(pressed)
      {
        //if(mouseDist < 50)
        //{
          if(attract)
          {
            b.fmx = (posX - b.x);
            b.fmy = (posY - b.y);
          }
          else
          {
            b.fmx = -1*(posX - b.x);
            b.fmy = -1*(posY - b.y);
          }
        //}
        //else
        //{
        //  b.fmx = 0;
        //  b.fmy = 0;
        //}
      }
      else
        {
          b.fmx = 0;
          b.fmy = 0;
        }
      
      if(wandering)
      {
        b.fwx = random(-10, 10);
        b.fwy = random(-10, 10);
      }
      else
      {
        b.fwx = 0;
        b.fwy = 0;
      }
      if(centering)
      {
        sum += epsilon;
        //println("inside");
        b.ffcx = centerx/sum;
        b.ffcy = centery/sum;
      }
      else
      {
        b.ffcx = 0;
        b.ffcy = 0;
      }
      if(colAvoidance)
      {
        b.fcax = colx;
        b.fcay = coly;
      }
      else
      {
        b.fcax = 0;
        b.fcay = 0;
      }
      if(vMatching)
      {
        b.fvmx = velx;//sum;
        b.fvmy = vely;//sum;
        //print(b.fvmx, " ", b.fvmy, "\n");
      }
      else
      {
        b.fvmx = 0;
        b.fvmy = 0;
      }
      //if(b.fcax != 0)
      //  println(b.fcax);
      b.vx = b.vx + timeStep*(b.fwx + 10*b.ffcx + 100*b.fcax + 1000*b.fvmx + 100*b.fmx)/b.mass;
      b.vy = b.vy + timeStep*(b.fwy + 10*b.ffcy + 100*b.fcay + 1000*b.fvmy + 100*b.fmy)/b.mass;
      
      if(b.vx > velMax)
        b.vx = velMax;
      if(b.vy > velMax)
        b.vy = velMax;
      if(b.vx >= 0 && b.vx < velMin)
        b.vx = velMin;
      if(b.vy >= 0 && b.vy < velMin)
        b.vy = velMin;
        
      if(b.vx < -velMax)
        b.vx = -velMax;
      if(b.vy < -velMax)
        b.vy = -velMax;
      if(b.vx < 0 && b.vx > -velMin)
        b.vx = -velMin;
      if(b.vy < 0 && b.vy > -velMin)
        b.vy = -velMin;
      //print(" "+b.vx+"\n");
      
      if(b.x + timeStep*b.vx > 600 || b.x + timeStep*b.vx < 0)
        b.vx = -b.vx;
      if(b.y + timeStep*b.vy > 600 || b.y + timeStep*b.vy < 0)
        b.vy = -b.vy;
      b.x = b.x + timeStep*b.vx;
      b.y = b.y + timeStep*b.vy;
    }
  }
  time += timeStep;
}
void randomize()
{
  for(int i = 0; i < boids.size(); i++)
  {
    boid b = boids.get(i);
    b.x = random(600);
    b.y = random(600);
    b.vx = random(velMin, velMax);
    b.vy = random(velMin, velMax);
  }
}
