enum SPAWNTYPES
{
  CIRCLEINWARDS, 
    CIRCLEOUTWARDS, 
    RANDOMPOSITION
}

enum POPULATIONPROPERTIES
{
  RANDOM, 
    SYNC
}

//pvectors are x:min y:max;
//global settings
int totalPopulations                      = 3;
int totalAgents                           = 60000;
SPAWNTYPES spawnType                      = SPAWNTYPES.CIRCLEINWARDS;
POPULATIONPROPERTIES populationProperties = POPULATIONPROPERTIES.SYNC;
PVector decaySpeedMinMax                  = new PVector(0.1, 0.9); //default = 0.1,0.9

//agent specific
PVector moveSpeedMinMax      = new PVector(5, 50);   //default = 5,100
PVector sensorDistanceMinMax = new PVector(1, 30);    //default = 1,30
PVector sensorAngleMinMax    = new PVector(5, 120);   //default = 5,120
PVector rotationAngleMinMax  = new PVector(5, 60);    //default = 5,60
PVector depositAmountMinMax  = new PVector(0.2, 0.8); //default = 0.2,0.8
