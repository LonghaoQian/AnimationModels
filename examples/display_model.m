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
close all
clear;
addpath('../src/models')
addpath('../src/utils')
addpath('../src/camera')
addpath('../src/hud')
%% fixed-wing model
planeModel = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-400 400],'YLim',[-400 400],'ZLim',[0 150], 'DataAspectRatio', [1 1 1]);
planeObj = CreatePlane(2, ax, 'NED');
set(ax, 'YDir', 'reverse')
set(ax, 'ZDir', 'reverse')
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid on
UpdateCameraModelSideView(ax, [0;0;0], [3 3 3], 3);
drawnow
%% quadrotor model
quadrotorModel = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax2 = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-400 400],'YLim',[-400 400],'ZLim',[0 150], 'DataAspectRatio', [1 1 1]);
quadObj = CreateQuadRotor(0.7, 0.3, ax2, 'ENU');
xlabel(ax2, 'x axis, m');
ylabel(ax2, 'y axis, m');
zlabel(ax2, 'z axis, m');
grid on
UpdateCameraModelSideView(ax2, [0;0;0], [1 1 1], 3);
drawnow
%% vtol
vtolModel = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax3 = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-400 400],'YLim',[-400 400],'ZLim',[0 150], 'DataAspectRatio', [1 1 1]);
vtolObj = CreateTwingEngineVtol(2, ax3, 'NED');
%% invert the Y and Z axis to properly display NED frame
set(ax3, 'YDir', 'reverse')
set(ax3, 'ZDir', 'reverse')
xlabel(ax3, 'x axis, m');
ylabel(ax3, 'y axis, m');
zlabel(ax3, 'z axis, m');
grid on
UpdateCameraModelSideView(ax3, [0;0;0], [4 4 3], 3);

%% gate
gateModel = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax4 = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-400 400],'YLim',[-400 400],'ZLim',[0 150], 'DataAspectRatio', [1 1 1]);
CreateRroundGate(2, 0.3, 0.2, 20, 'blue' , ax4);
xlabel(ax4, 'x axis, m');
ylabel(ax4, 'y axis, m');
zlabel(ax4, 'z axis, m');
grid on
UpdateCameraModelSideView(ax4, [0;0;0], [4 4 3], 3);
