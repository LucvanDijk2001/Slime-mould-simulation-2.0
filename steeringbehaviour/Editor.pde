class Editor
{
  boolean mouseDown = false;

  int lineThickness = 3;
  int bmx, bmy, bmw, bmh, rmx,rmy,rmw,rmh, smx, smy, smw, smh;
  color colorWhite = color(0, 0, 255);
  color colorRed = color(255,255,255);

  Button createNewButton;

  Editor()
  {
    rmx = simWidth+lineThickness/2;
    rmy = lineThickness/2;
    rmw = (width-simWidth-lineThickness/2)/2;
    rmh = height-lineThickness/2;
    
    smx = simWidth+(width-simWidth)/2;
    smy = lineThickness/2;
    smw = (width-simWidth-lineThickness/2)/2;
    smh = height-lineThickness/2;
    
    bmx = lineThickness/2;
    bmy = simHeight+lineThickness/2;
    bmw = simWidth;
    bmh = height-simHeight-lineThickness/2;

    createNewButton = new Button(rmx+rmw/2, rmh-100, 100, 50, "Create", 15, colorWhite);
  }

  void Update()
  {
    if (mousePressed)
    {
      if (!mouseDown)
      {
        mouseDown = true;
        if (createNewButton.OnMouse())
        {
          MakeWorld();
        }
      }
    } else
    {
      mouseDown = false;
    }
  }

  void Show()
  {
    strokeWeight(lineThickness);
    noFill();

    //right window
    DrawWindow(rmx, rmy, rmw, rmh, colorWhite);
    DrawText("Global settings", rmx+5, rmy+5, colorWhite, 15);
    DrawWindow(rmx, rmy, rmw, 300, colorWhite);
    DrawText("Current agent settings",rmx+5,300+5,colorWhite,15);
    createNewButton.Show();
    
    //bottom window
    DrawWindow(bmx,bmy,bmw,bmh,colorWhite);
    DrawText("Agent visualization",bmx+5,bmy+5,colorWhite,15);
    
    //side window
    DrawWindow(smx,smy,smw,smh,colorWhite);
    DrawText("Agent creation settings",smx+5,smy+5,colorWhite,15);
  }

  void DrawWindow(int _x, int _y, int _w, int _h, color col)
  {
    stroke(col);
    noFill();
    rect(_x, _y, _w, _h);
  }

  void DrawText(String text, int x, int y, color col, int size)
  {
    textAlign(LEFT, TOP);
    textSize(size);
    fill(col);
    text(text, x, y);
  }
}


//===============================BUTTON=================================================//
class Button
{
  int x, y, w, h;
  String text;
  color col;
  int textSize;

  Button(int _x, int _y, int _w, int _h, String _text, int _textSize, color _col)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    text = _text;
    col = _col;
    textSize = _textSize;
  }

  void Show()
  {
    stroke(col);
    noFill();
    rect(x-w/2, y-h/2, w, h);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x, y);
  }

  boolean OnMouse()
  {
    return mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2;
  }
}
