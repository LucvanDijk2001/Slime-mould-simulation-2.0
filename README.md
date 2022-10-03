# Slime-mould-simulation-2.0
## Improved version of the slime mould simulation

This is a follow up on the first iteration of the slime mould steering behaviour project.
After making the first program i felt like i could do better and it became this iteration.

In this version I was able to simulate a lot more agents, up to 100k at a *decent* fps with only 1 population.

This version also supports multiple populations. Populations try to avoid pheremones from other populations resulting in interesting visuals.

I once again want to credit this paper i used:
https://cargocollective.com/sagejenson/physarum made by Sage Jenson.

I also want to thank Sebastian League for inspiring me to make something like this:
https://www.youtube.com/c/SebastianLague

(We don't look at the editor code... haha)

## Documentation
![image](https://user-images.githubusercontent.com/59364952/193634714-655d5465-cd24-43af-b129-abf971fcc5e0.png)

### Global settings
| Spawn type | The position agents spawn with what direction |
| --- | --- |
| `Circle inwards` | Spawn agents in a circle facing inwards |
| `Circle outwards` | Spawn agents in a circle facing outwards |
| `Random position` | Spawn agents at a random position with a random direction |
| --- | --- |
| Population properties | Special settings for agent properties |
| `Random` | Populations will all get random values from the agent creation settings min/max values |
| `Circle outwards` | Populations will all get the same settings for agents except for color |
| --- | --- |
| Color mode | color settings for population generation |
| `Random` | Give a random hue value to every population |
| `Increment` | Hue slider will be equaly divided over all populations so all populations have a different color |
| --- | --- |
| `Total populations` | The amount of populations the program will generate |
| `Total agents` | The total amount of agents that will be simulated (equally divided over populations) |
| `Decay speed` | The speed at which pheremones dissapear |

### Creation creation settings
| Setting | Description |
| --- | --- |
| `Move speed` | The min/max move speed agents of this simulation can get |
| `Sensor distance` | The min/max sensor distance agents of this simulation can get |
| `Sensor angle` | The min/max angle between sensors agents of this simulation can get |
| `Rotation angle` | The min/max rotation speed agents of this simulation can get |
| `Deposit amount` | The min/max pheremone deposit value agents of this simulation can get |

| Buttons | Description |
| --- | --- |
| `Set default` | Returns the sliders to their default settings |
| `Save properties` | Save your properties to a file |
| `Load properties` | Load your proerties to a file |
| `Create` | Create a new simulation out of specified agent creation settings *AND* global settings |

### Agent properties
| Agent | Agent selector to switch between populations |
| --- | --- |

| Setting | Description |
| --- | --- |
| `Move speed` | Agent move speed that updates at runtime |
| `Sensor distance` | Agent sensor distance that updates at runtime |
| `Sensor angle` | Agent sensor angle that updates at runtime |
| `Rotation angle` | Agent rotation angle that updates at runtime |
| `Deposit amount` | Agent deposit amount that updates at runtime |
| `Color` | Agent color that updates at runtime |

| Buttons | Description |
| --- | --- |
| `Randomize` | Randomize all settings for selected agent |
| `Reset agent positions` | Reset all agent positions using global spawn type value |
| `Save agent properties` | save current agent properties to a file |
| `Load agent properties` | load agent properties file onto current selected agent |
| `Save simulation` | save the entire simulation with all it's properties to a file |
| `Load simulation` | load an entire simulation from a file |

### Agent visualization
This tab shows an approximate visualization of what the currently selected agent looks like.
The visualization for the agents updates realtime while changing agent settings.

## Some cool gifs (that are super compressed)
![3random](https://user-images.githubusercontent.com/59364952/193641467-20e164e7-0fdb-427e-81b6-1ff8ce0e347a.gif)
![innnercon](https://user-images.githubusercontent.com/59364952/193641648-6158f93b-87cd-4807-a358-23116b5d62b3.gif)
![4kagent](https://user-images.githubusercontent.com/59364952/193642021-fc57f8ed-d444-40e2-8c96-0e9492366962.gif)
![5pop](https://user-images.githubusercontent.com/59364952/193642040-21324f6a-d8ed-4ada-8959-912835a5d895.gif)
![acid](https://user-images.githubusercontent.com/59364952/193642149-0c2afd54-3f1f-4e62-bd61-990a78563233.gif)
![bs](https://user-images.githubusercontent.com/59364952/193642283-a3ccae29-0ab1-4e09-bc82-be2f05384df7.gif)
![bw](https://user-images.githubusercontent.com/59364952/193642574-1a574b35-1acb-4258-b0bf-60334882e82f.gif)
![dna](https://user-images.githubusercontent.com/59364952/193642745-addec19a-6355-4c96-a24a-0cb5738f942f.gif)
![ff](https://user-images.githubusercontent.com/59364952/193643074-4ef57c1b-5907-4c05-9bfa-ec88419a0ee8.gif)
![mf](https://user-images.githubusercontent.com/59364952/193643190-80780b3c-736f-4047-bb9b-e7379aeb1719.gif)
![np](https://user-images.githubusercontent.com/59364952/193643543-337998bc-2411-44fb-b33b-845d395fb919.gif)
![col](https://user-images.githubusercontent.com/59364952/193643805-51f6f665-d7f9-4286-94a0-5b967a21b729.gif)
![sq](https://user-images.githubusercontent.com/59364952/193643913-d1dded38-3b52-4f8b-a9e1-ed2a5a88f1e1.gif)
![sun](https://user-images.githubusercontent.com/59364952/193644020-533e6782-3456-4187-9a7b-736217573995.gif)
![snn](https://user-images.githubusercontent.com/59364952/193644148-faf6ff30-a29c-4a4d-a8d9-16943eb541cb.gif)
![fw](https://user-images.githubusercontent.com/59364952/193644254-d753bc24-1a23-4971-8279-78556628c222.gif)

