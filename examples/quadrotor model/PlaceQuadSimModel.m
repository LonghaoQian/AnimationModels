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
% load 
function model = PlaceQuadSimModel(ax, singleQuadControl)
    model.quadObj = CreateQuadRotor(0.7, 0.3, ax, 'NED');

    model.gateOj1 = CreateRroundGate(2, 0.3, 0.2, 20, 'blue' , ax);
    model.gateOj2 = CreateRroundGate(2, 0.3, 0.2, 20, 'red' , ax);
    model.gateOj3 = CreateRroundGate(2, 0.3, 0.2, 20, 'green' , ax);
    model.gateOj4 = CreateRroundGate(2, 0.3, 0.2, 20, 'cyan' , ax);

    set(model.gateOj1.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [0; 10; 0]))
    set(model.gateOj2.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [0; -10; 0]))

    set(model.gateOj3.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [-10; 0; 0]) * makehgtform('zrotate',pi/2))
    set(model.gateOj4.frame, 'Matrix', makehgtform('translate', singleQuadControl.dataLog.control.centerP + [10; 0; 0]) * makehgtform('zrotate',pi/2))
end