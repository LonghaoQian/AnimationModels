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
% Update the 3d rendering area
% ax: referece ax
% viewCenter: a 3x1 or 1x3 vector, denotes the center of the view point
% viewSize: a 3x1 or 1x3 vector, denotes a box surrounding the view center
% the dimension of the box in x, y, and z directions are 2*viewSize(1)
% 2*viewSize(2), and 2*viewSize(3)
function Set3dRenderSpace(ax, viewCenter, viewSize)
    axisName = {'XLim', 'YLim', 'ZLim'};
    for i = 1 : 3
        set(ax, axisName{i}, [-viewSize(i) + viewCenter(i), viewSize(i) + viewCenter(i)]);
    end
end