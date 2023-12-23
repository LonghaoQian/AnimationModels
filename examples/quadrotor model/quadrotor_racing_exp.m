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
load("racing_experiment_05.mat");
addpath('../../src/models')
addpath('../../src/utils')
addpath('../../src/camera')
addpath('../../src/hud')
tas = sqrt(flightData.vel(:, 1).^2 + flightData.vel(:, 2).^2  + flightData.vel(:, 3).^2);
%% load flight path results
anim_fig = figure('Units', 'normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
ax = axes('Position',[0.1 0.1 0.8 0.8],  'XLim',[-4, 4],'YLim',[-4, 4],'ZLim',[-3 3], 'DataAspectRatio', [1 1 1]);
xlabel(ax, 'x axis, m');
ylabel(ax, 'y axis, m');
zlabel(ax, 'z axis, m');
grid(ax, 'on')
%% draw trajectory
trajectory_line = line(flightData.pos(:, 1), flightData.pos(:, 2), flightData.pos(:, 3), 'LineWidth', 1, 'Color', 'red');
%% draw ground
c = 8;
[Xc, Yc, Zc] = meshgrid(-c/2:0.3:c/2, -c/2:0.3:c/2, 0:0); 
txi = imread('ground.jpg'); 
ground = surface(Xc, Yc, Zc, txi, 'FaceColor','texture','EdgeColor','none', 'Parent', ax);
%% draw the quadrotor and the gates
quadObj = CreateQuadRotor(0.125, 0.05, ax, 'ENU');
%% add gates
flightData.gate(2).rpy = [17.62, -89.97, 180-40.84];
for i = 1 : 5
    % gate(i) = CreateRectangularGate(flightData.gate(i).width, flightData.gate(i).height, 0.05, 0.02, 'blue', ax);
    gate(i) = CreateRectangularGateWithLogo(flightData.gate(i).width, flightData.gate(i).height, 0.05, 0.02, 'blue', 'fsclogo.png', pi, ax);
    R1 = GenerateHgRotation([0, pi/2, 0], 'euler', "ENU");
    R = GenerateHgRotation([flightData.gate(i).rpy(1), flightData.gate(i).rpy(2), flightData.gate(i).rpy(3)]/57.3, 'euler', "ENU");
    T = makehgtform('translate',[flightData.gate(i).pos(1), flightData.gate(i).pos(2), flightData.gate(i).pos(3)]);
    set(gate(i).frame, 'Matrix', T * R * R1);
end
%% init camera for the main display
InitCamera(ax, 80, 'perspective');
%% define camera mode
pc = [-0.4; 0; 0.05];
pt = [0.3; 0; 0.2];
%% define a mini map
ax2 = axes('Units', 'Normalized', 'Position',[0.1 0.1 0.2 0.55],...
'Box', 'on', ...
'LineWidth', 2, ...
'Color', [1, 1, 1], 'DataAspectRatio', [1 1 1]);
t1 = title(ax2, ['t = 0s']);
trajectory_line2 = line(flightData.pos(:, 1), flightData.pos(:, 2), flightData.pos(:, 3),...
    'LineWidth', 1, 'Color', 'red', 'Parent', ax2);

set(ax2, 'XLim',[-7, 12]);
set(ax2, 'YLim',[-10, 10]);
quadObj2 = CreateQuadRotor(0.125, 0.05, ax2, 'ENU');
for i = 1 : 5
    gate2(i) = CreateRectangularGate(flightData.gate(i).width, flightData.gate(i).height, 0.05, 0.02, 'blue', ax2);
    R1 = GenerateHgRotation([0, -pi/2, 0], 'euler', "ENU");
    R = GenerateHgRotation([flightData.gate(i).rpy(1), flightData.gate(i).rpy(2), flightData.gate(i).rpy(3)]/57.3, 'euler', "ENU");
    T = makehgtform('translate',[flightData.gate(i).pos(1), flightData.gate(i).pos(2), flightData.gate(i).pos(3)]);
    set(gate2(i).frame, 'Matrix', T * R * R1);
end
xlabel(ax2, 'x(m)')
ylabel(ax2, 'y(m)')
grid(ax2, 'on')
%% setup video recording
saveToVideo = false;
FrameRate = 30;
if saveToVideo
    vidObj = VideoWriter('racing_trjectory_05.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = FrameRate;
    open(vidObj);
end
deltaT = 1/FrameRate;
startFrame = 2800;
idxArray = GetDownSampledIdx(deltaT, flightData.time, startFrame, length(flightData.time) - 1000);
n = length(idxArray);
for i = 1 : n
    %% get the sampled idx
    k = idxArray(i);
    %% update the model
    RIB = Quad2Mat(flightData.quat(k, :)); % Reb
    R = [RIB zeros(3, 1);
         zeros(1, 3), 1];
    X = [flightData.pos(k, 1), flightData.pos(k, 2), flightData.pos(k, 3)];
    T = makehgtform('translate', X);
    set(quadObj.frame, 'Matrix', T * R);
    set(quadObj2.frame, 'Matrix', T * R);
    %% update the camera
    UpdateCameraModelFixed(ax, X, pc, pt, RIB, 'ENU');
    %% set axis
    Set3dRenderSpace(ax, X, [20 20 10])
    set(t1, 'String', ['t=', num2str(flightData.time(k), '%.2f') ,'s']);
    %% update the plot and generate the gif
    drawnow % flush all pending commands
    if saveToVideo
        writeVideo(vidObj, getframe(anim_fig));
    end
end
if saveToVideo
    close(vidObj);
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