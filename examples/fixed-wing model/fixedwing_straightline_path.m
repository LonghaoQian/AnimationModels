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
%% load parameters
load('flightSimResults_straightline.mat')
addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
%% create figure
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-400 400],'YLim',[-400 400],'ZLim',[0 150], 'DataAspectRatio', [1 1 1]);
%% trajectory
reference_line = line(pathsim.reference.yunit, pathsim.reference.xunit, - pathsim.reference.height * ones(size(pathsim.reference.xunit)), 'LineWidth', 2, 'Color', [0 0 1]);
trajectory_line = line(pathsim.Xe(:, 1), pathsim.Xe(:, 2), pathsim.Xe(:, 3), 'LineWidth', 1, 'Color', 'red');
% create the plane model
planeObj = CreatePlane(2, ax, 'NED');
set(ax, 'YDir', 'reverse')
set(ax, 'ZDir', 'reverse')
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid on
axis equal;
%% init camera for the main display
InitCamera(ax, 80, 'perspective');
% define the camera position
pc = [-3.5; 0; -2];
pt = [20; 0; -2];
%% create a minin map
ax2 = axes('Units', 'Normalized', 'Position',[0.7 0.15 0.3 0.75],...
'Box', 'on', ...
'LineWidth', 2, ...
'Color', [1, 1, 1], 'DataAspectRatio', [1 1 1]);

reference_line2 = line(pathsim.reference.yunit, pathsim.reference.xunit, - pathsim.reference.height * ones(size(pathsim.reference.xunit)),...
    'LineWidth', 2, 'Color', [0 0 1], 'Parent', ax2);
trajectory_line2 = line(pathsim.Xe(:, 1), pathsim.Xe(:, 2), pathsim.Xe(:, 3),...
    'LineWidth', 1, 'Color', 'red', 'Parent', ax2);
t1 = title(ax2, ['t = 0s']);
set(ax2, 'XLim',[-100, 100]);
set(ax2, 'YLim',[-20, 600]);
set(ax2, 'YDir', 'reverse')
set(ax2, 'ZDir', 'reverse')
planeObj2 = CreatePlane(15, ax2, 'NED');
grid(ax2, 'on')
xlabel(ax2, 'x(m)')
ylabel(ax2, 'y(m)')
%% define hud
simpleHud = CreateSimpleHud(1, 'green', 13, 90/10, 30, 'none');
%% down sample the data points
startIdx = 20;
endIdx = 3200;
deltaT = 0.1;
idxArray = GetDownSampledIdx(deltaT, pathsim.time, startIdx, endIdx);
%% update the gif
saveToGif = false; % set this to true if you need to save the gif
filename_gif = "straightline_simulation.gif";
n = length(idxArray);
for i = 1 : n
    k = idxArray(i);
    %% update the model
    Reb = reshape(pathsim.Rbe(:, :, k), 3, 3)';
    R = [Reb zeros(3, 1);
        zeros(1, 3), 1];
    T = makehgtform('translate',[pathsim.Xe(k, 1) ,pathsim.Xe(k, 2), pathsim.Xe(k, 3)]);
    set(planeObj.frame, 'Matrix', T * R);
    set(planeObj2.frame, 'Matrix', T * R);
    %% update the camera
    UpdateCameraModelFixed(ax, pathsim.Xe(k, :), pc, pt, Reb, 'NED');
    %% update the hud
    UpdateSimpleHud(simpleHud, pathsim.attitude(k, 1), pathsim.attitude(k, 2), pathsim.attitude(k, 3), -pathsim.Xe(k, 3), pathsim.TAS(k));
    %% update rendering aera
    set(ax, 'XLim',[-300 + pathsim.Xe(k, 1), 300 + pathsim.Xe(k, 1)]);
    set(ax, 'YLim',[-300 + pathsim.Xe(k, 2), 300 + pathsim.Xe(k, 2)]);
    set(ax, 'ZLim',[-50 + pathsim.Xe(k, 3), 50 + pathsim.Xe(k, 3)]);
    set(t1, 'String', ['t=', num2str(pathsim.time(k), '%.2f') ,'s']);
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

