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
% generate the animation of a racing drone 
close all
clear;
addpath('../../src/models')
addpath('../../src/utils')
%% load flight path results
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-4, 4],'YLim',[-4, 4],'ZLim',[-3 3], 'DataAspectRatio', [1 1 1]);
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid(ax, 'on')

sphereObj = CreateSphere(2, 30, 'cyan', ax);
txi = imread('earth_1.jpg');
% override color properties
set(sphereObj.obj, 'EdgeColor','none')
set(sphereObj.obj, 'FaceColor','texture')
set(sphereObj.obj, 'CData', flipud(txi))