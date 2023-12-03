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
% generate a vtol with tilting rotors
function vtolObj = CreateTwingEngineVtol(sizeFactor, mainAxis, varargin)
    %% create a plane
    if length(varargin) >= 1
        vtolObj.plane = CreatePlane(sizeFactor, mainAxis, varargin{1});
    else
        vtolObj.plane = CreatePlane(sizeFactor, mainAxix);
    end
    %% create too engines
    
    vtolObj.para.engineLength = 1.2 * vtolObj.plane.para.wingchord;
    vtolObj.para.engineRadius = 0.3 * vtolObj.plane.para.wingchord;
    vtolObj.para.rotorRadius = 2 * vtolObj.plane.para.wingchord;
    vtolObj.para.leftEnginePos = [0, - vtolObj.plane.para.wingspan / 2 - vtolObj.para.engineRadius, vtolObj.plane.para.wingheight];
    vtolObj.para.rightEnginePos = [0, vtolObj.plane.para.wingspan / 2 + vtolObj.para.engineRadius, vtolObj.plane.para.wingheight];
    
    vtolObj.leftEngineObj = CreatePropellerEngine(vtolObj.para.engineLength, vtolObj.para.engineRadius, vtolObj.para.rotorRadius, 'cyan', 'blue', vtolObj.plane.frame_model);
    vtolObj.rightEngineObj = CreatePropellerEngine(vtolObj.para.engineLength, vtolObj.para.engineRadius, vtolObj.para.rotorRadius, 'cyan', 'blue', vtolObj.plane.frame_model);
    
    set(vtolObj.leftEngineObj.frame, 'Matrix', makehgtform('translate', vtolObj.para.leftEnginePos));
    set(vtolObj.rightEngineObj.frame, 'Matrix', makehgtform('translate', vtolObj.para.rightEnginePos ));
end