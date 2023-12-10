# The Overall Procedure
The overall procedure is summerized in the following figure:

<img src="../../figures/mdss-overall procedure.drawio.png" 
        alt="Picture" 
        width="300" 
        style="display: block; margin: 0 auto" />

## Code Example
- Run [fixedwing_cirular_path.m](../fixed-wing%20model/fixedwing_cirular_path.m), and observe the results.
- The procedure of the animation is shown in the following figures:

![Alt Text](../../figures/code_1.png)

![Alt Text](../../figures/code_2.png)

![Alt Text](../../figures/code_3.png)

## How to modify the code to fit your need?
- Load your own simulation data. The simulation data must contain the position and the attitude of the aircraft.
- If you need to use HUD, your flight simulation data must also include airspeed.
- You could use the [Built-in Models](model_building.md) to quickly create models.
- If you need to modify the model, please read [Built-in Models](model_building.md) and [Matlab Animation Frame System](animation_frame_system.md) to build your custom model.

## Bulit-in models in this package

- There are several models provided in this package that can be created by a simple function call.
- Please read [Built-in Models](model_building.md) for more details.

## Rotate and translate your model

- Read [Background of Rotations](rotation_matrix.md) for more details about mathematical background.

- [Matlab Animation Frame System](animation_frame_system.md) explains in details about how frame systems work in Matlab.

## Update cameras

- [Camera Settings](camera_settings.md) explains in details about how to define and update a proper camera in animation

## Models with multiple components

- [Matlab Animation Frame System](animation_frame_system.md) explains in details about how frame systems work in Matlab.
- Read [CreateTwingEngineVtol.m](../../src/models/CreateTwingEngineVtol.m) to learn how to build a model with rotating parts.

![Alt Text](../../figures/vtol_animate.gif)

**[Back To Table of Contents](../README.md)**