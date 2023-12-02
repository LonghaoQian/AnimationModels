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
%%
load('singleQuad_ground_truth.mat')
addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
%% load flight path results
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-40, 40],'YLim',[-40, 40],'ZLim',[-10 10], 'DataAspectRatio', [1 1 1]);

%% trajectory
trajectory_line = line(singleQuadControl.dataLog.groundTruth.X(:, 1), singleQuadControl.dataLog.groundTruth.X(:, 2), singleQuadControl.dataLog.groundTruth.X(:, 3), 'LineWidth', 1, 'Color', 'red');


set(ax, 'YDir', 'reverse')
set(ax, 'ZDir', 'reverse')

xlabel('x axis, m');
ylabel('y axis, m');
zlabel('z axis, m');

grid(ax, 'on')

camva(ax, 60)
camproj(ax, 'perspective');

mainView = PlaceQuadSimModel(ax, singleQuadControl);

% mainView.quadObj = CreateQuadRotor(0.7, 0.3, ax, 'NED');
% 
% mainView.gateOj1 = CreateRroundGate(2, 0.3, 0.2, 20, 'blue' , ax);
% mainView.gateOj2 = CreateRroundGate(2, 0.3, 0.2, 20, 'red' , ax);
% mainView.gateOj3 = CreateRroundGate(2, 0.3, 0.2, 20, 'green' , ax);
% mainView.gateOj4 = CreateRroundGate(2, 0.3, 0.2, 20, 'cyan' , ax);
% 
% set(mainView.gateOj1.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [0; 10; 0]))
% set(mainView.gateOj2.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [0; -10; 0]))
% 
% set(mainView.gateOj3.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [-10; 0; 0]) * makehgtform('zrotate',pi/2))
% set(mainView.gateOj4.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [10; 0; 0]) * makehgtform('zrotate',pi/2))

%% define a simplifed hud
% simpleHud = CreateSimpleHud(1, 'green');
% ax2 = axes('Units', 'Normalized', 'Position', [0.1 0.1 0.8 0.8],...
%     'XLim',[-1, 1],...
%     'YLim',[-1, 1],...
%     'Box', 'on', ...
%     'LineWidth', 2, ...
%     'Color', 'none', 'DataAspectRatio', [1 1 1]);
% % t1 = title(ax2, ['t = 0s']);
% 
% reticle = line([-0.2, 0.2 ], [0, 0] , 'LineWidth', 2, 'Color', 'green');
% 
% ax2.XAxis.Visible = 'off';
% ax2.YAxis.Visible = 'off';

% sideView = PlaceQuadSimModel(ax2, singleQuadControl);

% sideView.quadObj = CreateQuadRotor(0.7, 0.3, ax, 'NED');
% 
% sideView.gateOj1 = CreateRroundGate(2, 0.3, 0.2, 20, 'blue' , ax);
% sideView.gateOj2 = CreateRroundGate(2, 0.3, 0.2, 20, 'red' , ax);
% sideView.gateOj3 = CreateRroundGate(2, 0.3, 0.2, 20, 'green' , ax);
% sideView.gateOj4 = CreateRroundGate(2, 0.3, 0.2, 20, 'cyan' , ax);
% 
% set(sideView.gateOj1.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [0; 10; 0]))
% set(sideView.gateOj2.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [0; -10; 0]))
% 
% set(sideView.gateOj3.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [-10; 0; 0]) * makehgtform('zrotate',pi/2))
% set(sideView.gateOj4.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [10; 0; 0]) * makehgtform('zrotate',pi/2))

%% define camera mode

pc = [-2.5; 0; -0.5];
pt = [0.3; 0; -0.4];
pup = [0; 0; -1];

drawnow

% downsample
idxArray = GetDownSampledIdx(0.05, singleQuadControl.dataLog.time, 1, length(singleQuadControl.dataLog.time) - 100);


saveToGif = true;
filename_gif = "quadrotor_circular_trajectory.gif";
for i = 1 : length(idxArray)
    k = idxArray(i);
    C21 = reshape(singleQuadControl.dataLog.groundTruth.Reb(:, :, k)', 3, 3)';
    R = [C21 zeros(3, 1);
        zeros(1, 3), 1];
    xp = singleQuadControl.dataLog.groundTruth.X(k, 1);
    yp = singleQuadControl.dataLog.groundTruth.X(k, 2);
    zp = singleQuadControl.dataLog.groundTruth.X(k, 3);
    x = [xp, yp, zp];
    T = makehgtform('translate', x');
    set(mainView.quadObj.frame, 'Matrix', T * R);
    
    pos = x + (C21 * pc)';
    target = x + (C21 * pt)';
    
    campos(ax, pos)
    camtarget(ax, target)
    
    % pup
    camup(ax, C21 * pup);
    

    % set axis
    set(ax, 'XLim',[-30 + xp, 30 + xp]);
    set(ax, 'YLim',[-30 + yp, 30 + yp]);
    set(ax, 'ZLim',[-10 + zp, 10 + zp]);
    % set(t1, 'String', ['t=', num2str(singleQuadControl.dataLog.time(k), '%.2f') ,'s']);
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