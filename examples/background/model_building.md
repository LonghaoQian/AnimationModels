
# Built-in Models
This package provides the following built-in models that can be created by a single function call:
## Quadrotor
- To create a quadrotor, use [CreateQuadRotor.m](../../src/models/CreateQuadRotor.m);
- The body-fixed frame of the plane is ``planeObj.frame``;


## Fixed-wing plane
- To create a fixed-wing plane, use [CreatePlane.m](../../src/models/CreatePlane.m);
- The body-fixed frame of the plane is ``planeObj.frame``;
- The 

## Vtol

- To create a vtol, use [CreateTwingEngineVtol.m](../../src/models/CreateTwingEngineVtol.m)
- To rotate the engines around the wing, use [UpdateEngineAngleTwinEngineVtol.m](../../src/models/UpdateEngineAngleTwinEngineVtol.m)
- The body-fixed frame of the plane is ``planeObj.frame``;

## Gate

- To create a gate, use [CreateRroundGate.m](../../src/models/CreateRroundGate.m)

## Hud

- To create hud, use [CreateSimpleHud.m](../../src/hud/CreateSimpleHud.m)
- To update hud, use [UpdateSimpleHud.m](../../src/hud/UpdateSimpleHud.m)

# Update Figures
Use the ``drawnow`` function

# Figure Primitives
To create your own models, you may use the following commands

The figure primitives are the fundamental elements 

# Building Simple 3d Models
For detailed 
- Define a 3d surface

- Define line primitive

- Define a cylinder



**[Back To Table of Contents](../README.md)**