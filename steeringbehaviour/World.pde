class World
{
  float texture[][][];

  int populationAmount = 3;
  int totalAgents = 60000;
  float decaySpeed = random(0.1, 0.9);
  float populationColors[];
  Population populations[];

  World(boolean sameProperties)
  {
    texture = new float[width][height][populationAmount];
    populations = new Population[populationAmount];
    populationColors = new float[populationAmount];

    if (!sameProperties)
    {
      for (int i = 0; i < populations.length; i++)
      {
        populationColors[i] = random(255);
        populations[i] = new Population(totalAgents/populationAmount, this, random(5, 100), random(1, 30), random(5, 120), random(5, 60), random(0.05, 0.8), i);
      }
    } else
    {
      texture = new float[width][height][populationAmount];
      populations = new Population[populationAmount];
      populationColors = new float[populationAmount];
      float moveSpeed = random(5, 100);
      float sensorDistance = random(1, 30);
      float sensorAngle = random(5, 120);
      float rotationAngle = random(5, 60);
      float depositAmount = random(0.05, 0.8);
      for (int i = 0; i < populations.length; i++)
      {
        populationColors[i] = random(255);
        populations[i] = new Population(totalAgents/populationAmount, this, moveSpeed, sensorDistance, sensorAngle, rotationAngle, depositAmount, i);
      }
    }
  }


  void Update()
  {
    for (int i = 0; i < populations.length; i++)
    {
      populations[i].Update();
    }
  }

  void Show()
  {

    DiffuseTexture();

    for (int x = 0; x < width; x++)
    {
      for (int y = 0; y < height; y++)
      {
        float pSum = 0;
        int winningcol = 0;
        float highestVal = 0;
        for (int i = 0; i < populationAmount; i++)
        {
          pSum +=  texture[x][y][i]*255;
          if (texture[x][y][i] > highestVal)
          {
            winningcol = i;
          }
        }

        pSum /= populationAmount;
        color c = color(populationColors[winningcol], 255, round(pSum));
        set(x, y, c);
      }
    }
  }

  void DiffuseTexture()
  {
    for (int x = 0; x < width; x++)
    {
      for (int y = 0; y < height; y++)
      {
        for (int i = 0; i < populationAmount; i++)
        {
          float sum = 0;
          int NBCount = 1; //1 because it includes self;
          sum += texture[x][y][i];

          //left
          if (x > 0) {
            sum += texture[x-1][y][i];
            NBCount++;
          }

          //up
          if (y > 0) {
            sum += texture[x][y-1][i];
            NBCount++;
          }

          //right
          if (x < width-1) {
            sum += texture[x+1][y][i];
            NBCount++;
          }

          //down
          if (y < height-1) {
            sum += texture[x][y+1][i];
            NBCount++;
          }

          //top left
          if (x > 0 && y > 0) {
            sum += texture[x-1][y-1][i];
            NBCount++;
          }

          //top right
          if ( x < width-1 && y > 0) {
            sum += texture[x+1][y-1][i];
            NBCount++;
          }

          //bottom left
          if (x > 0 && y < height-1) {
            sum += texture[x-1][y+1][i];
            NBCount++;
          }

          //bottom right
          if ( x < width-1 && y < height-1) {
            sum += texture[x+1][y+1][i];
            NBCount++;
          }

          sum /= NBCount;

          texture[x][y][i] = sum;
        }
      }
    }

    for (int x = 0; x < width; x++)
    {
      for (int y = 0; y < height; y++)
      {
        for (int i = 0; i < populationAmount; i++)
        {
          texture[x][y][i] -= decaySpeed / frameRate;
          texture[x][y][i] = constrain(texture[x][y][i], 0, 1);
        }
      }
    }
  }
}
