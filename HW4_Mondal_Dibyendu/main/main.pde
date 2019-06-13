int cellSize = 2;

int cols, rows;

float [][] cell;
float [][] cellDBM;

boolean animating = true;
float stick = 1.0;
float eta;
boolean dla = true;
boolean flag = false;
int posX, posY;
float r0 = 1.0;

ArrayList<cell> growingPattern = new ArrayList<cell>();
ArrayList<cell> candidateCells = new ArrayList<cell>();

void setup()
{
  size(400, 400);
  
  cols = width/cellSize;
  rows = height/cellSize;

  cell = new float[cols][rows];
  cellDBM = new float[cols][rows];
  
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      cell[i][j] = 0.0;
      cellDBM[i][j] = 0;
    }
  }
  
  cell[cols/2][rows/2] = 1.0;
  cellDBM[cols/2][rows/2] = 1;
  
  growingPattern.add(new cell(cols/2,rows/2));
  for(int k = -1; k <= 1; k++)
  {
    for(int l = -1; l <= 1; l++)
    {
      if(k == 0 && l == 0)
          continue;
      cellDBM[cols/2+k][rows/2+l] = 2;
      candidateCells.add(new cell(cols/2+k,rows/2+l));
    }
  }
  
  for(int i = 0; i < candidateCells.size(); i++)
  {
    findPotential(candidateCells.get(i));
  }
  
  posX = int(random(cols));
  posY = int(random(rows));
}

void draw()
{
  if(animating)
  {
    if(dla)
    {
      for(int i = 0; i < 10000; i++)
        randomWalk();
      drawGrid(cell);
    }
    else
    {
      float minPhi = candidateCells.size() - 1, maxPhi = 0;
      for(int i = 0; i < candidateCells.size(); i++)
      {
        float phi = candidateCells.get(i).phi;
        if(phi <= minPhi)
          minPhi = phi;
        else if(phi >= maxPhi)
          maxPhi = phi;
      }
      
      float phi_i_eta_sum = 0;
      for(int i = 0; i < candidateCells.size(); i++)
      {
        float Phi_i = (candidateCells.get(i).phi - minPhi)/(maxPhi - minPhi);
        candidateCells.get(i).phi_i_eta = pow(Phi_i, eta);
        phi_i_eta_sum += candidateCells.get(i).phi_i_eta;
      }
      
      for(int i = 0; i < candidateCells.size(); i++)
      {
        candidateCells.get(i).p_i = candidateCells.get(i).phi_i_eta/phi_i_eta_sum;
      }
      
      float partial_sum = 0;
      for(int i = 0; i < candidateCells.size(); i++)
      {
        partial_sum += candidateCells.get(i).p_i;
        candidateCells.get(i).partial_sum_i = partial_sum;
      }
      
      float R = random(0, partial_sum);
      for(int i = 0; i < candidateCells.size(); i++)
      {
        if(R < candidateCells.get(i).partial_sum_i)
        {
          growingPattern.add(candidateCells.get(i));
          cellDBM[candidateCells.get(i).i][candidateCells.get(i).j] = 1;
          candidateCells.remove(i);
          break;
        }
      }
      for(int i = 0; i < candidateCells.size(); i++)
      {
        updatePotential(candidateCells.get(i));
      }
      
      for(int k = -1; k <= 1; k++)
      {
        for(int l = -1; l <= 1; l++)
        {
          if(k == 0 && l == 0)
              continue;
          int newPosX = (growingPattern.get(growingPattern.size()-1).i+k+cols)%cols;
          int newPosY = (growingPattern.get(growingPattern.size()-1).j+l+rows)%rows;
          if(cellDBM[newPosX][newPosY] == 0)
          {
            cellDBM[newPosX][newPosY] = 2;
            cell c = new cell(newPosX,newPosY);
            findPotential(c);
            candidateCells.add(c);
          }
        }
      }
      drawGrid(cellDBM);
    }
  }
}

void drawGrid(float[][] grid)
{
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      if(grid[i][j] != 2)
        fill(grid[i][j]*255);
      else
        fill(0);
      noStroke();
      rect(i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
}

void randomWalk()
{
  int i = floor(random(-1,2));
  int j = floor(random(-1,2));
  
  while(i == 0 && j == 0)
  {
    i = floor(random(-1,2));
    j = floor(random(-1,2));
  }
  
  posX = posX + i;
  posY = posY + j;
  
  if(posX == cols)
    posX = 0;
  if(posX < 0)
    posX = cols - 1;
  if(posY == rows)
    posY = 0;
  if(posY <0)
    posY = rows-1;

  for(int k = -1; k <= 1; k++)
  {
    for(int l = -1; l <= 1; l++)
    {
      if(k == 0 && l == 0)
          continue;
      int newPosX = (posX+k+cols)%cols;
      int newPosY = (posY+l+rows)%rows;
      if(cell[newPosX][newPosY] == 1.0)
      {
        float rng = random(1);
        if(rng <= stick)
        {
          cell[posX][posY] = 1.0;
          reset();
          flag = true;
          break;
        }
      }
    }
    if(flag)
    {
      reset();
      flag = false;
      break;
    }
  }
}

void reset()
{
  posX = int(random(cols));
  posY = int(random(rows));
}

void findPotential(cell c)
{
  for(int i = 0; i < growingPattern.size(); i++)
  {
    float dist = sqrt((growingPattern.get(i).i - c.i)*(growingPattern.get(i).i - c.i) + (growingPattern.get(i).j - c.j)*(growingPattern.get(i).j - c.j));
    c.phi += (1 - r0/dist);
  }
}

void updatePotential(cell c)
{
  int i = growingPattern.size() - 1;
  float dist =  sqrt((growingPattern.get(i).i - c.i)*(growingPattern.get(i).i - c.i) + (growingPattern.get(i).j - c.j)*(growingPattern.get(i).j - c.j));
  c.phi += (1 - r0/dist);
}

void initialize()
{
  while(growingPattern.size() > 0)
  {
    growingPattern.remove(0);
  }
  while(candidateCells.size() > 0)
  {
   candidateCells.remove(0);
  }
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      cell[i][j] = 0.0;
      cellDBM[i][j] = 0;
    }
  }
  
  cell[cols/2][rows/2] = 1.0;
  cellDBM[cols/2][rows/2] = 1;
  
  growingPattern.add(new cell(cols/2,rows/2));
  for(int k = -1; k <= 1; k++)
  {
    for(int l = -1; l <= 1; l++)
    {
      if(k == 0 && l == 0)
          continue;
      cellDBM[cols/2+k][rows/2+l] = 2;
      candidateCells.add(new cell(cols/2+k,rows/2+l));
    }
  }
  
  for(int i = 0; i < candidateCells.size(); i++)
  {
    findPotential(candidateCells.get(i));
  }
  
  posX = int(random(cols));
  posY = int(random(rows));
}
