int cellSize = 4;

int cols, rows;

float [][] u;
float [][] v;

boolean animating = true;
boolean drawU = true;
boolean drawV = false;
boolean diffusion = false;
boolean spatial = false;

float k = 0.0625, f = 0.035, ru = 0.082, rv = 0.041;

void setup()
{
  size(800, 800);
  
  cols = width/cellSize;
  rows = height/cellSize;

  u = new float[cols][rows];
  v = new float[cols][rows];
  
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      u[i][j] = 1.0;
      v[i][j] = 0.0;
    }
  }
  
  int x = int(random(90));
  int y = int(random(90));
  for(int i = x; i < x+10; i++)
  {
    for(int j = y; j < y+10; j++)
    {
      u[i][j] = 0.5 + random(0.05);
      v[i][j] = 0.25 + random(0.05);
    }
  }
}

void draw()
{
  if(animating)
  {
    if(!diffusion)
      reactDiff(1);
    else
      forwardEulerDiff(u, 4*0.082, 1);
      
    if(drawU || diffusion)
      drawGrid(u);
    if(drawV && !diffusion)
      drawGrid(v);
    //animating = false;
  }
}

void drawGrid(float[][] grid)
{
  float maxG = 0, minG = 1;
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      maxG = max(grid[i][j], maxG);
      minG = min(grid[i][j], minG);
    }
  }
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      fill(norm(grid[i][j], minG, maxG)*255);
      noStroke();
      rect(i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
}

void forwardEulerDiff(float[][] grid, float dt, float D)
{
  float[][] newGrid = new float[cols][rows];
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      float top, bottom, left, right;
      if(i+1 >= cols)
        right = grid[0][j];
      else
        right = grid[i+1][j];
      if(i-1 < 0)
        left = grid[cols-1][j];
      else
        left = grid[i-1][j];
      if(j+1 >= rows)
        bottom = grid[i][0];
      else
        bottom = grid[i][j+1];
      if(j-1 <0)
        top = grid[i][rows-1];
      else
        top = grid[i][j-1];
      newGrid[i][j] = grid[i][j] + D*dt*(top+bottom+left+right-4*grid[i][j])/cellSize;
    }
  }
  
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      grid[i][j] = newGrid[i][j];
    }
  }
}

void reactDiff(float dt)
{
  float[][] unew = new float[cols][rows];
  float[][] vnew = new float[cols][rows];
  
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      if(spatial)
      {
        k = lerp(0.03, 0.07, 1.0*i/(cols-1));
        f = lerp(0.08, 0.0, 1.0*j/(rows-1));
      }
      float topU, bottomU, leftU, rightU;
      float topV, bottomV, leftV, rightV;
      
      if(i+1 == cols)
      {
        rightU = u[0][j];
        rightV = v[0][j];
      }
      else
      {
        rightU = u[i+1][j];
        rightV = v[i+1][j];
      }
      if(i-1 < 0)
      {
        leftU = u[cols-1][j];
        leftV = v[cols-1][j];
      }
      else
      {
        leftU = u[i-1][j];
        leftV = v[i-1][j];
      }
      if(j+1 == rows)
      {
        bottomU = u[i][0];
        bottomV = v[i][0];
      }
      else
      {
        bottomU = u[i][j+1];
        bottomV = v[i][j+1];
      }
      if(j-1 < 0)
      {
        topU = u[i][rows-1];
        topV = v[i][rows-1];
      }
      else
      {
        topU = u[i][j-1];
        topV = v[i][j-1];
      }
      float Lu = topU+bottomU+leftU+rightU-4*u[i][j];
      float Lv = topV+bottomV+leftV+rightV-4*v[i][j];
      float uvv = u[i][j]*v[i][j]*v[i][j];
      
      unew[i][j] = u[i][j] + dt*(f*(1-u[i][j]) - uvv + ru*Lu);
      vnew[i][j] = v[i][j] + dt*(-(f+k)*v[i][j] + uvv + rv*Lv);
    }
  }
  
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      u[i][j] = unew[i][j];
      v[i][j] = vnew[i][j];
    }
  }
}

void reset()
{
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      u[i][j] = 1;
      v[i][j] = 0;
    }
  }
  
  int x = int(random(90));
  int y = int(random(90));
  for(int i = x; i < x+10; i++)
  {
    for(int j = y; j < y+10; j++)
    {
      u[i][j] = 0.5 + random(0.05);
      v[i][j] = 0.25 + random(0.05);
    }
  }
}
