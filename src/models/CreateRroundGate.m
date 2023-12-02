% create round gate
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

function gateObj = CreateRroundGate(innerRingRadius, marginWidth, totalLength, numOfvertics, color, mainAxis)

    gateObj.frame = hgtransform('Parent', mainAxis);
    gateObj.modelFrame = hgtransform('Parent', gateObj.frame);
    
    set(gateObj.modelFrame, 'Matrix', makehgtform('yrotate',pi/2));

    % inner ring
    [Xi, Yi, Zi]= cylinder(innerRingRadius, numOfvertics);
    gateObj.model.innerRing = surf(Xi, Yi, totalLength * Zi, 'Parent', gateObj.modelFrame, 'FaceColor', color);
    % outer ring
    [Xo, Yo, Zo]= cylinder(innerRingRadius +  marginWidth, numOfvertics);
    gateObj.model.outerRing = surf(Xo, Yo, totalLength * Zo, 'Parent', gateObj.modelFrame, 'FaceColor', color);
    % front
    Xf = [Xi(1, :); Xo(1, :)];
    Yf = [Yi(1, :); Yo(1, :)];
    gateObj.model.front = surf(Xf, Yf, zeros(size(Zi)), 'Parent', gateObj.modelFrame, 'FaceColor', color);
    % back
    gateObj.model.front = surf(Xf, Yf, totalLength * ones(size(Zi)), 'Parent', gateObj.modelFrame, 'FaceColor', color);
end