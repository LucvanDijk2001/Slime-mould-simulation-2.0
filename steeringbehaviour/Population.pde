class Population
{
  World world;
  Agent[] agents;

  int size;
  float moveSpeed, sensorDistance, sensorAngle, rotationAngle, depositAmount, id;
  float moveSpeedMin, moveSpeedMax, sensorDistanceMin, sensorDistanceMax, sensorAngleMin, sensorAngleMax, rotationAngleMin, rotationAngleMax, depositAmountMin, depositAmountMax;
  float col;

  Population(int s, World w, float ms, float sd, float sa, float ra, float da, int index, float c)
  {
    moveSpeedMin      = moveSpeedMinMax.x;
    moveSpeedMax      = moveSpeedMinMax.y;
    sensorDistanceMin = sensorDistanceMinMax.x;
    sensorDistanceMax = sensorDistanceMinMax.y;
    sensorAngleMin    = sensorAngleMinMax.x;
    sensorAngleMax    = sensorAngleMinMax.y;
    rotationAngleMin  = rotationAngleMinMax.x;
    rotationAngleMax  = rotationAngleMinMax.y;
    depositAmountMin  = depositAmountMinMax.x;
    depositAmountMax  = depositAmountMinMax.y;
    size = s;
    col = c;
    moveSpeed = ms;
    sensorDistance = sd;
    sensorAngle = sa;
    rotationAngle = ra;
    depositAmount = da;
    id = index;
    world = w;
    agents = new Agent[s];
    for (int i = 0; i < s; i++)
    {
      agents[i] = new Agent(world, ms, sd, sa, ra, da, index);
    }
  }

  void Update()
  {
    for (int i = 0; i < agents.length; i++)
    {
      agents[i].Update();
    }
  }

  void ResetAgentPositions()
  {
    for (int i = 0; i < agents.length; i++)
    {
      agents[i].ResetPosition();
    }
  }

  //make update agent property 
  void SetAgentProperty(AGENTPROPERTIES p, float v)
  {
    switch(p)
    {
    case MOVESPEED:
      for (int i = 0; i < agents.length; i++)
      {
        moveSpeed = v;
        agents[i].moveSpeed = v;
      }
      break;

    case SENSORDISTANCE:
      for (int i = 0; i < agents.length; i++)
      {
        sensorDistance = v;
        agents[i].sensorDistance = v;
      }
      break;

    case SENSORANGLE:
      for (int i = 0; i < agents.length; i++)
      {
        sensorAngle = v;
        agents[i].sensorAngle = v;
      }
      break;

    case ROTATIONANGLE:
      for (int i = 0; i < agents.length; i++)
      {
        rotationAngle = v;
        agents[i].rotationAngle = v;
      }
      break;

    case DEPOSITAMOUNT:
      for (int i = 0; i < agents.length; i++)
      {
        depositAmount = v;
        agents[i].depositAmount = v;
      }
      break;
    case COLOR:
      col = v;
      break;
    }
  }

  void Show()
  {
  }
}
