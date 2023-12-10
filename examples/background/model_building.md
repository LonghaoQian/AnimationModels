
# Built-in Models
- This package provides the following built-in models that can be created by a single function call.
- Read [Background of Rotations](rotation_matrix.md) for more details about mathematical background.
- [Matlab Animation Frame System](animation_frame_system.md) explains in details about how frame systems work in Matlab.

## Quadrotor
- To create a quadrotor, use [CreateQuadRotor.m](../../src/models/CreateQuadRotor.m);
- The body-fixed frame of the plane is ``planeObj.frame``;

![Alt Text](../../figures/quad1.png)

## Fixed-wing plane
- To create a fixed-wing plane, use [CreatePlane.m](../../src/models/CreatePlane.m);
- The body-fixed frame of the plane is ``planeObj.frame``;
- The 

![Alt Text](../../figures/plane1.png)

## Vtol

- To create a vtol, use [CreateTwingEngineVtol.m](../../src/models/CreateTwingEngineVtol.m)
- To rotate the engines around the wing, use [UpdateEngineAngleTwinEngineVtol.m](../../src/models/UpdateEngineAngleTwinEngineVtol.m)
- The body-fixed frame of the plane is ``planeObj.frame``;

![Alt Text](../../figures/vtol1.png)

## Gate

- To create a gate, use [CreateRroundGate.m](../../src/models/CreateRroundGate.m)

![Alt Text](../../figures/gate.png)

## Hud

- To create hud, use [CreateSimpleHud.m](../../src/hud/CreateSimpleHud.m)
- To update hud, use [UpdateSimpleHud.m](../../src/hud/UpdateSimpleHud.m)

![Alt Text](../../figures/hud.png)

# Figure Primitives
To create your own models, you may use the following commands

The figure primitives are the fundamental elements 

# Building Simple 3d Models
## 3D surfaces
- To learn how to create 3d surfaces, read more details about the [patch](https://www.mathworks.com/help/matlab/ref/patch.html) and the [surface](https://www.mathworks.com/help/matlab/ref/surf.html) command.

- To define a cylinder, a simple way is to used the 

## Line primitive


## Specify the parent frame. 
- The most important property of a 3d model is its parent frame as it realizes the transformation of the model.
- The parent frame
- One can also use the ``set`` function 

# Update Figures
Use the ``drawnow`` function


**[Back To Table of Contents](../README.md)**