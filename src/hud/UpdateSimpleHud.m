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
% update Simplehud according to the flight data
function UpdateSimpleHud(hudObj, roll, pitch, yaw, altitude, airspeed)
    %% update the artificial horizon
    % make sure that GenerateHgRotation has been added to the path
    hudR = GenerateHgRotation([0, 0, -roll], 'euler', "ENU");

    pitchdeg = pitch * 180 / pi;
    
    pitchDisplacement = pitchdeg / hudObj.pitchIndicator.pitchRange;
    set(hudObj.rollIndicator.frame, 'Matrix', hudR * makehgtform('translate',[0, -pitchDisplacement, 0]));
    rollDeg = roll * 57.3;
    set(hudObj.pitchIndicator.right.text,'Rotation', rollDeg);
    set(hudObj.pitchIndicator.left.text,'Rotation', rollDeg);
    set(hudObj.rollIndicator.iconFrame, 'Matrix', hudR);
    for i = 1 : hudObj.pitchIndicator.numOfPitchTicks
        set(hudObj.pitchIndicator.upper{i}.textLeft, 'Rotation', rollDeg);
        set(hudObj.pitchIndicator.upper{i}.textRight, 'Rotation', rollDeg);
        set(hudObj.pitchIndicator.lower{i}.textLeft, 'Rotation', rollDeg);
        set(hudObj.pitchIndicator.lower{i}.textRight, 'Rotation', rollDeg);
    end
    %% update the altitude and airspeed display
    set(hudObj.altitude, 'String', [num2str(floor(altitude)), ' m'])
    set(hudObj.airspeed, 'String', [num2str(floor(airspeed)), ' m/s'])
    %% update yaw indicator text
    % make sure that ConvertTo360DegConvetion has been added to the path
    set(hudObj.yawIndicator.text, 'String', num2str(round(ConvertTo360DegConvetion(yaw * 57.3))));
end