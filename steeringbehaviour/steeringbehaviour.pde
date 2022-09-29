World world;
boolean sameAgentProperties = true;
boolean keyDown = false;

void setup()
{
  size(800, 800);
  colorMode(HSB);
  background(0);

  world = new World(sameAgentProperties);
}

void draw()
{
  if (keyPressed)
  {
    if (!keyDown)
    {
      keyDown = true;
      if (key == ' ')
      {
        world = new World(sameAgentProperties);
      }
    }
  } else
  {
    keyDown = false;
  }
  world.Update();
  world.Show();
}
