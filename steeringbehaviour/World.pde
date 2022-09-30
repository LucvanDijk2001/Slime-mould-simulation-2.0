class World
{
  float texture[][][];

  int populationAmount;
  float decaySpeed = random(decaySpeedMinMax.x, decaySpeedMinMax.y);
  float populationColors[];
  Population populations[];

  World()
  {
    populationAmount = totalPopulations;
    texture          = new float[simWidth][simHeight][populationAmount];
    populations      = new Population[populationAmount];
    populationColors = new float[populationAmount];

    float moveSpeed      = random(moveSpeedMinMax.x,      moveSpeedMinMax.y     );
    float sensorDistance = random(sensorDistanceMinMax.x, sensorDistanceMinMax.y);
    float sensorAngle    = random(sensorAngleMinMax.x,    sensorAngleMinMax.y   );
    float rotationAngle  = random(rotationAngleMinMax.x,  rotationAngleMinMax.y );
    float depositAmount  = random(depositAmountMinMax.x,  depositAmountMinMax.y );

    for (int i = 0; i < populations.length; i++)
    {
      populationColors[i] = random(255);
      if (populationProperties == POPULATIONPROPERTIES.RANDOM)
      {
         moveSpeed      = random(moveSpeedMinMax.x,      moveSpeedMinMax.y     );
         sensorDistance = random(sensorDistanceMinMax.x, sensorDistanceMinMax.y);
         sensorAngle    = random(sensorAngleMinMax.x,    sensorAngleMinMax.y   );
         rotationAngle  = random(rotationAngleMinMax.x,  rotationAngleMinMax.y );
         depositAmount  = random(depositAmountMinMax.x,  depositAmountMinMax.y );
      }
      populations[i] = new Population(totalAgents/populationAmount, this, moveSpeed, sensorDistance, sensorAngle, rotationAngle, depositAmount, i);
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

    for (int x = 0; x < simWidth; x++)
    {
      for (int y = 0; y < simHeight; y++)
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
        color c = color(populationColors[winningcol], 255, round(pSum*(populationAmount*0.8)));

        set(x, y, c);
      }
    }
  }

  void DiffuseTexture()
  {
    for (int x = 0; x < simWidth; x++)
    {
      for (int y = 0; y < simHeight; y++)
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
          if (x < simWidth-1) {
            sum += texture[x+1][y][i];
            NBCount++;
          }

          //down
          if (y < simHeight-1) {
            sum += texture[x][y+1][i];
            NBCount++;
          }

          //top left
          if (x > 0 && y > 0) {
            sum += texture[x-1][y-1][i];
            NBCount++;
          }

          //top right
          if ( x < simWidth-1 && y > 0) {
            sum += texture[x+1][y-1][i];
            NBCount++;
          }

          //bottom left
          if (x > 0 && y < simHeight-1) {
            sum += texture[x-1][y+1][i];
            NBCount++;
          }

          //bottom right
          if ( x < simWidth-1 && y < simHeight-1) {
            sum += texture[x+1][y+1][i];
            NBCount++;
          }

          sum /= NBCount;

          texture[x][y][i] = sum;
        }
      }
    }

    for (int x = 0; x < simWidth; x++)
    {
      for (int y = 0; y < simHeight; y++)
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
