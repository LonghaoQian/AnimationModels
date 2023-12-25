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
% create rectangular gate
% parameters:
% width: width of the gate
% height: height of the gate
% totalLength: length of the gate
% color: color the of the gate
% mainAxis: parent axis
function gateObj = CreateRectangularGate(width, height, sideMargin, totalLength, color, mainAxis)
    gateObj.frame = hgtransform('Parent', mainAxis);
    gateObj.modelFrame = hgtransform('Parent', gateObj.frame);
    
    % front vertices
    Xf = totalLength/2;
    Xb = - Xf;
    Yinner = [-width/2, width/2, width/2, -width/2];
    Zinner = [-height/2,  -height/2, height/2, height/2];
    Youter = [-width/2-sideMargin, width/2+sideMargin, width/2+sideMargin, -width/2-sideMargin];
    Zouter = [-height/2-sideMargin, -height/2-sideMargin, height/2+sideMargin, height/2+sideMargin];
    
    vf = zeros(11, 3);
    for i = 1 : 4
        vf(i, :) = [Xf Youter(i) Zouter(i)];
    end
    vf(5, :) = [Xf Youter(1) Zouter(1)];
    vf(6, :) = [Xf Yinner(1) Zinner(1)];
    vf(7, :) = [Xf Yinner(4) Zinner(4)];
    vf(8, :) = [Xf Yinner(3) Zinner(3)];
    vf(9, :) = [Xf Yinner(2) Zinner(2)];
    vf(10, :) = [Xf Yinner(1) Zinner(1)];
    vf(11, :) = [Xf Youter(1) Zouter(1)];
    
    vb = vf;
    for i = 1 : 11
        vb(i, 1) = Xb;
    end
    gateObj.front = patch('Faces', 1:1:11,...
                          'Vertices', vf, 'FaceColor', color, 'Parent', gateObj.modelFrame);
    gateObj.back = patch('Faces', 1:1:11,...
                          'Vertices', vb, 'FaceColor', color, 'Parent', gateObj.modelFrame);

    v = [vf; vb];
    vertices = zeros(4, 4);
    vertices(1, :) = [1, 2, 13, 12];
    vertices(2, :) = [2, 3, 11 + 3, 11 + 2];
    vertices(3, :) = [3, 4, 11 + 4, 11 + 3];
    vertices(4, :) = [4, 1, 11 + 1, 11 + 4];
    for i = 1 : 4
       gateObj.outer(i) = patch('Faces', vertices(i, :),...
                           'Vertices', v, 'FaceColor', color, 'Parent', gateObj.modelFrame);
    end
    vertices(1, :) = [6, 9, 11 + 9, 11 + 6];
    vertices(2, :) = [9, 8, 11 + 8, 11 + 9];
    vertices(3, :) = [8, 7, 11 + 7, 11 + 8];
    vertices(4, :) = [7, 6, 11 + 6, 11 + 7];
    for i = 1 : 4
       gateObj.inner(i) = patch('Faces', vertices(i, :),...
                           'Vertices', v, 'FaceColor', color, 'Parent', gateObj.modelFrame);
    end

end