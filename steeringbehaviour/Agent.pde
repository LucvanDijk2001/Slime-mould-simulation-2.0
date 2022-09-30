class Agent
{
  World world;
  //agent position
  PVector rand = PVector.random2D();
  PVector position;
  //agent direction
  float direction;
  //agent move speed
  float moveSpeed = 20;
  //agent pheremone deposit amount
  float depositAmount = 0.2;
  //sensorpositions
  PVector sensors[] = new PVector[3];
  //sensorreadings
  float sensorReadings[] = new float[3];
  //sensor distance
  float sensorDistance = 10;
  //sensor angle
  float sensorAngle = 25;
  //sensor size
  //rotation angle
  float rotationAngle = 10;
  //random rotation angle
  //maybe deposit size again?
  //color
  int index;

  Agent(World w, float ms, float sd, float sa, float ra, float da, int ind)
  {
    switch(spawnType)
    {
     case CIRCLEINWARDS:
       position = PVector.add(new PVector(simWidth/2, simHeight/2), PVector.mult(rand, random((simWidth/2)-simWidth/15)));
       direction = degrees(atan2(rand.x, rand.y)) - 180;
     break;
     
     case CIRCLEOUTWARDS:
       position = PVector.add(new PVector(simWidth/2, simHeight/2), PVector.mult(rand, random((simWidth/2)-simWidth/15)));
       direction = degrees(atan2(rand.x, rand.y));
     break;
     
     case RANDOMPOSITION:
       position = new PVector(random(simWidth),random(simHeight));
       direction = random(360);
     break;
    }
    moveSpeed = ms;
    sensorDistance = sd;
    sensorAngle = sa;
    rotationAngle = ra;
    world = w;
    depositAmount = da;
    index = ind;
    for (int i = 0; i < sensors.length; i++)
    {
      sensors[i] = new PVector();
    }
    UpdateSensorPositions();
  }

  void Update()
  {
    GetSensorReadings();

    RotateAgent();

    position.x += sin(radians(direction)) * moveSpeed / frameRate;
    position.y += cos(radians(direction)) * moveSpeed / frameRate;

    UpdateSensorPositions();

    ClampPosition();

    world.texture[round(position.x)][round(position.y)][index] += depositAmount;
  }

  void ClampPosition()
  {
    if (position.x < 0 || position.x > simWidth-1)
    {
      position.x = constrain(position.x, 0, simWidth-1);
      direction = 180 - (direction-180);
    }
    if (position.y < 0 || position.y > simHeight-1)
    {
      position.y = constrain(position.y, 1, simHeight-1);
      direction = 360 - (direction-180);
    }
  }

  void UpdateSensorPositions()
  {
    sensors[0].x = position.x + sin(radians(direction+sensorAngle))*sensorDistance;
    sensors[0].y = position.y + cos(radians(direction+sensorAngle))*sensorDistance;
    sensors[1].x = position.x + sin(radians(direction))*sensorDistance;
    sensors[1].y = position.y + cos(radians(direction))*sensorDistance;
    sensors[2].x = position.x + sin(radians(direction-sensorAngle))*sensorDistance;
    sensors[2].y = position.y + cos(radians(direction-sensorAngle))*sensorDistance;
  }

  void GetSensorReadings()
  {
    for (int i = 0; i < sensors.length; i++)
    {
     sensorReadings[i] = 0; 
    }
    for (int i = 0; i < sensors.length; i++)
    {
      if (sensors[i].x > 0 && sensors[i].x < simWidth-1 && sensors[i].y > 0 && sensors[i].y < simHeight-1)
      {
        for (int j = 0; j < world.populationAmount; j++)
        {
          if (j == index)
          {
            sensorReadings[i] += world.texture[round(sensors[i].x)][round(sensors[i].y)][j];
          }
          else
          {
            sensorReadings[i] -= world.texture[round(sensors[i].x)][round(sensors[i].y)][j];
          }
        }
      }
    }
  }

  void RotateAgent()
  {
    float s0, s1, s2;
    s0 = sensorReadings[0];
    s1 = sensorReadings[1];
    s2 = sensorReadings[2];
    if (s0 == s2)
    {
      direction += random(-rotationAngle, rotationAngle);
    }
    if (s0 > s1 && s0 > s2)
    {
      direction += rotationAngle;
    }
    if (s2 > s0 && s2 > s1)
    {
      direction -= rotationAngle;
    }
  }
}
