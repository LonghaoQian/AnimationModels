# Matlab Animation Models
## An easy and ready to use visualization package written in Matlab for flight simulation.

## Author
Dr. Longhao Qian

- Ph.D., M.Eng, MS, BS in Aerospace Science and Engineering
- [linkedin](https://www.linkedin.com/in/longhao-qian-68705415a/) 

## Please cite this repository
### APA format
```
Qian, L. (2023). Matlab Drone Simulation Visualization Package (Version 1.0.0) [Computer software].
```
### BibTex
```
@software{Qian_Matlab_Drone_Simulation_2023,
author = {Qian, Longhao},
month = dec,
title = {{Matlab Drone Simulation Visualization Package}},
url = {https://github.com/LonghaoQian/AnimationModels},
version = {1.0.0},
year = {2023}
}
```
Alternatively, you could obtain the citation from Github citation tap:

## What can this Matlab package do?
- Provides a compact and easy way to generate animations from flight simulation data.
- Encapsulates and concentrates individual 3D rendering functions into a single function to provide a clean and concrete interface. 
- I also provide [background information](examples/background/README.md) and [coding guide](examples/README.md) about how to generate animations in Matlab environment.
- You could build your own customized visualization based on the code in this package. 

## Examples
### A fixed-wing drone simulation with artificial horizon display
![Alt Text](figures/circular_arc_trajectory.gif)
### A quadrotor drone flying through gates
![Alt Text](figures/quadrotor_circular_trajectory.gif)
### A twin-engine VTOL with tilting engines
![Alt Text](figures/vtol_animate.gif)



## How to use this package?
All the source files are in
```
\src
```
Follow the examples in
```
\exmples
```

- Please read through the [background information](examples/background/README.md) to get familar with the mathematical concepts used in this package.
- Pleasse follow the instructions in [examples](examples/README.md) to learn how to use this package to build an animation.