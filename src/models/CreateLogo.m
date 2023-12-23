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
% create logo from picture
% parameters:
% sizeFactor: size along the x axis of the logo
% pathTofigure: patch to the logo picture
% logoHeading: the yaw angle of the logo in its local frame
% mainAxis: parent axis of the logo object
function logoObj = CreateLogo(sizeFactor, pathTofigure, logoHeading, mainAxis)
    logoObj.frame = hgtransform('Parent', mainAxis);
    logoObj.modelFrame = hgtransform('Parent', logoObj.frame);
    txi = imread(pathTofigure);
    [h, w, ~] = size(txi);
    a = h/w;
    n = 10;
    gridSize = linspace(-sizeFactor/2, sizeFactor/2, n);
    [Xc, Yc, Zc] = meshgrid(gridSize, a *gridSize, 0:0); 
    logoObj.logo = surface(Xc, Yc, Zc, txi, 'FaceColor','texture','EdgeColor', 'none', 'Parent', logoObj.modelFrame);
    set(logoObj.modelFrame, 'Matrix', makehgtform('zrotate', logoHeading) * makehgtform('yrotate',pi/2) * makehgtform('zrotate',-pi/2));
end