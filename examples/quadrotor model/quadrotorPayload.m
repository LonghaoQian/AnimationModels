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
% generate the animation of a quadrotor with a slung payload
close all
clear;
%% load the simulation data
load("quadPayloadData.mat");
addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
%% load flight path results
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-4, 4],'YLim',[-4, 4],'ZLim',[-3 3], 'DataAspectRatio', [1 1 1]);
% if in NED mode, reverse the plot
set(ax, 'YDir', 'reverse')
set(ax, 'ZDir', 'reverse')
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid(ax, 'on')
t1 = title(ax, 't = 0s');
%% draw trajectory
trajectory_quad = line(quadPayloadData.X(:, 1), quadPayloadData.X(:, 2), quadPayloadData.X(:, 3), 'LineWidth', 1, 'color', 'red');
trajectory_payload = line(quadPayloadData.PX(:, 1), quadPayloadData.PX(:, 2), quadPayloadData.PX(:, 3), 'LineWidth', 1, 'color', 'blue');
%% draw the quadrotor and the gates
quadObj = CreateQuadRotor(0.25, 0.1, ax, 'NED');
%% draw the payload
payloadObj = CreateSphere(0.1, 10, 'cyan', ax);
%% draw the cable
trajectory_cable = line([quadPayloadData.X(1, 1)  quadPayloadData.PX(1, 1)],...
                           [quadPayloadData.X(1, 2) quadPayloadData.PX(1, 2)],...
                           [quadPayloadData.X(1, 3) quadPayloadData.PX(1, 3)], 'LineWidth', 2, 'color', 'black');
%% record the gif
saveToGif = false;
filename_gif = "quadrotor_payload.gif";
frameRate = 20;
%% down sample the simulation data
idxArray = GetDownSampledIdx(1/frameRate, quadPayloadData.time, 1, 1500);
n = length(idxArray);
for i = 1 : length(idxArray)
    %% get the sampled idx
    k = idxArray(i);
    %% update the model
    Reb = reshape(quadPayloadData.RIB(:, :, k), 3, 3);
    R = [Reb zeros(3, 1);
        zeros(1, 3), 1];
    xp = quadPayloadData.X(k, 1);
    yp = quadPayloadData.X(k, 2);
    zp = quadPayloadData.X(k, 3);
    x = [xp, yp, zp];
    T = makehgtform('translate', x');
    set(quadObj.frame, 'Matrix', T * R);
    set(payloadObj.frame, 'Matrix', makehgtform('translate', quadPayloadData.PX(k, :)'));
    %% update the cable position
    set(trajectory_cable, 'XData', [quadPayloadData.X(k, 1)  quadPayloadData.PX(k, 1)],...
        'YData', [quadPayloadData.X(k, 2)  quadPayloadData.PX(k, 2)],...
        'ZData', [quadPayloadData.X(k, 3)  quadPayloadData.PX(k, 3)]);
    %% update the camera
    UpdateCameraModelSideView(ax, x + [0, 0, 0.8], [1.5, 1.5, 1.8], 3)
    %% update the title
    set(t1, 'String', ['t=', num2str(quadPayloadData.time(k), '%.2f') ,'s']);
    %% update the plot and generate the gif
    drawnow % visually update the window on every iteration
    if saveToGif
        frame = getframe(anim_fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if i == 1
            imwrite(imind,cm,filename_gif,'gif', 'Loopcount',inf, 'DelayTime', 1/frameRate);
        else
            imwrite(imind,cm,filename_gif,'gif','WriteMode','append', 'DelayTime', 1/frameRate);
        end  
    end
   
end
