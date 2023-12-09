# Some Background of Rotations
## Syntax of Rotation Matrices

There are two reference frames: frame 1 and frame 2. The rotation matrix between frame 1 and frame 2 is defined as $R_{21}$.
This means that for the same vector $\vec{a}$, its coordinates in frame 1 and frame 2, i.e. $a_1$ and $a_2$, have the following relationship:

$$a_2=R_{21}a_1$$

where

<img src="https://latex.codecogs.com/gif.image?\inline&space;\dpi{200}\bg{white}\boldsymbol{a}_1=\begin{bmatrix}a_{1,x}\\a_{1,y}\\a_{1,z}\\\end{bmatrix},\quad\boldsymbol{a}_2=\begin{bmatrix}a_{2,x}\\a_{2,y}\\a_{2,z}\\\end{bmatrix}
" 
        alt="Picture" 
        width="210" 
        style="display: block; margin: 0 auto" />

as shown in the following figure

<img src="../../figures/coordinate_transformation.png" 
        alt="Picture" 
        width="500" 
        style="display: block; margin: 0 auto" />



## Euler angles and the corresponding rotation matrix

The rotation of reference frames can be achived by using the euler angles around principle axis. In avaiation, we use $\phi$, $\theta$, $\psi$ to denote the roll, pitch, and yaw angle representing the rotation around the x, y, and z axis. If frame 1 is the stationary frame, and frame 2 rotates w.r.t. frame 1 by an Euler angle, then the rotation matrix between frame 1 and 2 are as follows:

<img src="../../figures/matrix_from_euler.gif" 
        alt="Picture" 
        width="900" 
        style="display: block; margin: 0 auto" />

This package provides the code in the [utils folder](../../src/utils/) to generate rotation matrix around principle axis:

```
\src\utils\util_rotationX.m
\src\utils\util_rotationY.m
\src\utils\util_rotationZ.m
```

# Coordniate Frames
## The ENU (east-north-up frame) and the NED (north-east-down frame)
- There are two major frames usined in aviation: the ENU frame and the NED frame, as shown in the following figure

<img src="../../figures/enu_ned.PNG" 
        alt="Picture" 
        width="600" 
        style="display: block; margin: 0 auto" />

- You may read this [page](https://en.wikipedia.org/wiki/Axes_conventions#:~:text=World%20reference%20frames%3A%20ENU%20and%20NED,-Main%20article%3A%20Local&text=Basically%2C%20as%20lab%20frame%20or,NED) for detailed explainations.

- The rotation matrix between the END frame (frame E) and the NED frame (frame N) is

<img src="../../figures/ned2enu.gif" 
        alt="Picture" 
        width="150" 
        style="display: block; margin: 0 auto" />


**[Back To Table of Contents](../README.md)**