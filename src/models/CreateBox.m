% generate a 3d box with patches
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

function boxObj = CreateBox(length_, width_, height_, color_, mainAxis)
    boxObj.frame = hgtransform('Parent', mainAxis);
    xp = length_/2;
    yp = width_/2;
    zp = height_/2;
    vertices = [xp, yp, zp;
                xp, -yp, zp;
                xp, -yp, -zp;
                xp, yp, -zp;
                -xp, yp, zp;
                -xp, -yp, zp;
                -xp, -yp, -zp;
                -xp, yp, -zp;];

    faces = [1, 2, 3, 4;
             5, 6, 7, 8;
             1, 4, 8, 5;
             2, 3, 7, 6;
             1, 2, 6, 5;
             4, 3, 7, 8];
    
    boxObj.model = patch('Faces', faces, 'Vertices', vertices, 'FaceColor', color_, 'Parent', boxObj.frame);
end