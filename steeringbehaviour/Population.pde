class Population
{
  World world;
  Agent[] agents;
  
  Population(int size, World w ,float ms, float sd, float sa, float ra, float da,int index)
  {
    world = w;
    agents = new Agent[size];
    for (int i = 0; i < size; i++)
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
