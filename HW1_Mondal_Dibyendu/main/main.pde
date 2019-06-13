int cellSize = 6;

int cols, rows;
int[][] cell;

boolean singleStep = false;
boolean continuous = false;

void setup()
{
  size(600, 600);
  
  cols = width/cellSize;
  rows = height/cellSize;
  cell = new int[cols][rows];
}

void draw()
{
  int[][] nextCell = new int[cols][rows];
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      int x = i*cellSize;
      int y = j*cellSize;
      fill(cell[i][j]);
      stroke(255);
      rect(x, y, cellSize, cellSize);
      
      if(singleStep)
      {
        int neighbours = 0;
        for(int xn = -1; xn <= 1; xn++)
          for(int yn = -1; yn <= 1; yn++)
          {
            if(xn == 0 && yn == 0)
              continue;
            int xx = (i+xn+cols)%cols;
            int yy = (j+yn+rows)%rows;
            neighbours += cell[xx][yy];
          }
        if(cell[i][j] == 0 && neighbours == 3*255)  
          nextCell[i][j] = 255;
        else if(cell[i][j] == 255 && (neighbours == 2*255 || neighbours == 3*255))
          nextCell[i][j] = 255;
        else
          nextCell[i][j] = 0;
      }
    }
  }
  if(singleStep)
  {
    for(int i = 0; i < cols; i++)
    {
      for(int j = 0; j < rows; j++)
        cell[i][j] = nextCell[i][j];
    }
    if(!continuous)
      singleStep = false;
  }
}

void reset()
{
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      cell[i][j] = 0;
    }
  }
}

void randomize()
{
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      int x = (int) random(2);
      if(x == 0)
        cell[i][j] = 0;
      else
        cell[i][j] = 255;
    }
  }
}
