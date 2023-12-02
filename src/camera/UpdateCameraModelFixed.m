% ------------------------------------------------------------------------------
% MIT License
% 
% Copyright (c) 2023 Dr. Longhao Qian
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
% ------------------------------------------------------------------------------
% Update the free-moving camera in model-fixed mode
% ax: referece ax
% Xe: vehicle coordinate in the global frame
% position: position of the camera focal point relative to the center of
% the vehicle
% target: the point at which the camera is pointing relative to the center of
% vehicle
% Reb: the rotation matrix of the vehicle. From the body-fixed frame to the
% global frame
function UpdateCameraModelFixed(ax, Xe, position, target, Reb)
%% update camera position and target location
    campos(ax, Xe + (Reb *  position)')
    camtarget(ax, Xe + (Reb * target)')
%% update the z axis of the camera
    camup(ax, Reb * [0; 0; -1]);
end