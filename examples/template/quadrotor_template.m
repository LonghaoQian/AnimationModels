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
% generate the animation of a quadrotor flying through gates
close all
clear;
addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
%% load the simulation data
% load your own simulation data. The data must contain the following:



%% load flight path results
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-40, 40],'YLim',[-40, 40],'ZLim',[-10 10], 'DataAspectRatio', [1 1 1]);
set(ax, 'YDir', 'reverse')
set(ax, 'ZDir', 'reverse')
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid(ax, 'on')
%% draw trajectory
trajectory_line = line(singleQuadControl.dataLog.groundTruth.X(:, 1), singleQuadControl.dataLog.groundTruth.X(:, 2), singleQuadControl.dataLog.groundTruth.X(:, 3), 'LineWidth', 1, 'Color', 'red');
%% draw the quadrotor and the gates
mainView = PlaceQuadSimModel(ax, singleQuadControl);
%% init camera for the main display
InitCamera(ax, 80, 'perspective');
%% define camera mode
pc = [-2.5; 0; -0.5];
pt = [0.3; 0; -0.4];
%% down sample the simulation data
idxArray = GetDownSampledIdx(0.05, singleQuadControl.dataLog.time, 1, length(singleQuadControl.dataLog.time) - 100);
%% record the gif
saveToGif = false;
filename_gif = "quadrotor_circular_trajectory.gif";
n = length(idxArray);
for i = 1 : length(idxArray)
    %% get the sampled idx
    k = idxArray(i);
    %% update the model
    Reb = reshape(singleQuadControl.dataLog.groundTruth.Reb(:, :, k)', 3, 3)';
    R = [Reb zeros(3, 1);
        zeros(1, 3), 1];
    xp = singleQuadControl.dataLog.groundTruth.X(k, 1);
    yp = singleQuadControl.dataLog.groundTruth.X(k, 2);
    zp = singleQuadControl.dataLog.groundTruth.X(k, 3);
    x = [xp, yp, zp];
    T = makehgtform('translate', x');
    set(mainView.quadObj.frame, 'Matrix', T * R);
    %% update the camera
    UpdateCameraModelFixed(ax, x, pc, pt, Reb, 'NED');
    %% set axis
    set(ax, 'XLim',[-30 + xp, 30 + xp]);
    set(ax, 'YLim',[-30 + yp, 30 + yp]);
    set(ax, 'ZLim',[-10 + zp, 10 + zp]);
    %% update the plot and generate the gif
    drawnow % visually update the window on every iteration
    if saveToGif
        % temp = pathsim.time(i + 1) - pathsim.time(i);
        frame = getframe(anim_fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if i == 1
            imwrite(imind,cm,filename_gif,'gif', 'Loopcount',inf, 'DelayTime', 0.1 );
        else
            imwrite(imind,cm,filename_gif,'gif','WriteMode','append', 'DelayTime', 0.1);
        end  
    end
   
end