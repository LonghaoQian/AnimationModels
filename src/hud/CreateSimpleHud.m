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
% create a simple hud with artifical horizon, speed and height display
% parameters: 
% sizeFactor: a non-dimenstional number controlling the hud size
% color: color of the hud
% fontSize: the font size of altitude and airspeed
% numOfTicks: total number of numOfPitchTicks from 0 deg to 90 deg
% pitchRange: pitch range on the hud
% background: color of the background. use 'none' to set as tranparent
function simpleHud = CreateSimpleHud(sizeFactor, color, fontSize, numOfPitchTicks, pitchRange, background)
    %% create a transparent axis on top of the existing plot 
    simpleHud.ax = axes('Units', 'Normalized', 'Position', [0.1 0.1 0.8 0.8],...
    'XLim',[-1, 1],...
    'YLim',[-1, 1],...
    'Box', 'on', ...
    'LineWidth', 2, ...
    'Color', background,...
    'DataAspectRatio', [1 1 1]);
    simpleHud.ax.XAxis.Visible = 'off';
    simpleHud.ax.YAxis.Visible = 'off';
    %% hud parameters
    % geometry of the reticle
    reticleWidth = 0.17;
    reticleShapeX = [-reticleWidth * sizeFactor, -0.1 * sizeFactor, -0.05 * sizeFactor, 0, 0.05 * sizeFactor, 0.1 * sizeFactor, reticleWidth * sizeFactor];
    reticleShapeY = [0, 0, -0.05 * sizeFactor, 0, -0.05 * sizeFactor, 0, 0];
    % geometry of the pitch indicator
    pitchTickZeroDegLenth = 0.5 * sizeFactor;
    pitchTickZeroDegPos = 0.2 * sizeFactor;
    pitchTickLen = 0.8 * sizeFactor;
    pitchTickTextLocationLeft = -0.45 * sizeFactor;
    pitchTickTextLocationRight = 0.45 * sizeFactor;
    % geometry of the roll indicator
    rollIndicatorRange = 60/57.3;
    rollIndicatorR = 0.7;
    rollIndicatorSize = 0.1;
    rollIndicatorTicks = [-60, -40, -30, -20, -10, 0, 10, 20, 30, 40, 60];
    theta = linspace(- rollIndicatorRange, rollIndicatorRange, 30);
    rollIndicatorx = sin(theta) * rollIndicatorR;
    rollIndicatory = cos(theta) * rollIndicatorR;
    % geometry of the yaw indicator
    yawIndicatorTextPositon = [0, 0.93];
    yawIndicatorLineHight = 0.87;
    yawIndicatorLineLength = 0.15;
    % geometry of altitude and airspeed indicator
    altitudeIndicatorPos = [-0.9 * sizeFactor, 0];
    airspeedIndicatorPos = [0.9 * sizeFactor, 0];
    
    %% define hud
    simpleHud.reticle = line(reticleShapeX, reticleShapeY, 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
    %% create the roll indicator frame
    simpleHud.rollIndicator.frame = hgtransform('Parent', simpleHud.ax);
    %% create the pitch indicator
    simpleHud.pitchIndicator.left.line = line([- pitchTickZeroDegPos - pitchTickZeroDegLenth, - pitchTickZeroDegPos],...
        [0, 0] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.rollIndicator.frame);
    simpleHud.pitchIndicator.right.line = line([pitchTickZeroDegPos, pitchTickZeroDegPos + pitchTickZeroDegLenth],...
        [0, 0] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.rollIndicator.frame);
    simpleHud.pitchIndicator.right.text = text(- pitchTickZeroDegPos - pitchTickZeroDegLenth, 0,...
        '0', 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
    simpleHud.pitchIndicator.left.text = text(pitchTickZeroDegPos + pitchTickZeroDegLenth, 0,...
        '0', 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);

    degPerTick = 90/numOfPitchTicks;
    simpleHud.pitchIndicator.pitchRange = pitchRange;
    simpleHud.pitchIndicator.lengthPerTick =  degPerTick / pitchRange;
    simpleHud.pitchIndicator.numOfPitchTicks = numOfPitchTicks;
    
    for i = 1 : numOfPitchTicks
        tickDis = i * simpleHud.pitchIndicator.lengthPerTick;
        tickDeg = i * degPerTick;
        simpleHud.pitchIndicator.upper{i}.line = line([-0.5 * pitchTickLen, 0.5 * pitchTickLen], [tickDis, tickDis] , 'LineWidth', 1, 'Color', color, 'LineStyle', '--', 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.upper{i}.textLeft = text(pitchTickTextLocationLeft, tickDis, num2str(round(tickDeg)), 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.upper{i}.textRight = text(pitchTickTextLocationRight, tickDis, num2str(round(tickDeg)), 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.lower{i}.line  = line([-0.5 * pitchTickLen, 0.5 * pitchTickLen], [-tickDis, -tickDis] , 'LineWidth', 1, 'Color', color, 'LineStyle', '--', 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.lower{i}.textLeft = text(pitchTickTextLocationLeft, -tickDis, num2str(-round(tickDeg)), 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.lower{i}.textRight = text(pitchTickTextLocationRight, -tickDis, num2str(-round(tickDeg)), 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
    end
    %% roll indicator
    simpleHud.rollIndicator.iconFrame = hgtransform('Parent', simpleHud.ax);
    simpleHud.rollIndicator.indicator = line([0, rollIndicatorSize / 2, -rollIndicatorSize / 2, 0],...
                                              [rollIndicatorR, rollIndicatorR - sqrt(3) * rollIndicatorSize / 2, rollIndicatorR - sqrt(3) * rollIndicatorSize / 2, rollIndicatorR], 'LineWidth', 1,...
                                              'Color', color, 'Parent', simpleHud.rollIndicator.iconFrame);
    simpleHud.rollIndicator.circle = line(rollIndicatorx, rollIndicatory, 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
    for i = 1 : length(rollIndicatorTicks)
        phi = rollIndicatorTicks(i)/57.3;
        sphi = sin(phi);
        cphi = cos(phi);
        simpleHud.rollIndicator.text_array{i}.text = text(1.1 * rollIndicatorR * sphi, 1.1 * rollIndicatorR * cphi,...
                                                     num2str(rollIndicatorTicks(i)), 'HorizontalAlignment',...
                                                     'center', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.ax);
        simpleHud.rollIndicator.text_array{i}.tick = line([rollIndicatorR * sphi, 1.03 * rollIndicatorR * sphi], [rollIndicatorR * cphi, 1.03 * rollIndicatorR * cphi], ...
                                                           'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
        set(simpleHud.rollIndicator.text_array{i}.text, 'Rotation', -rollIndicatorTicks(i));
    end
    %% yaw indicator
    simpleHud.yawIndicator.text = text(yawIndicatorTextPositon(1), yawIndicatorTextPositon(2), '000', 'HorizontalAlignment', 'center', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.ax);
    simpleHud.yawIndicator.line = line([-yawIndicatorLineLength/2, yawIndicatorLineLength/2], [yawIndicatorLineHight, yawIndicatorLineHight], 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
    %% altitude and airspeed
    simpleHud.altitude = text(altitudeIndicatorPos(1), altitudeIndicatorPos(2), '000 m', 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.ax);
    simpleHud.airspeed = text(airspeedIndicatorPos(1), airspeedIndicatorPos(2), '000 m/s', 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.ax);
end