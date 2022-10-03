//main program
World world;
Editor editor;
int simWidth = 500, simHeight = 500;

void setup()
{
  size(1400, 800);
  colorMode(HSB);
  background(0);
  MakeWorld();
  editor = new Editor();
}

void draw()
{
  background(0);
  editor.Update();
  world.Update();
  editor.Show();
  world.Show();
}

void MakeWorld()
{
  world = new World();
}
