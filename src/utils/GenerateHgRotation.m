% generate roation matrix based on Euler angles, quaternions, and rotation matrix
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
% input(1): roll, input(2): pitch, input(3): yaw
% flag: 'euler'
% frameType: 'ENU':  'NED':
function R = GenerateHgRotation(input, flag, varargin)
    if (length(varargin)) > 1
        error("To many input variables!")
    end
    frameType = 'NED'; % default value is ENU
    if length(varargin) == 1
        frameType = varargin{1};
    end
    % convert input to euler angles in NED frame
    switch flag
        case 'euler'
            ax = input(1);
            ay = input(2);
            az = input(3);
        case 'quaternions'
            % TO DO: quaternion to euler
            ax = 0;
            ay = 0;
            az = 0;
        case 'rotation matrix'
            % TO DO: rotation matrix to euler
            ax = 0;
            ay = 0;
            az = 0;
        otherwise
            error(["error option ", flag, ", the valid flag options are 'euler', 'quaternions', and 'rotation matrix'!"])
    end

    switch frameType
        case 'ENU'
            % for ENU frames, the y and z axis are inverted
            ay = -ay;
            az = -az;
        case 'NED'
        otherwise
           error(["error option ", frameType, ", the valid frameType options are 'ENU' and 'END'!"]) 
    end
    % the hgtform transformation is based on the absolute frame.
    % therefore, the order of rotation is reversed to the normal order 
    Rx = makehgtform('xrotate', ax);
    Ry = makehgtform('yrotate', ay);
    Rz = makehgtform('zrotate', az);
    R = Rz * Ry * Rx;





