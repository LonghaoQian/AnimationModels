% generate a quadrotor drone model
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
% x: forward, y: starboard, z: downwards
% sizeFactor: the length of the arm i
% rotorRadius: the normalized rotor radius assuming length of the arm is 1
% varargin: frameType: ENU and NED. Default is ENU
function quadObj = CreateQuadRotor(sizeFactor, rotorRadius, mainAxis, varargin)
    if (length(varargin)) > 1
        error("To many input variables!")
    end
    
    frameType = 'ENU'; % default value is ENU
    if length(varargin) == 1
        frameType = varargin{1};
    end
   
    quadObj.frame = hgtransform('Parent', mainAxis);
    quadObj.frame_model = hgtransform('Parent', quadObj.frame);
    
    switch frameType
        case 'NED'
            % if NED, the plane model should rotate around x axis for 180
            % degress from the plane reference frame
            set(quadObj.frame_model, 'Matrix', makehgtform('xrotate',pi));
        case 'ENU'
        otherwise
            error(["error option ", frameType, ", the valid frameType options are 'ENU' and 'END'!"]) 
    end

    % calculate the dimension of the drone
    L = sizeFactor; % m, arm length
    wd = 0.1 * L; % m, arm width 
    th = 0.05 * L; % m, arm thickness 

    r_rotor = rotorRadius; % rotor radius 

    % matrix of vertices for the quadcopter & payload geometry
    vertices_front = [0.5*sqrt(2)*(wd), 0, 0;                           % 1
                      0.5*sqrt(2)*(L + wd/2), 0.5*sqrt(2)*(L - wd/2), 0;    % 2
                      0.5*sqrt(2)*(L - wd/2), 0.5*sqrt(2)*(L + wd/2), 0;    % 3
                      0, 0.5*sqrt(2)*(wd), 0;                           % 4
                      -0.5*sqrt(2)*(L - wd/2), 0.5*sqrt(2)*(L + wd/2), 0;   % 5
                      -0.5*sqrt(2)*(L + wd/2), 0.5*sqrt(2)*(L - wd/2), 0;   % 6
                      -0.5*sqrt(2)*(wd), 0, 0; % end of lower index     % 7
                      0.5*sqrt(2)*(wd), 0, th; % start of upper index   % 8
                      0.5*sqrt(2)*(L + wd/2), 0.5*sqrt(2)*(L - wd/2), th;   % 9
                      0.5*sqrt(2)*(L - wd/2), 0.5*sqrt(2)*(L + wd/2), th;   % 10
                      0, 0.5*sqrt(2)*(wd), th;                          % 11
                      -0.5*sqrt(2)*(L - wd/2), 0.5*sqrt(2)*(L + wd/2), th;  % 12
                      -0.5*sqrt(2)*(L + wd/2), 0.5*sqrt(2)*(L - wd/2), th;  % 13
                      -0.5*sqrt(2)*(wd), 0, th];                        % 14

    vertices_back = vertices_front * [-1 0 0; 0 -1 0; 0 0 1];

    % matrix specifying vertices to connect, and in what order, to make faces
    faces_front = [1,2,9,8;
                   2,3,10,9;
                   3,4,11,10;
                   4,5,12,11;
                   5,6,13,12;
                   6,7,14,13;
                   1,2,3,4,;
                   8,9,10,11;
                   4,5,6,7;
                   11,12,13,14;
                   1,4,7,1;
                   8,11,14,8];

    faces_back = faces_front;

    % define rotor dynamics
    N_rotor = 30;
    theta1 = linspace(0, 2 * pi, N_rotor);
    rotorPos = zeros(N_rotor, 3);
    for i = 1 : N_rotor
        rotorPos(i, 1) = r_rotor * cos(theta1(i));
        rotorPos(i, 2) = r_rotor * sin(theta1(i));
        rotorPos(i, 3) = 1.2 * th;
    end

    % position of rotors
    rotorDispalce = [
        sqrt(2)* L / 2, sqrt(2)* L / 2, 0;
        sqrt(2)* L / 2, - sqrt(2)* L / 2, 0;
        - sqrt(2)* L / 2, sqrt(2)* L / 2, 0;
        - sqrt(2)* L / 2, - sqrt(2)* L / 2, 0;
    ];
    
    for i = 1 : 4
        quadObj.armFrame(i) = hgtransform('Parent', quadObj.frame_model);
        T = makehgtform('translate', rotorDispalce(i, :));
        set(quadObj.armFrame(i), 'Matrix', T);
        quadObj.rotor(i) = patch('Faces',1 : 1 : N_rotor ,'Vertices', rotorPos, 'FaceColor', 'blue', 'facealpha',0.3, 'Parent', quadObj.armFrame(i));
    end
    quadObj.fuselage.faces_front = patch('Faces', faces_front, 'Vertices', vertices_front, 'FaceColor', 'blue', 'Parent', quadObj.frame_model);
    quadObj.fuselage.faces_back = patch('Faces', faces_back, 'Vertices', vertices_back, 'FaceColor', 'red', 'Parent', quadObj.frame_model);
    
    % define body
    % head
    quadObj.head = CreateBox(0.25 * L, 0.3 * L, 0.2 * L, 'green', quadObj.frame_model);
    T = makehgtform('translate', [0.25 * L, 0, 0.15 * L]);
    set(quadObj.head.frame, 'Matrix', T);
    % body
    quadObj.body = CreateBox(0.6 * L, 0.35 * L, 0.17 * L, 'blue', quadObj.frame_model);
    T = makehgtform('translate', [-0.15 * L, 0, 0.075 * L]);
    set(quadObj.body.frame, 'Matrix', T);
    
end