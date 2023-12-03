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
addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
%% define the figure
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-2 3],'YLim',[-4 4],'ZLim',[-2 2], 'DataAspectRatio', [1 1 1]);
%% define the votl model
vtolObj = CreateTwingEngineVtol(2, ax, 'NED');
%% invert the Y and Z axis to properly display NED frame
set(ax, 'YDir', 'reverse')
set(ax, 'ZDir', 'reverse')
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid on
view([70, 30])
%% animation loop
drawnow
N1 = 30;
N2 = 30;
N = N1 * 2 + N2 *4;
leftEngineAngle = [linspace(0, pi/2, N1), linspace(pi/2, 0, N1), linspace(0, pi/6, N2), linspace(pi/6, 0, N2), linspace(0, -pi/6, N2), linspace(-pi/6, 0, N2)];
rightEngineAngle = [linspace(0, pi/2, N1), linspace(pi/2, 0, N1), linspace(0, -pi/6, N2), linspace(-pi/6, 0, N2), linspace(0, pi/6, N2), linspace(pi/6, 0, N2)];
%% run animation
saveToGif = false; % set this to true if you need to save the gif
filename_gif = "vtol_animate.gif";
for i = 1 : N
    UpdateEngineAngleTwinEngineVtol(vtolObj, leftEngineAngle(i), rightEngineAngle(i))
    drawnow
    %% save to gif
    if saveToGif
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
