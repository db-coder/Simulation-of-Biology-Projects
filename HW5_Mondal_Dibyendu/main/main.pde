import java.util.Collections;

int cellSize = 5;
int gridSize = 850;
int FISH_BREED = 6;
int SHARK_BREED = 12;
int SHARK_STARVE = 8;

int cols, rows;

int [][] cell;

boolean animating = true;
boolean step = false;

ArrayList<organism> fishes = new ArrayList<organism>();
ArrayList<organism> sharks = new ArrayList<organism>();
ArrayList<organism> sizes = new ArrayList<organism>();

void setup()
{
  size(1350, 850);

  cols = gridSize/cellSize;
  rows = gridSize/cellSize;

  cell = new int[cols][rows];

  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      cell[i][j] = 0;
    }
  }
  
  for (int i = 0; i < cols*rows*0.25; i++)
  {
    int x = int(random(cols));
    int y = int(random(rows));
    if(cell[x][y] == 0)
    {
      cell[x][y] = 1;
      fishes.add(new organism(x, y, 0));
    }
    else
      i--;
  }
  for (int i = 0; i < cols*rows*0.02; i++)
  {
    int x = int(random(cols));
    int y = int(random(rows));
    if(cell[x][y] == 0)
    {
      cell[x][y] = 2;
      sharks.add(new organism(x, y, 0));
    }
    else
      i--;
  }
}

void draw()
{
  background(0);
  if (animating)
  {
    Collections.shuffle(fishes);
    Collections.shuffle(sharks);
    
    if(sharks.size() == 0)
    {
      for (int i = 0; i < cols*rows*0.02; i++)
      {
        int x = int(random(cols));
        int y = int(random(rows));
        if(cell[x][y] == 0)
        {
          cell[x][y] = 2;
          sharks.add(new organism(x, y, 0));
        }
        else
          i--;
      }
    }
    
    int size = fishes.size();
    for(int i = 0; i < size; i++)
    {
      organism fish = fishes.get(i);
      fish.age++;
      ArrayList<organism> fish_neighbour = new ArrayList<organism>();
      if(cell[(fish.x+1)%cols][fish.y] == 0)
        fish_neighbour.add(new organism((fish.x+1)%cols, fish.y, 0));
      if(cell[(fish.x-1+cols)%cols][fish.y] == 0)
        fish_neighbour.add(new organism((fish.x-1+cols)%cols, fish.y, 0));
      if(cell[fish.x][(fish.y+1)%rows] == 0)
        fish_neighbour.add(new organism(fish.x, (fish.y+1)%rows, 0));
      if(cell[fish.x][(fish.y-1+rows)%rows] == 0)
        fish_neighbour.add(new organism(fish.x, (fish.y-1+rows)%rows, 0));
        
      //if(cell[(fish.x+1)%cols][(fish.y+1)%rows] == 0)
      //  fish_neighbour.add(new organism((fish.x+1)%cols, (fish.y+1)%rows, 0));
      //if(cell[(fish.x-1+cols)%cols][(fish.y-1+rows)%rows] == 0)
      //  fish_neighbour.add(new organism((fish.x-1+cols)%cols, (fish.y-1+rows)%rows, 0));
      //if(cell[(fish.x-1+cols)%cols][(fish.y+1)%rows] == 0)
      //  fish_neighbour.add(new organism((fish.x-1+cols)%cols, (fish.y+1)%rows, 0));
      //if(cell[(fish.x+1)%cols][(fish.y-1+rows)%rows] == 0)
      //  fish_neighbour.add(new organism((fish.x+1)%cols, (fish.y-1+rows)%rows, 0));
      
      if(fish_neighbour.size() != 0)
      {
        int index = int(random(fish_neighbour.size()));
        organism new_fish = fish_neighbour.get(index);
        
        if(fish.age >= FISH_BREED)
        {
          fishes.add(new organism(fish.x, fish.y, 0));
          fish.x = new_fish.x;
          fish.y = new_fish.y;
          fish.age = 0;
          cell[fish.x][fish.y] = 1;
        }
        else
        {
          cell[new_fish.x][new_fish.y] = 1;
          cell[fish.x][fish.y] = 0;
          fish.x = new_fish.x;
          fish.y = new_fish.y;
        }
      }
    }
    size = sharks.size();
    for(int i = 0; i < size; i++)
    {
      organism shark = sharks.get(i);
      shark.age++;
      
      ArrayList<organism> shark_fish_neighbour = new ArrayList<organism>();
      if(cell[(shark.x+1)%cols][shark.y] == 1)
        shark_fish_neighbour.add(new organism((shark.x+1)%cols, shark.y, 0));
      if(cell[(shark.x-1+cols)%cols][shark.y] == 1)
        shark_fish_neighbour.add(new organism((shark.x-1+cols)%cols, shark.y, 0));
      if(cell[shark.x][(shark.y+1)%rows] == 1)
        shark_fish_neighbour.add(new organism(shark.x, (shark.y+1)%rows, 0));
      if(cell[shark.x][(shark.y-1+rows)%rows] == 1)
        shark_fish_neighbour.add(new organism(shark.x, (shark.y-1+rows)%rows, 0));
      
      if(shark_fish_neighbour.size() != 0)
      {
        int index = int(random(shark_fish_neighbour.size()));
        organism new_shark = shark_fish_neighbour.get(index);
        
        if(shark.age >= SHARK_BREED)
        {
          sharks.add(new organism(shark.x, shark.y, 0));
          shark.x = new_shark.x;
          shark.y = new_shark.y;
          shark.age = 0;
          shark.hunger = 0;
          cell[shark.x][shark.y] = 2;
        }
        else
        {
          cell[shark.x][shark.y] = 0;
          shark.x = new_shark.x;
          shark.y = new_shark.y;
          shark.hunger = 0;
          cell[shark.x][shark.y] = 2;
        }
        
        for(int j = 0; j < fishes.size(); j++)
        {
          organism fish = fishes.get(j);
          if(fish.x == shark.x && fish.y == shark.y)
          {
            fishes.remove(j);
            break;
          }
        }
      }
      else
      {
        ArrayList<organism> shark_neighbour = new ArrayList<organism>();
        if(cell[(shark.x+1)%cols][shark.y] == 0)
          shark_neighbour.add(new organism((shark.x+1)%cols, shark.y, 0));
        if(cell[(shark.x-1+cols)%cols][shark.y] == 0)
          shark_neighbour.add(new organism((shark.x-1+cols)%cols, shark.y, 0));
        if(cell[shark.x][(shark.y+1)%rows] == 0)
          shark_neighbour.add(new organism(shark.x, (shark.y+1)%rows, 0));
        if(cell[shark.x][(shark.y-1+rows)%rows] == 0)
          shark_neighbour.add(new organism(shark.x, (shark.y-1+rows)%rows, 0));
        
        if(shark_neighbour.size() != 0)
        {
          int index = int(random(shark_neighbour.size()));
          organism new_shark = shark_neighbour.get(index);
          if(shark.age >= SHARK_BREED)
          {
            sharks.add(new organism(shark.x, shark.y, 0));
            shark.x = new_shark.x;
            shark.y = new_shark.y;
            shark.age = 0;
            shark.hunger = 0;
            cell[shark.x][shark.y] = 2;
          }
          else
          {
            cell[shark.x][shark.y] = 0;
            shark.x = new_shark.x;
            shark.y = new_shark.y;
            shark.hunger++;
            cell[shark.x][shark.y] = 2;
          }
        }
      }
      if(shark.hunger >= SHARK_STARVE)
      {
        //println(shark.hunger, " age: ", shark.age);
        cell[shark.x][shark.y] = 0;
        sharks.remove(i);
        size--;
        i--;
      }
    }
    drawGrid(cell);
    drawPhase();
    if(step)
      animating = false;
  }  
}

void drawGrid(int[][] grid)
{
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      if(grid[i][j] == 2)
      {
        fill(255, 0, 0);
      }
      else if(grid[i][j] == 1)
      {
        fill(0, 255, 0);
      }
      else
          fill(0);
      //stroke(255);
      //noStroke();
      rect(i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
}

void drawPhase()
{
  if(sizes.size() == 200)
  {
    sizes.remove(0);
  }
  sizes.add(new organism(fishes.size(), sharks.size(), 0));
  
  for(int i = 0; i < sizes.size(); i++)
  {
    fill(255);
    //ellipse(map(sizes.get(i).x, 0, cols*rows, 860, 1300),850-map(sizes.get(i).y, 0, cols*rows, 0, 850), 5, 5);
    ellipse(860.0+(sizes.get(i).x)*440.0/(cols*rows), 850.0-(sizes.get(i).y)*850.0*10/(cols*rows), 5, 5);
  }
}

void reset()
{
  fishes.clear();
  sharks.clear();
  cols = gridSize/cellSize;
  rows = gridSize/cellSize;

  cell = new int[cols][rows];

  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      cell[i][j] = 0;
    }
  }
  
  for (int i = 0; i < cols*rows*0.25; i++)
  {
    int x = int(random(cols));
    int y = int(random(rows));
    if(cell[x][y] == 0)
    {
      cell[x][y] = 1;
      fishes.add(new organism(x, y, 0));
    }
    else
      i--;
  }
  for (int i = 0; i < cols*rows*0.02; i++)
  {
    int x = int(random(cols));
    int y = int(random(rows));
    if(cell[x][y] == 0)
    {
      cell[x][y] = 2;
      sharks.add(new organism(x, y, 0));
    }
    else
      i--;
  }
}
