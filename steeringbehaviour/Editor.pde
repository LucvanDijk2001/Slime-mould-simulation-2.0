class Editor
{   
  boolean mouseDown = false;

  int lineThickness = 3;
  int currentPopulationAmount;

  boolean loadSimLoader = false;
  JSONArray savedJSON;

  //main window positions
  int bmx, bmy, bmw, bmh, rmx, rmy, rmw, rmh, smx, smy, smw, smh, rbo, sbo;
  int selectedAgent = 0;

  //colors
  color colorWhite = color(0, 0, 255);
  color colorRed = color(255, 255, 255);
  color colorPink = color(230, 255, 255);
  color colorYellow = color(40, 150, 255);

  //global settings
  Selector spawnTypeSelector;
  Selector populationPropertiesSelector;
  Selector populationColorModeSelector;
  Button resetGlobalSettingsButton;
  Slider populationAmountSlider;
  Slider totalAgentsSlider;
  MinMaxSlider decayValueMMSlider;

  //agent properties
  Selector agentSelector;
  Slider agentMoveSpeedSlider;
  Slider agentSensorDistanceSlider;
  Slider agentSensorAngleSlider;
  Slider agentRotationAngleSlider;
  Slider agentDepositAmountSlider;
  Slider agentColorSlider;
  Button agentRandomizeButton;
  Button agentRestartPositionsButton;
  Button saveAgentPropertiesButton;
  Button loadAgentPropertiesButton;
  Button saveAllButton;
  Button loadAllButton;

  //creation properties
  Button createNewButton;
  MinMaxSlider moveSpeedMMSlider;
  MinMaxSlider sensorDistanceMMSlider;
  MinMaxSlider sensorAngleMMSlider;
  MinMaxSlider rotationAngleMMSlider;
  MinMaxSlider depositAmountMMSlider;
  Button saveCreationPropertiesButton;
  Button loadCreationPropertiesButton;
  Button defaultPropertiesButton;

  //agent visualizer
  Selector agentVisualizerScale;


  Editor()
  {
    //main windows
    //global settings
    rmx = simWidth+lineThickness/2;
    rmy = lineThickness/2;
    rmw = (width-simWidth-lineThickness/2)/2;
    rmh = height-lineThickness/2;

    //agent details
    rbo = 250;

    //agent creation
    smx = simWidth+(width-simWidth)/2;
    smy = lineThickness/2;
    smw = (width-simWidth-lineThickness/2)/2;
    smh = height-lineThickness/2;

    //agent visualization
    bmx = lineThickness/2;
    bmy = simHeight+lineThickness/2;
    bmw = simWidth;
    bmh = height-simHeight-lineThickness/2;
    
    //help
    sbo = 450;


    //global settings
    resetGlobalSettingsButton = new Button(rmx+rmw/2, rbo-30, 200, 40, "Reset to defaults", 15, colorWhite, colorPink);
    spawnTypeSelector = new Selector(rmx+15, rmy+50, "SpawnType", new String[]{"Circle Inwards", "Circle Outwards", "Random Position"}, 15, colorYellow);
    populationPropertiesSelector = new Selector(rmx+15, rmy+75, "Population Properties", new String[]{"Random", "Sync"}, 15, colorYellow);
    populationColorModeSelector = new Selector(rmx+15, rmy+100, "Population Color Mode", new String[]{"Random", "Increment"}, 15, colorYellow);
    populationAmountSlider = new Slider(rmx+15, rmy+125, 100, 1, 10, "Total populations", 15, colorYellow, true);
    populationAmountSlider.SetValue(3);
    totalAgentsSlider = new Slider(rmx+15, rmy+150, 200, 1000, 100000, "Total agents", 15, colorYellow, true);
    totalAgentsSlider.SetValue(60000);
    decayValueMMSlider = new MinMaxSlider(rmx+15, rmy+175, 100, 0, 1, "Decay speed", 15, colorYellow);
    decayValueMMSlider.SetMin(0.1);
    decayValueMMSlider.SetMax(0.9);

    //agent properties
    agentSelector = new Selector(rmx+15, 50+rbo, "Agent", populationNames, 15, colorYellow);
    SetAgentPropertySliders();
    agentRandomizeButton = new Button(rmx+rmw/2-rmw/3, rbo+275, 100, 50, "Randomize", 15, colorWhite, colorPink);
    agentRestartPositionsButton = new Button(rmx+rmw/2+rmw/10, rbo+275, 175, 50, "Reset agent positions", 15, colorWhite, colorPink);
    saveAgentPropertiesButton = new Button(rmx+rmw/2+rmw/4, rbo+360, 175, 40, "save agent properties", 15, colorWhite, colorPink);
    loadAgentPropertiesButton = new Button(rmx+rmw/2+rmw/4, rbo+410, 175, 40, "load agent properties", 15, colorWhite, colorPink);
    saveAllButton = new Button(rmx+rmw/2+rmw/4, rbo+460, 175, 40, "save simulation", 15, colorWhite, colorPink);
    loadAllButton = new Button(rmx+rmw/2+rmw/4, rbo+510, 175, 40, "load simulation", 15, colorWhite, colorPink);

    //agent creation
    createNewButton = new Button(smx+smw/2, smy+400, smw-30, 75, "Create", 15, colorWhite, colorPink);
    moveSpeedMMSlider = new MinMaxSlider(smx+15, smy+50, 180, -200, 200, "Move speed", 15, colorYellow);
    moveSpeedMMSlider.SetMinForce(5);
    moveSpeedMMSlider.SetMaxForce(50);
    sensorDistanceMMSlider = new MinMaxSlider(smx+15, smy+75, 180, -50, 50, "Sensor distance", 15, colorYellow);
    sensorDistanceMMSlider.SetMinForce(1);
    sensorDistanceMMSlider.SetMaxForce(30);
    sensorAngleMMSlider = new MinMaxSlider(smx+15, smy+100, 180, 0, 270, "Sensor angle", 15, colorYellow);
    sensorAngleMMSlider.SetMinForce(5);
    sensorAngleMMSlider.SetMaxForce(120);
    rotationAngleMMSlider = new MinMaxSlider(smx+15, smy+125, 180, -90, 90, "Rotation angle", 15, colorYellow);
    rotationAngleMMSlider.SetMinForce(5);
    rotationAngleMMSlider.SetMaxForce(90);
    depositAmountMMSlider = new MinMaxSlider(smx+15, smy+150, 180, 0.1, 1, "Deposit amount", 15, colorYellow);
    depositAmountMMSlider.SetMinForce(0.2);
    depositAmountMMSlider.SetMaxForce(0.8);
    saveCreationPropertiesButton = new Button(smx + smw/2, smy+260, smw-30, 50, "save properties", 15, colorWhite, colorPink);
    loadCreationPropertiesButton = new Button(smx + smw/2, smy+320, smw-30, 50, "load properties", 15, colorWhite, colorPink);
    defaultPropertiesButton      = new Button(smx + smw/2, smy+200, smw-30, 50, "set default", 15, colorWhite, colorPink);

    //agent visualization
    agentVisualizerScale = new Selector(bmx+15, bmy+50, "Scale", new String[]{"0.1", "0.3", "0.5", "1", "2", "3", "5"}, 15, colorYellow);
    agentVisualizerScale.SetSelection(5);
  }

  void SetAgentPropertySliders()
  {
    Population cp = populations[selectedAgent];
    agentMoveSpeedSlider = new Slider(rmx+15, rbo+100, 150, cp.moveSpeedMin, cp.moveSpeedMax, "Move Speed", 15, colorYellow);
    agentMoveSpeedSlider.SetValue(cp.moveSpeed);
    agentSensorDistanceSlider = new Slider(rmx+15, rbo+125, 150, cp.sensorDistanceMin, cp.sensorDistanceMax, "Sensor distance", 15, colorYellow);
    agentSensorDistanceSlider.SetValue(cp.sensorDistance);
    agentSensorAngleSlider = new Slider(rmx+15, rbo+150, 150, cp.sensorAngleMin, cp.sensorAngleMax, "Sensor angle", 15, colorYellow);
    agentSensorAngleSlider.SetValue(cp.sensorAngle);
    agentRotationAngleSlider = new Slider(rmx+15, rbo+175, 150, cp.rotationAngleMin, cp.rotationAngleMax, "Rotation angle", 15, colorYellow);
    agentRotationAngleSlider.SetValue(cp.rotationAngle);
    agentDepositAmountSlider = new Slider(rmx+15, rbo+200, 150, cp.depositAmountMin, cp.depositAmountMax, "Deposit amount", 15, colorYellow);
    agentDepositAmountSlider.SetValue(cp.depositAmount);
    agentColorSlider = new Slider(rmx+15, rbo+225, 255, 0, 255, "color", 15, colorYellow, true);
    agentColorSlider.SetValue(populationColors[selectedAgent]);
  }

  void AgentSave()
  {
    selectOutput("save as", "saveAgentProperties");
  }

  void AgentLoad()
  {
    selectInput("load", "loadAgentProperties");
  }

  void SaveSim()
  {
    selectOutput("save as", "SaveSimulation");
  }

  void LoadSim()
  {
    selectInput("load", "LoadSimulation");
  }

  void PropertiesLoad()
  {
    selectInput("load", "LoadProperties");
  }

  void PropertiesSave()
  {
    selectOutput("save as", "SaveProperties");
  }

  void Update()
  {
    if (editorUpdateCall)
    {
      UpdateCall();
    }
    if (mousePressed)
    {
      if (!mouseDown)
      {
        mouseDown = true;
        if (createNewButton.OnMouse())
        {
          moveSpeedMinMax.x = moveSpeedMMSlider.GetMin();
          moveSpeedMinMax.y = moveSpeedMMSlider.GetMax();
          sensorDistanceMinMax.x = sensorDistanceMMSlider.GetMin();
          sensorDistanceMinMax.y = sensorDistanceMMSlider.GetMax();
          sensorAngleMinMax.x = sensorAngleMMSlider.GetMin();
          sensorAngleMinMax.y = sensorAngleMMSlider.GetMax();
          rotationAngleMinMax.x = rotationAngleMMSlider.GetMin();
          rotationAngleMinMax.y = rotationAngleMMSlider.GetMax();
          depositAmountMinMax.x = depositAmountMMSlider.GetMin();
          depositAmountMinMax.y = depositAmountMMSlider.GetMax();

          MakeWorld();
          UpdateCall();
        }
        if (resetGlobalSettingsButton.OnMouse())
        {
          spawnTypeSelector.SetSelection(0);
          populationPropertiesSelector.SetSelection(0);
          populationColorModeSelector.SetSelection(0);
          populationAmountSlider.SetValue(3);
          totalAgentsSlider.SetValue(60000);
          decayValueMMSlider.SetMin(0.1);
          decayValueMMSlider.SetMax(0.9);
        }
        if (agentRandomizeButton.OnMouse())
        {
          agentMoveSpeedSlider.SetValue01(random(1));
          agentSensorDistanceSlider.SetValue01(random(1));
          agentSensorAngleSlider.SetValue01(random(1));
          agentRotationAngleSlider.SetValue01(random(1));
          agentDepositAmountSlider.SetValue01(random(1));
          agentColorSlider.SetValue01(random(1));
        }
        if (saveCreationPropertiesButton.OnMouse())
        {
          PropertiesSave();
        }
        if (loadCreationPropertiesButton.OnMouse())
        {
          PropertiesLoad();
        }
        if (agentRestartPositionsButton.OnMouse())
        {
          for (int i = 0; i < totalPopulations; i++)
          {
            populations[i].ResetAgentPositions();
          }
        }
        if (saveAgentPropertiesButton.OnMouse())
        {
          AgentSave();
        }
        if (loadAgentPropertiesButton.OnMouse())
        {
          AgentLoad();
        }
        if (saveAllButton.OnMouse())
        {
          SaveSim();
        }
        if (loadAllButton.OnMouse())
        {
          LoadSim();
        }
        if (defaultPropertiesButton.OnMouse())
        {
          moveSpeedMMSlider.SetMinForce(5);
          moveSpeedMMSlider.SetMaxForce(50);
          sensorDistanceMMSlider.SetMinForce(1);
          sensorDistanceMMSlider.SetMaxForce(30);
          sensorAngleMMSlider.SetMinForce(5);
          sensorAngleMMSlider.SetMaxForce(120);
          rotationAngleMMSlider.SetMinForce(5);
          rotationAngleMMSlider.SetMaxForce(90);
          depositAmountMMSlider.SetMinForce(0.2);
          depositAmountMMSlider.SetMaxForce(0.8);
        }
      }
    } else
    {
      mouseDown = false;
    }

    UpdateSelectorValues();
    CheckSliderChanges();

    if (loadSimLoader)
    {
      loadSimLoader = false; 
      loadSimulationAgents();
    }
  }

  void loadSimulationAgents()
  {
    MakeWorld();
    selectedAgent = 0;
    for (int i = 0; i < world.populationAmount; i++)
    {
      JSONObject json = savedJSON.getJSONObject(i+1);

      populations[i].SetAgentProperty(AGENTPROPERTIES.MOVESPEED, json.getFloat("moveSpeed"));
      populations[i].SetAgentProperty(AGENTPROPERTIES.SENSORDISTANCE, json.getFloat("sensorDistance"));
      populations[i].SetAgentProperty(AGENTPROPERTIES.SENSORANGLE, json.getFloat("sensorAngle"));
      populations[i].SetAgentProperty(AGENTPROPERTIES.ROTATIONANGLE, json.getFloat("rotationAngle"));
      populations[i].SetAgentProperty(AGENTPROPERTIES.DEPOSITAMOUNT, json.getFloat("depositAmount"));
      populationColors[i] = json.getFloat("color");
      populationNames[i] = json.getString("name");
    }

    decaySpeed = savedJSON.getJSONObject(0).getFloat("decaySpeed");
  }

  void UpdateCall()
  {
    editorUpdateCall = false;
    selectedAgent = 0;
    agentSelector = new Selector(rmx+15, rmy+50+rbo, "Agent", populationNames, 15, colorYellow);
    currentPopulationAmount = totalPopulations;
    SetAgentPropertySliders();
  }

  void CheckSliderChanges()
  {
    if (populationAmountSlider.ValueChanged())
    {
      totalPopulations = round(populationAmountSlider.GetValue());
    }
    if (totalAgentsSlider.ValueChanged())
    {
      totalAgents = round(totalAgentsSlider.GetValue());
    }
    if (decayValueMMSlider.ValueChanged())
    {
      decaySpeedMinMax.x = decayValueMMSlider.GetMin();
      decaySpeedMinMax.y = decayValueMMSlider.GetMax();
    }

    if (moveSpeedMMSlider.ValueChanged())
    {
      moveSpeedMinMax.x = moveSpeedMMSlider.GetMin();
      moveSpeedMinMax.y = moveSpeedMMSlider.GetMax();
    }

    if (sensorDistanceMMSlider.ValueChanged())
    {
      sensorDistanceMinMax.x = sensorDistanceMMSlider.GetMin();
      sensorDistanceMinMax.y = sensorDistanceMMSlider.GetMax();
    }

    if (sensorAngleMMSlider.ValueChanged())
    {
      sensorAngleMinMax.x = sensorAngleMMSlider.GetMin();
      sensorAngleMinMax.y = sensorAngleMMSlider.GetMax();
    }

    if (rotationAngleMMSlider.ValueChanged())
    {
      rotationAngleMinMax.x = rotationAngleMMSlider.GetMin();
      rotationAngleMinMax.y = rotationAngleMMSlider.GetMax();
    }

    if (depositAmountMMSlider.ValueChanged())
    {
      depositAmountMinMax.x = depositAmountMMSlider.GetMin();
      depositAmountMinMax.y = depositAmountMMSlider.GetMax();
    }

    if (agentMoveSpeedSlider.ValueChanged())
    {
      populations[selectedAgent].SetAgentProperty(AGENTPROPERTIES.MOVESPEED, agentMoveSpeedSlider.GetValue());
    }
    if (agentSensorDistanceSlider.ValueChanged())
    {
      populations[selectedAgent].SetAgentProperty(AGENTPROPERTIES.SENSORDISTANCE, agentSensorDistanceSlider.GetValue());
    }
    if (agentSensorAngleSlider.ValueChanged())
    {
      populations[selectedAgent].SetAgentProperty(AGENTPROPERTIES.SENSORANGLE, agentSensorAngleSlider.GetValue());
    }
    if (agentRotationAngleSlider.ValueChanged())
    {
      populations[selectedAgent].SetAgentProperty(AGENTPROPERTIES.ROTATIONANGLE, agentRotationAngleSlider.GetValue());
    }
    if (agentDepositAmountSlider.ValueChanged())
    {
      populations[selectedAgent].SetAgentProperty(AGENTPROPERTIES.DEPOSITAMOUNT, agentDepositAmountSlider.GetValue());
    }
    if (agentColorSlider.ValueChanged())
    {
      populationColors[selectedAgent] = agentColorSlider.GetValue();
    }
  }

  void Show()
  {
    strokeWeight(lineThickness);
    noFill();

    //bottom window
    DrawWindow(bmx, bmy, bmw, bmh, colorWhite);
    DrawText("Agent visualization", bmx+5, bmy+5, colorWhite, 15);
    agentVisualizerScale.Update();
    agentVisualizerScale.Show();
    VisualizeAgent();

    //right window
    DrawWindow(rmx, rmy, rmw, rmh, colorWhite);
    DrawText("Global settings", rmx+5, rmy+5, colorWhite, 15);
    DrawText("FPS: " + frameRate, rmx+5, rbo-15, colorPink, 10);
    spawnTypeSelector.Update();
    spawnTypeSelector.Show();
    populationPropertiesSelector.Update();
    populationPropertiesSelector.Show();
    populationColorModeSelector.Update();
    populationColorModeSelector.Show();
    resetGlobalSettingsButton.Show();
    populationAmountSlider.Show();
    populationAmountSlider.Update();
    totalAgentsSlider.Show();
    totalAgentsSlider.Update();
    decayValueMMSlider.Show();
    decayValueMMSlider.Update();

    //agent properties
    DrawWindow(rmx, rmy+rbo, rmw, rmh-rbo, colorWhite);
    DrawText("Agent properties", rmx+5, rbo+5, colorWhite, 15);
    DrawText("Total Populations: " + currentPopulationAmount, rmx+5, rbo+25, colorYellow, 10); 
    agentSelector.Update();
    agentSelector.Show();

    agentMoveSpeedSlider.Update();
    agentMoveSpeedSlider.Show();
    agentSensorDistanceSlider.Update();
    agentSensorDistanceSlider.Show();
    agentSensorAngleSlider.Update();
    agentSensorAngleSlider.Show();
    agentRotationAngleSlider.Update();
    agentRotationAngleSlider.Show();
    agentDepositAmountSlider.Update();
    agentDepositAmountSlider.Show();
    agentColorSlider.Update();
    agentColorSlider.Show();

    agentRandomizeButton.Show();
    agentRestartPositionsButton.Show();
    saveAgentPropertiesButton.Show();
    loadAgentPropertiesButton.Show();
    saveAllButton.Show();
    loadAllButton.Show();

    int offset = 30;

    DrawText("Current creation settings", rmx+5, rbo+300+offset, colorYellow, 15);
    DrawText("Total populations: "       + world.populationAmount, rmx+5, rbo+325+offset, colorRed, 10);
    DrawText("Agents per population: "   + (int)(world.agents/world.populationAmount), rmx+5, rbo+340+offset, colorRed, 10);
    DrawText("Decay speed min/max: "     + cdmin + " - " + cdmax, rmx+5, rbo+355+offset, colorRed, 10);
    DrawText("Decay speed: "             + nf(decaySpeed, 0, 2), rmx+5, rbo+370+offset, colorRed, 10);


    DrawText("Move speed min/max: "      + populations[selectedAgent].moveSpeedMin      + " - " + populations[selectedAgent].moveSpeedMax, rmx+5, rbo+395+offset, colorRed, 10);
    DrawText("Sensor distance min/max: " + populations[selectedAgent].sensorDistanceMin + " - " + populations[selectedAgent].sensorDistanceMax, rmx+5, rbo+410+offset, colorRed, 10);
    DrawText("Sensor angle min/max: "    + populations[selectedAgent].sensorAngleMin    + " - " + populations[selectedAgent].sensorAngleMax, rmx+5, rbo+425+offset, colorRed, 10);
    DrawText("Rotation angle min/max: "  + populations[selectedAgent].rotationAngleMin  + " - " + populations[selectedAgent].rotationAngleMax, rmx+5, rbo+440+offset, colorRed, 10);
    DrawText("Deposit amount min/max: "  + populations[selectedAgent].depositAmountMin  + " - " + populations[selectedAgent].depositAmountMax, rmx+5, rbo+455+offset, colorRed, 10);

    //side window
    DrawWindow(smx, smy, smw, smh, colorWhite);
    DrawText("Agent creation settings", smx+5, smy+5, colorWhite, 15);
    createNewButton.Show();
    moveSpeedMMSlider.Update();
    moveSpeedMMSlider.Show();
    sensorDistanceMMSlider.Update();
    sensorDistanceMMSlider.Show();
    sensorAngleMMSlider.Update();
    sensorAngleMMSlider.Show();
    rotationAngleMMSlider.Update();
    rotationAngleMMSlider.Show();
    depositAmountMMSlider.Update();
    depositAmountMMSlider.Show();
    saveCreationPropertiesButton.Show();
    loadCreationPropertiesButton.Show();
    defaultPropertiesButton.Show();
    
    //help window
    DrawWindow(smx,sbo,smw,smh-sbo,colorWhite);
    DrawText("How to use", smx+5, smy+5+sbo, colorWhite, 20);
    DrawText("Agent creation settings:",smx+5,smy+50+sbo,colorYellow,15);
    DrawText("These are the min/max settings that agents can use when creating a new simulation.\nbecause of this the sliders for agent properties will be clamped to\nthe min max of the creation settings",smx+5,smy+70+sbo,colorWhite,10);
    
    DrawText("Global settings:",smx+5,smy+125+sbo,colorYellow,15);
    DrawText("These are settings that have nothing to do with specific agents.\n settings for how to spawn in agents, if their properties are synced\n total amount of simulated agents, how many populations\n and decay speed, which is how quick pheremones dissapear",smx+5,smy+145+sbo,colorWhite,10);
    
    DrawText("Agent properties:",smx+5,smy+215+sbo,colorYellow,15);
    DrawText("here you can see the properties of your agents and edit them on runtime.\nUse the selector to switch between populations, you can save and load\nspecific agent properties here too\nsaving the simulation saves the whole program and lets you load it back in.",smx+5,smy+235+sbo,colorWhite,10);
    
  }

  void VisualizeAgent()
  {
    float cellX = bmx+bmw/2-bmw/16;
    float cellY = bmy+bmh/2;
    float scl = 3;
    switch(agentVisualizerScale.GetSelection())
    {
    case 0:
      scl = 0.1;
      break;

    case 1:
      scl = 0.3;
      break;

    case 2:
      scl = 0.5;
      break;

    case 3:
      scl = 1;
      break;

    case 4:
      scl = 2;
      break;

    case 5:
      scl = 3;
      break;

    case 6:
      scl = 5;
      break;
    }

    float strokeCol = populationColors[selectedAgent];
    stroke(strokeCol, 100, 255);
    strokeWeight(2);

    //agent body
    fill(strokeCol, 255, 255);
    circle(cellX, cellY, 10*scl);

    //sensor distances
    float aa = populations[selectedAgent].sensorAngle;
    float sd = (populations[selectedAgent].sensorDistance+10);
    float slx, sly, smx, smy, srx, sry;
    slx = cellX+sin(radians(90-aa))*sd*scl;
    sly = cellY+cos(radians(90-aa))*sd*scl;
    smx = cellX+sin(radians(90))*sd*scl;
    smy = cellY+cos(radians(90))*sd*scl;
    srx = cellX+sin(radians(90+aa))*sd*scl;
    sry = cellY+cos(radians(90+aa))*sd*scl;
    line(cellX, cellY, slx, sly);
    line(cellX, cellY, smx, smy);  
    line(cellX, cellY, srx, sry);

    fill(strokeCol, 50, 255);
    circle(slx, sly, 6*scl);
    circle(smx, smy, 6*scl);
    circle(srx, sry, 6*scl);

    strokeCol += 255/2;
    if (strokeCol > 255)
    {
      strokeCol -= 255;
    }
    stroke(strokeCol, 255, 255);
    float ra = populations[selectedAgent].rotationAngle;
    line(cellX, cellY, cellX+sin(radians(90-ra))*20*scl, cellY+cos(radians(90-ra))*20*scl);
    line(cellX, cellY, cellX+sin(radians(90+ra))*20*scl, cellY+cos(radians(90+ra))*20*scl);

    strokeCol += 255/4;
    if (strokeCol > 255)
    {
      strokeCol -= 255;
    }
    stroke(strokeCol, 255, 255);
    line(cellX, cellY, cellX+populations[selectedAgent].moveSpeed*scl, cellY);
    line(cellX+populations[selectedAgent].moveSpeed*scl-2*scl, cellY-1*scl, cellX+populations[selectedAgent].moveSpeed*scl, cellY);
    line(cellX+populations[selectedAgent].moveSpeed*scl-2*scl, cellY+1*scl, cellX+populations[selectedAgent].moveSpeed*scl, cellY);

    stroke(populationColors[selectedAgent], 150, 150);
    fill(populationColors[selectedAgent], 50, 255);
    circle(cellX-5*scl, cellY, populations[selectedAgent].depositAmount*5*scl);
  }

  void UpdateSelectorValues()
  {
    switch(spawnTypeSelector.GetSelection())
    {
    case 0:
      spawnType = SPAWNTYPES.CIRCLEINWARDS;
      break;

    case 1:
      spawnType = SPAWNTYPES.CIRCLEOUTWARDS;
      break;

    case 2:
      spawnType = SPAWNTYPES.RANDOMPOSITION;
      break;
    }

    switch(populationPropertiesSelector.GetSelection())
    {
    case 0:
      populationProperties = POPULATIONPROPERTIES.RANDOM;
      break;

    case 1:
      populationProperties = POPULATIONPROPERTIES.SYNC;
      break;
    }

    switch(populationColorModeSelector.GetSelection())
    {
    case 0:
      populationColorMode = COLORMODE.RANDOM;
      break;

    case 1:
      populationColorMode = COLORMODE.INCREMENT;
      break;
    }

    selectedAgent = agentSelector.GetSelection();

    if (agentSelector.ValueChanged())
    {
      SetAgentPropertySliders();
    }
  }

  void DrawWindow(int _x, int _y, int _w, int _h, color col)
  {
    stroke(col);
    fill(0);
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
//===============================SAVING/LOADING=================================================//

void saveAgentProperties(File selection)
{
  if (selection != null)
  {
    JSONObject json = new JSONObject();

    Population cp = populations[editor.selectedAgent];
    json.setFloat("moveSpeed", cp.moveSpeed);
    json.setFloat("sensorDistance", cp.sensorDistance);
    json.setFloat("sensorAngle", cp.sensorAngle);
    json.setFloat("rotationAngle", cp.rotationAngle);
    json.setFloat("depositAmount", cp.depositAmount);
    json.setFloat("color", populationColors[editor.selectedAgent]);

    String saveLoc = selection.getPath();
    saveJSONObject(json, saveLoc + ".agent");
  }
}

void loadAgentProperties(File selection)
{
  if (selection != null)
  {
    JSONObject json = loadJSONObject(selection);

    editor.agentMoveSpeedSlider.SetValue(json.getFloat("moveSpeed"));
    editor.agentSensorDistanceSlider.SetValue(json.getFloat("sensorDistance"));
    editor.agentSensorAngleSlider.SetValue(json.getFloat("sensorAngle"));
    editor.agentRotationAngleSlider.SetValue(json.getFloat("rotationAngle"));
    editor.agentDepositAmountSlider.SetValue(json.getFloat("depositAmount"));
    editor.agentColorSlider.SetValue(json.getFloat("color"));
  }
}

void SaveSimulation(File selection)
{
  if (selection != null)
  {
    JSONArray json = new JSONArray();

    JSONObject simulation = new JSONObject();
    simulation.setInt("totalAgents", world.agents);
    simulation.setInt("totalPopulations", world.populationAmount);
    simulation.setFloat("decaySpeedMin", cdmin);
    simulation.setFloat("decaySpeedMax", cdmax);
    simulation.setFloat("decaySpeed", decaySpeed);
    simulation.setInt("colorMode", currentPopulationColorMode.getValue());
    simulation.setInt("propertySync", currentPopulationProperties.getValue());
    simulation.setInt("spawnType", currentSpawnType.getValue());
    simulation.setFloat("moveSpeedMin", moveSpeedMinMax.x);
    simulation.setFloat("moveSpeedMax", moveSpeedMinMax.y);
    simulation.setFloat("sensorDistanceMin", sensorDistanceMinMax.x);
    simulation.setFloat("sensorDistanceMax", sensorDistanceMinMax.y);
    simulation.setFloat("sensorAngleMin", sensorAngleMinMax.x);
    simulation.setFloat("sensorAngleMax", sensorAngleMinMax.y);
    simulation.setFloat("rotationAngleMin", rotationAngleMinMax.x);
    simulation.setFloat("rotationAngleMax", rotationAngleMinMax.y);
    simulation.setFloat("depositAmountMin", depositAmountMinMax.x);
    simulation.setFloat("depositAmountMax", depositAmountMinMax.y);

    json.setJSONObject(0, simulation);

    for (int i = 0; i < world.populationAmount; i++)
    {
      JSONObject agent = new JSONObject();

      Population cp = populations[i];
      agent.setFloat("moveSpeed", cp.moveSpeed);
      agent.setFloat("sensorDistance", cp.sensorDistance);
      agent.setFloat("sensorAngle", cp.sensorAngle);
      agent.setFloat("rotationAngle", cp.rotationAngle);
      agent.setFloat("depositAmount", cp.depositAmount);
      agent.setFloat("color", populationColors[i]);
      agent.setString("name", populationNames[i]);

      json.setJSONObject(i+1, agent);
    }

    String saveLoc = selection.getPath();
    saveJSONArray(json, saveLoc + ".simulation");
  }
}

void LoadSimulation(File selection)
{
  if (selection != null)
  {
    JSONArray json = loadJSONArray(selection);

    editor.totalAgentsSlider.SetValue(json.getJSONObject(0).getInt("totalAgents"));
    editor.populationAmountSlider.SetValue(json.getJSONObject(0).getInt("totalPopulations"));
    editor.decayValueMMSlider.SetMinForce(json.getJSONObject(0).getFloat("decaySpeedMin"));
    editor.decayValueMMSlider.SetMaxForce(json.getJSONObject(0).getFloat("decaySpeedMax"));
    editor.populationColorModeSelector.SetSelection(json.getJSONObject(0).getInt("colorMode"));
    editor.populationPropertiesSelector.SetSelection(json.getJSONObject(0).getInt("propertySync"));
    editor.spawnTypeSelector.SetSelection(json.getJSONObject(0).getInt("spawnType"));
    moveSpeedMinMax.x = json.getJSONObject(0).getFloat("moveSpeedMin");
    moveSpeedMinMax.y = json.getJSONObject(0).getFloat("moveSpeedMax");
    sensorDistanceMinMax.x = json.getJSONObject(0).getFloat("sensorDistanceMin");
    sensorDistanceMinMax.y = json.getJSONObject(0).getFloat("sensorDistanceMax");
    sensorAngleMinMax.x = json.getJSONObject(0).getFloat("sensorAngleMin");
    sensorAngleMinMax.y = json.getJSONObject(0).getFloat("sensorAngleMax");
    rotationAngleMinMax.x = json.getJSONObject(0).getFloat("rotationAngleMin");
    rotationAngleMinMax.y = json.getJSONObject(0).getFloat("rotationAngleMax");
    depositAmountMinMax.x = json.getJSONObject(0).getFloat("depositAmountMin");
    depositAmountMinMax.y = json.getJSONObject(0).getFloat("depositAmountMax");

    editor.loadSimLoader = true;
    editor.savedJSON = json;
  }
}

void SaveProperties(File selection)
{
  if (selection != null)
  {
    JSONObject json = new JSONObject();

    json.setFloat("moveSpeedMin", editor.moveSpeedMMSlider.GetMin());
    json.setFloat("moveSpeedMax", editor.moveSpeedMMSlider.GetMax());
    json.setFloat("sensorDistanceMin", editor.sensorDistanceMMSlider.GetMin());
    json.setFloat("sensorDistanceMax", editor.sensorDistanceMMSlider.GetMax());
    json.setFloat("sensorAngleMin", editor.sensorAngleMMSlider.GetMin());
    json.setFloat("sensorAngleMax", editor.sensorAngleMMSlider.GetMax());
    json.setFloat("rotationAngleMin", editor.rotationAngleMMSlider.GetMin());
    json.setFloat("rotationAngleMax", editor.rotationAngleMMSlider.GetMax());
    json.setFloat("depositAmountMin", editor.depositAmountMMSlider.GetMin());
    json.setFloat("depositAmountMax", editor.depositAmountMMSlider.GetMax());

    String saveLoc = selection.getPath();
    saveJSONObject(json, saveLoc + ".properties");
  }
}

void LoadProperties(File selection)
{
  if (selection != null)
  {
    JSONObject json = loadJSONObject(selection);

    editor.moveSpeedMMSlider.SetMinForce(json.getFloat("moveSpeedMin"));
    editor.moveSpeedMMSlider.SetMaxForce(json.getFloat("moveSpeedMax"));
    editor.sensorDistanceMMSlider.SetMinForce(json.getFloat("sensorDistanceMin"));
    editor.sensorDistanceMMSlider.SetMaxForce(json.getFloat("sensorDistanceMax"));
    editor.sensorAngleMMSlider.SetMinForce(json.getFloat("sensorAngleMin"));
    editor.sensorAngleMMSlider.SetMaxForce(json.getFloat("sensorAngleMax"));
    editor.rotationAngleMMSlider.SetMinForce(json.getFloat("rotationAngleMin"));
    editor.rotationAngleMMSlider.SetMaxForce(json.getFloat("rotationAngleMax"));
    editor.depositAmountMMSlider.SetMinForce(json.getFloat("depositAmountMin"));
    editor.depositAmountMMSlider.SetMaxForce(json.getFloat("depositAmountMax"));
  }
}

//===============================BUTTON=================================================//
class Button
{
  int x, y, w, h;
  String text;
  color col;
  color highlightcol;
  int textSize;

  Button(int _x, int _y, int _w, int _h, String _text, int _textSize, color _col, color _hcol)
  {
    highlightcol = _hcol;
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
    if (OnMouse())
    {
      stroke(highlightcol);
    } else
    {
      stroke(col);
    }

    noFill();
    rect(x-w/2, y-h/2, w, h);
    fill(col);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x, y-3);
  }

  boolean OnMouse()
  {
    return mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2;
  }
}

//===============================SELECTOR=================================================//
class Selector
{
  int selectionAmount;
  String name;
  boolean selectionChanged;
  String selectionNames[];
  int x, y;
  int textSize;
  color col;
  int selection = 0;
  boolean selectionPressed = false;

  Button increment, decrement;

  Selector(int _x, int _y, String _name, String names[], int ts, color _col)
  {
    name = _name;
    textSize = ts;
    x = _x;
    y = _y;
    col = _col;
    selectionNames = names;
    selectionAmount = names.length;

    increment = new Button(x+25, y, 16, 16, "+", 15, col, color(230, 255, 255));
    decrement = new Button(x, y, 16, 16, "-", 15, col, color(230, 255, 255));
  }

  int GetSelection()
  {
    return selection;
  }

  void SetSelection(int i)
  {
    if (i >= 0 && i < selectionAmount)
    {
      selection = i;
      selectionChanged = true;
    }
  }

  void Update()
  {
    if (mousePressed)
    {
      if (!selectionPressed)
      {
        selectionPressed = true;
        if (increment.OnMouse())
        {
          selection ++;
          selection = constrain(selection, 0, selectionAmount-1);
          selectionChanged = true;
        }
        if (decrement.OnMouse())
        {
          selection --;
          selection = constrain(selection, 0, selectionAmount-1);
          selectionChanged = true;
        }
      }
    } else
    {
      selectionPressed = false;
    }
  }

  boolean ValueChanged()
  {
    if (selectionChanged)
    {
      selectionChanged= false;
      return true;
    }
    return false;
  }

  void Show()
  {
    textAlign(LEFT, CENTER);
    textSize(textSize);
    strokeWeight(3);
    fill(col);
    text(name + ": " + selectionNames[selection], x+40, y);
    increment.Show();
    decrement.Show();
  }
}

//===============================SLIDER=================================================//
class Slider
{
  int x, y;
  float value=0.5, lastValue = 0.5;
  boolean valChanged = false;
  boolean md = false;
  float min=0, max=1;
  int w;
  String name;
  float textSize;
  color col;
  boolean movePoint = false;
  boolean isInt = false;
  Point p;
  class Point
  {
    PVector position = new PVector(0, 0);
    float radius = 15;
    Point(float x, float y)
    {
      position.x = x;
      position.y = y;
    }
  }

  Slider(int _x, int _y, int _w, float _min, float _max, String _name, float ts, color _col)
  {
    textSize = ts;
    x = _x;
    y = _y;
    w = _w;
    min = _min;
    max = _max;
    name = _name;
    col = _col;
    p = new Point(x+w/2, y);
  }

  Slider(int _x, int _y, int _w, float _min, float _max, String _name, float ts, color _col, boolean _isInt)
  {
    isInt = _isInt;
    textSize = ts;
    x = _x;
    y = _y;
    w = _w;
    min = _min;
    max = _max;
    name = _name;
    col = _col;
    p = new Point(x+w/2, y);
  }

  void Update()
  {
    lastValue = value;
    if (mousePressed)
    {
      if (!md)
      {
        md = true;
        if (mouseX > p.position.x-p.radius/2 && mouseX < p.position.x+p.radius/2 && mouseY > p.position.y-p.radius/2 && mouseY < p.position.y+p.radius/2)
        {
          movePoint = true;
        }
      }
    } else
    {
      md = false;
      movePoint = false;
    }

    if (movePoint)
    {
      p.position.x = mouseX;
      p.position.x = constrain(p.position.x, x, x+w);
      value = map(p.position.x, x, x+w, 0, 1);
    }
    if (value != lastValue)
    {
      valChanged = true;
    }
  }

  void Show()
  {
    stroke(col);
    fill(col);
    strokeWeight(2);
    line(x, y, p.position.x, y);
    circle(p.position.x, p.position.y, p.radius);
    textAlign(LEFT, CENTER);
    textSize(textSize);
    if (isInt)
    {
      text(name + ": " + (int)round(GetValue()), x+w+10, y);
    } else
    {
      text(name + ": " + nf(GetValue(), 0, 2), x+w+10, y);
    }
    stroke(col, 100);
    line(p.position.x, y, x+w, y);
  }

  float GetValue()
  {
    return map(value, 0, 1, min, max);
  }

  float GetValue01()
  {
    return value;
  }

  void SetValue(float val)
  {
    value = map(val, min, max, 0, 1);
    p.position.x = x + value*w;
    valChanged = true;
  }

  void SetValue01(float val)
  {
    value = val;
    p.position.x = x+value*w;
    valChanged = true;
  }

  boolean ValueChanged()
  {
    if (valChanged)
    {
      valChanged = false;
      return true;
    }
    return false;
  }
}

class MinMaxSlider
{
  int x, y;
  float valueMin=0, lastValueMin = 0, valueMax=1, lastValueMax=1;
  boolean valChanged = false;
  boolean md = false;
  float min=0, max=1;
  int w;
  String name;
  float textSize;
  color col;
  boolean movePointMin = false;
  boolean movePointMax = false;
  boolean isInt = false;
  Point pMin, pMax;
  class Point
  {
    PVector position = new PVector(0, 0);
    float radius = 15;
    Point(float x, float y)
    {
      position.x = x;
      position.y = y;
    }
  }

  MinMaxSlider(int _x, int _y, int _w, float _min, float _max, String _name, float ts, color _col)
  {
    textSize = ts;
    x = _x;
    y = _y;
    w = _w;
    min = _min;
    max = _max;
    name = _name;
    col = _col;
    pMin = new Point(x, y);
    pMax = new Point(x+w, y);
  }

  MinMaxSlider(int _x, int _y, int _w, float _min, float _max, String _name, float ts, color _col, boolean _isInt)
  {
    isInt = _isInt;
    textSize = ts;
    x = _x;
    y = _y;
    w = _w;
    min = _min;
    max = _max;
    name = _name;
    col = _col;
    pMin = new Point(x, y);
    pMax = new Point(x+w, y);
  }

  void Update()
  {
    lastValueMin = valueMin;
    lastValueMax = valueMax;
    if (mousePressed)
    {
      if (!md)
      {
        md = true;
        if (mouseX > pMin.position.x-pMin.radius/2 && mouseX < pMin.position.x+pMin.radius/2 && mouseY > pMin.position.y-pMin.radius/2 && mouseY < pMin.position.y+pMin.radius/2)
        {
          movePointMin = true;
        }
        if (mouseX > pMax.position.x-pMax.radius/2 && mouseX < pMax.position.x+pMax.radius/2 && mouseY > pMax.position.y-pMax.radius/2 && mouseY < pMax.position.y+pMax.radius/2)
        {
          movePointMax = true;
        }
      }
    } else
    {
      md = false;
      movePointMax = false;
      movePointMin = false;
    }

    if (movePointMin)
    {
      pMin.position.x = mouseX;
      pMin.position.x = constrain(pMin.position.x, x, pMax.position.x-pMax.radius);
      valueMin = map(pMin.position.x, x, x+w, 0, 1);
    }

    if (movePointMax)
    {
      pMax.position.x = mouseX;
      pMax.position.x = constrain(pMax.position.x, pMin.position.x+pMin.radius, x+w);
      valueMax = map(pMax.position.x, x, x+w, 0, 1);
    }

    if (valueMin != lastValueMin || valueMax != lastValueMax)
    {
      valChanged = true;
    }
  }

  void Show()
  {
    stroke(col);
    fill(col);
    strokeWeight(2);
    line(pMin.position.x, y, pMax.position.x, y);
    circle(pMin.position.x, pMin.position.y, pMin.radius);
    circle(pMax.position.x, pMax.position.y, pMax.radius);
    textAlign(LEFT, CENTER);
    textSize(textSize);
    stroke(col, 100);
    line(x, y, pMin.position.x, y);
    line(pMax.position.x, y, x+w, y);

    if (isInt)
    {
      text(name + ": " + (int)round(GetMin())+" | "+(int)round(GetMax()), x+w+10, y);
    } else
    {
      text(name + ": " + nf(GetMin(), 0, 2) + " | " + nf(GetMax(), 0, 2), x+w+10, y);
    }
  }


  float GetMin()
  {
    return map(valueMin, 0, 1, min, max);
  }

  float GetMax()
  {
    return map(valueMax, 0, 1, min, max);
  }

  float GetMin01()
  {
    return valueMin;
  }

  float GetMax01()
  {
    return valueMax;
  }

  void SetMin(float val)
  {
    float vm = map(val, min, max, 0, 1);
    if (vm < valueMax)
    {
      valueMin = vm;
      pMin.position.x = x + valueMin*w;
      valChanged = true;
    }
  }

  void SetMax(float val)
  {
    float vx = map(val, min, max, 0, 1);
    if (vx > valueMin)
    {
      valueMax = vx;
      pMax.position.x = x + valueMax*w;
      valChanged = true;
    }
  }

  void SetMinForce(float val)
  {
    float vm = map(val, min, max, 0, 1);

    valueMin = vm;
    pMin.position.x = x + valueMin*w;
    valChanged = true;
  }

  void SetMaxForce(float val)
  {
    float vx = map(val, min, max, 0, 1);

    valueMax = vx;
    pMax.position.x = x + valueMax*w;
    valChanged = true;
  }

  boolean ValueChanged()
  {
    if (valChanged)
    {
      valChanged = false;
      return true;
    }
    return false;
  }
}
