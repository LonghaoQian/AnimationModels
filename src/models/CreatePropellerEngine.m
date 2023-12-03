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
% generate a propeller engine
function propEngineObj = CreatePropellerEngine(length, radius, rotorRadius, engineColor, rotorColor, mainAxis)
    %% define frame
    propEngineObj.frame = hgtransform('Parent', mainAxis);
    %% define rotor
    N_rotor = 30;
    theta1 = linspace(0, 2 * pi, N_rotor);
    rotorPos = zeros(N_rotor, 3);
    for i = 1 : N_rotor
        rotorPos(i, 1) = rotorRadius * cos(theta1(i));
        rotorPos(i, 2) = rotorRadius * sin(theta1(i));
        rotorPos(i, 3) = 1.2 * length / 2;
    end

    propEngineObj.model.rotor(i) = patch('Faces',1 : 1 : N_rotor ,'Vertices', rotorPos, 'FaceColor', rotorColor, 'facealpha',0.3, 'Parent', propEngineObj.frame);
    
    %% define engine
    propEngineObj.engineFrame = hgtransform('Parent', propEngineObj.frame);
    [Xi, Yi, Zi]= cylinder(radius, 30);
    propEngineObj.model.engineSide = surf(Xi, Yi, length * Zi, 'Parent', propEngineObj.engineFrame, 'FaceColor', engineColor);
    set(propEngineObj.engineFrame, 'Matrix', makehgtform('translate',[ 0, 0, - length/2]));
    engineFront = zeros(N_rotor, 3);
    engineBack = zeros(N_rotor, 3);
    for i = 1 : N_rotor
        engineFront(i, 1) = radius * cos(theta1(i));
        engineFront(i, 2) = radius * sin(theta1(i));
        engineFront(i, 3) = length / 2;        
        engineBack(i, 1) = radius * cos(theta1(i));
        engineBack(i, 2) = radius * sin(theta1(i));
        engineBack(i, 3) = -length / 2;   
    end
    propEngineObj.model.engineFront = patch('Faces', 1 : 1 : N_rotor ,'Vertices', engineFront, 'FaceColor', engineColor, 'Parent', propEngineObj.frame);
    propEngineObj.model.engineBack = patch('Faces', 1 : 1 : N_rotor ,'Vertices', engineBack, 'FaceColor', engineColor, 'Parent', propEngineObj.frame);
    %% define faring
    propEngineObj.faringFrame = hgtransform('Parent', propEngineObj.frame);
    [Xf, Yf, Zf]= cylinder([0.2 * radius 0], 15);
    propEngineObj.model.engineSide = surf(Xf, Yf, 0.3 * length * Zf, 'Parent', propEngineObj.faringFrame, 'FaceColor', engineColor);
    set(propEngineObj.faringFrame, 'Matrix', makehgtform('translate',[ 0, 0, length/2]));
end