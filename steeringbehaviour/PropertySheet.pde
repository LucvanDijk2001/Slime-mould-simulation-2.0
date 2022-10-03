enum SPAWNTYPES
{
  CIRCLEINWARDS(0), 
    CIRCLEOUTWARDS(1), 
    RANDOMPOSITION(2);

  int val;
  private SPAWNTYPES(int v)
  {
    this.val = v;
  }

  public int getValue()
  {
    return val;
  }
}

enum POPULATIONPROPERTIES
{
  RANDOM(0), 
    SYNC(1);

  int val;
  private POPULATIONPROPERTIES(int v)
  {
    this.val = v;
  }

  public int getValue()
  {
    return val;
  }
}

enum COLORMODE
{
  RANDOM(0), 
    INCREMENT(1);

  int val;
  private COLORMODE(int v)
  {
    this.val = v;
  }

  public int getValue()
  {
    return val;
  }
}

enum AGENTPROPERTIES
{
  MOVESPEED, 
    SENSORDISTANCE, 
    SENSORANGLE, 
    ROTATIONANGLE, 
    DEPOSITAMOUNT,
    COLOR
}

//pvectors are x:min y:max;
//global settings
SPAWNTYPES spawnType                      = SPAWNTYPES.CIRCLEINWARDS;    //default = CIRCLEINWARDS
POPULATIONPROPERTIES populationProperties = POPULATIONPROPERTIES.RANDOM; //default = RANDOM
COLORMODE populationColorMode             = COLORMODE.RANDOM;            //default = RANDOM

SPAWNTYPES currentSpawnType;
POPULATIONPROPERTIES currentPopulationProperties;
COLORMODE currentPopulationColorMode;

int totalPopulations                      = 3;                     //default = 3
int totalAgents                           = 60000;                 //default = 60000
PVector decaySpeedMinMax                  = new PVector(0.1, 0.9); //default = 0.1,0.9
float cdmin, cdmax;
float decaySpeed;

//agent specific
PVector moveSpeedMinMax      = new PVector(5, 50);    //default = 5,100
PVector sensorDistanceMinMax = new PVector(1, 30);    //default = 1,30
PVector sensorAngleMinMax    = new PVector(5, 120);   //default = 5,120
PVector rotationAngleMinMax  = new PVector(5, 90);    //default = 5,60
PVector depositAmountMinMax  = new PVector(0.2, 0.8); //default = 0.2,0.8

float cmsmin,cmsmax,csdmin,csdmax,csamin,csamax,cramin,cramax,cdamin,cdamax;

boolean editorUpdateCall = false;

String populationNames[];
float populationColors[];
Population populations[];

String[] namePieces = new String[]
  {
  "da", 
  "ga", 
  "ba", 
  "na", 
  "ma", 
  "den", 
  "gon", 
  "pan", 
  "li", 
  "do", 
  "bo", 
  "no", 
  "lo", 
  "ko", 
  "li", 
  "si", 
  "vi", 
  "ri", 
  "de", 
  "re", 
  "ne", 
  "pe", 
  "koo", 
  "loo", 
  "bee", 
  "tee", 
  "tu", 
  "mu", 
  "ru"
};
