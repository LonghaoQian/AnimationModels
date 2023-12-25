% create rectangular gate
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
% create rectangular gate with a logo
% parameters:
% width: width of the gate
% height: height of the gate
% totalLength: length of the gate
% color: color the of the gate
% pathTofigure: the path to the figure picture
% logo Yaw: the heading angle of the logo in the gate frame
% mainAxis: parent axis
function gateObj = CreateRectangularGateWithLogo(width, height, sideMargin, totalLength, color, pathTofigure, logoYaw, mainAxis)
    % create gate obj
    gateObj = CreateRectangularGate(width, height, sideMargin, totalLength, color, mainAxis);
    % add logo
    gateObj.logoObj = CreateLogo(height/1.5, pathTofigure, logoYaw, gateObj.frame);
    % translate to top
    T = makehgtform('translate',[0, 0, height/2 + height/3]);
    set(gateObj.logoObj.frame, 'Matrix', T);
end