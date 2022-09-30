class Population
{
  World world;
  Agent[] agents;
  
  int size;
  float moveSpeed, sensorDistance, sensorAngle, rotationAngle, depositAmount, id;
  
  Population(int s, World w ,float ms, float sd, float sa, float ra, float da,int index)
  {
    size = s;
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
      agents[i] = new Agent(world,ms,sd,sa,ra,da,index);
    }
  }

  void Update()
  {
    for (int i = 0; i < agents.length; i++)
    {
      agents[i].Update();
    }
  }

  void Show()
  {
  }
}
