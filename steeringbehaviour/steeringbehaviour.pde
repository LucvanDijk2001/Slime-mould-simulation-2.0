//main program
World world;
Editor editor;
int simWidth = 600, simHeight = 600;

void setup()
{
  size(1400, 800);
  colorMode(HSB);
  background(0);
  editor = new Editor();
  MakeWorld();
}

void draw()
{
  world.Update();
  world.Show();
  editor.Update();
  editor.Show();
}

void MakeWorld()
{
  world = new World();
}
