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
%% load the simulation data
Tbl = readtable("res_race_t_n19.csv");

time = Tbl.t;
x = Tbl.p_x;
y = Tbl.p_y;
z = Tbl.p_z;

addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
%% load flight path results
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-40, 40],'YLim',[-40, 40],'ZLim',[-10 10], 'DataAspectRatio', [1 1 1]);
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid(ax, 'on')
%% draw trajectory
trajectory_line = line(x, y, z, 'LineWidth', 1, 'Color', 'red');
%% draw the quadrotor and the gates
quadObj = CreateQuadRotor(0.7, 0.3, ax, 'ENU');
%% init camera for the main display
InitCamera(ax, 80, 'perspective');
%% define camera mode
pc = [-3; 0; 0.5];
pt = [0.3; 0; -0.4];
%% define a mini map
ax2 = axes('Units', 'Normalized', 'Position',[0.75 0.1 0.2 0.55],...
'Box', 'on', ...
'LineWidth', 2, ...
'Color', [1, 1, 1], 'DataAspectRatio', [1 1 1]);
t1 = title(ax2, ['t = 0s']);
trajectory_line2 = line(x, y, z,...
    'LineWidth', 1, 'Color', 'red', 'Parent', ax2);

set(ax2, 'XLim',[-7, 12]);
set(ax2, 'YLim',[-10, 10]);
quadObj2 = CreateQuadRotor(0.7, 0.3, ax2, 'ENU');
xlabel(ax2, 'x(m)')
ylabel(ax2, 'y(m)')
grid(ax2, 'on')
%% record the gif
saveToGif = false;
filename_gif = "quadrotor_complicated_trjectory.gif";
n = length(x);
for i = 1 : n
    %% update the model
    q = [Tbl.q_w(i) Tbl.q_x(i) Tbl.q_y(i) Tbl.q_z(i)];
    RIB = Quad2Mat(q); % Reb
    R = [RIB zeros(3, 1);
         zeros(1, 3), 1];
    X = [x(i), y(i), z(i)];
    T = makehgtform('translate', X);
    set(quadObj.frame, 'Matrix', T * R);
    set(quadObj2.frame, 'Matrix', T * R);
    %% update the camera
    UpdateCameraModelFollowing(ax, X, pc, pt, 0);
    %% set axis
    Set3dRenderSpace(ax, [x(i) y(i) z(i)], [20 20 10])
%     set(ax, 'XLim',[-30 + x(i), 30 + x(i)]);
%     set(ax, 'YLim',[-30 + y(i), 30 + y(i)]);
%     set(ax, 'ZLim',[-10 + z(i), 10 + z(i)]);
    set(t1, 'String', ['t=', num2str(time(i), '%.2f') ,'s']);
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

% quaternion to rotation matrix
% qw qx qy qz format
%    L = [-q1 q0 q3 -q2;s
%    -q2 -q3 q0 q1;
%    -q3 q2 -q1 q0]
%    R = [-q1 q0 -q3 q2;
%    -q2 q3 q0 -q1;
%    -q3 -q2 q1 q0]
%    R_IB = RL^T
function RIB = Quad2Mat(q)
    L = [-q(2) q(1) q(4) -q(3);
    -q(3) -q(4) q(1) q(2);
    -q(4) q(3) -q(2) q(1)];
    R = [-q(2) q(1) -q(4) q(3);
    -q(3) q(4) q(1) -q(2);
    -q(4) -q(3) q(2) q(1)];
    RIB = R * L';
end