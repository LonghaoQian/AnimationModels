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
% generate a fixed-wing drone model
% x: forward, y: starboard, z: downwards
% sizeFactor: the length of the drone
% varargin: frameType: ENU and NED. Default is ENU
function planeObj = CreatePlane(sizeFactor, mainAxis, varargin)
    if (length(varargin)) > 1
        error("To many input variables!")
    end
    
    frameType = 'ENU'; % default value is ENU
    if length(varargin) == 1
        frameType = varargin{1};
    end

    % calculate the dimension of the airplane
    L = sizeFactor; % the total length is the size factor
    r = L * 0.1; % radius of the fuselage
    Lc = L * 0.3; % cone length of the head and the back of the fuselage
    
    b = 1.8 * L; % wing span
    c = 0.18 * b; % wing chord
    
    planeObj.frame = hgtransform('Parent', mainAxis);
    planeObj.frame_model = hgtransform('Parent', planeObj.frame);
    planeObj.para.wingspan = b;
    planeObj.para.wingchord = c;
    planeObj.para.wingheight = r;
    planeObj.para.wingPos = [0;0;r];
    
    switch frameType
        case 'NED'
            % if NED, the plane model should rotate around x axis for 180
            % degress from the plane reference frame
            set(planeObj.frame_model, 'Matrix', makehgtform('xrotate',pi));
        case 'ENU'
        otherwise
            error(["error option ", frameType, ", the valid frameType options are 'ENU' and 'END'!"]) 
    end
    
    % the frame of the 3d model
    planeObj.modelHeadFrame = hgtransform('Parent', planeObj.frame_model);
    planeObj.modelMiddleFrame = hgtransform('Parent', planeObj.frame_model);
    planeObj.modelBackFrame = hgtransform('Parent', planeObj.frame_model);
    
    % create fueslage
    [Xc, Yc, Zc]= cylinder([r 0], 15);
    % first, rotate 90 deg
    R = makehgtform('yrotate', pi/2); 
    % then translate
    T = makehgtform('translate',[L/2 ,0, 0]);
    
    planeObj.body.head = surface(Xc, Yc, Lc * Zc, 'Parent', planeObj.modelHeadFrame, 'FaceColor', 'cyan');
    set(planeObj.modelHeadFrame, 'Matrix', T * R);
    
    [Xb, Yb, Zb]= cylinder(r, 15);
    planeObj.body.middle = surface(Xb, Yb, L * Zb, 'Parent', planeObj.modelMiddleFrame, 'FaceColor', 'cyan');

    T = makehgtform('translate',[- L/2 ,0, 0]);
    set(planeObj.modelMiddleFrame, 'Matrix', T * R);
    
    planeObj.body.back = surface(Xc, Yc, Lc * Zc, 'Parent', planeObj.modelBackFrame, 'FaceColor', 'cyan');
    R = makehgtform('yrotate', -pi/2); 
    T = makehgtform('translate',[-L/2 ,0, 0]);
    set(planeObj.modelBackFrame, 'Matrix', T * R);
    
    % define the wing    
    planeObj.wing = patch('Faces', [1 2 3 4]...
        , 'Vertices', [c/2, b/2, r; -c/2, b/2, r; -c/2, -b/2, r; c/2, -b/2, r], 'FaceColor', 'cyan', 'Parent', planeObj.frame_model);
    
    % define the vertical tail
    planeObj.vertical = patch('Faces', [1 2 3 4]...
        , 'Vertices', [- L/2 , 0, 0; -c/2 - L/2, 0, b/5; -c - L/2, 0, b/5; -c - L/2, 0, 0], 'FaceColor', 'cyan', 'Parent', planeObj.frame_model);

    % define the horizontal tail
    planeObj.horizontalTail = patch('Faces', [1 2 3 4]...
        , 'Vertices', [-c/2 - L/2, b/5, b/5; -c - L/2, b/5, b/5; -c - L/2, -b/5, b/5; -c/2 - L/2, -b/5, b/5], 'FaceColor', 'cyan', 'Parent', planeObj.frame_model);
    
end


