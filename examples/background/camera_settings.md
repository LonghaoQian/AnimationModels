# Camera Model
This package provides the following 3 types of view:
## The Side View Mode

The side view mode is the default view. Use [UpdateCameraModelSideView.m](../../src/camera/UpdateCameraModelSideView.m) to specify the camera.

<img src="../../figures/circular_arc_side_view.gif" 
        alt="Picture" 
        width="600" 
        style="display: block; margin: 0 auto" />

Here the view center is usually the center of the 3D model. The view size denotes the size of the 3D rending space as shown in the following figure:

<img src="../../figures/side_view.PNG" 
        alt="Picture" 
        width="600" 
        style="display: block; margin: 0 auto" />

Read this [page](https://www.mathworks.com/help/matlab/ref/view.html) for more details.

## The Free-flying Mode
- For more cinematic effects, you may use the free-flying mode
- There are 2 sub modes of the free-flying mode:

### The body-fixed mode

<img src="../../figures/circular_arc_trajectory.gif" 
        alt="Picture" 
        width="600" 
        style="display: block; margin: 0 auto" />

### The horizontal-following mode

<img src="../../figures/circular_arc_trajectory_following_view.gif" 
        alt="Picture" 
        width="600" 
        style="display: block; margin: 0 auto" />


### Geometry of the free-flying mode



### Set a free-moving camera




**[Back To Table of Contents](../README.md)**