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
function simpleHud = CreateSimpleHud(sizeFactor, color, fontSize, numOfPitchTicks, pitchRange)
    %% create a transparent axis on top of the existing plot 
    simpleHud.ax = axes('Units', 'Normalized', 'Position', [0.1 0.1 0.8 0.8],...
    'XLim',[-1, 1],...
    'YLim',[-1, 1],...
    'Box', 'on', ...
    'LineWidth', 2, ...
    'Color', 'none',...
    'DataAspectRatio', [1 1 1]);
    simpleHud.ax.XAxis.Visible = 'off';
    simpleHud.ax.YAxis.Visible = 'off';
    %% hud parameters
    reticleWidth = 0.17;
    %% define hud
    simpleHud.reticle = line([-reticleWidth * sizeFactor, -0.1 * sizeFactor, -0.05 * sizeFactor, 0, 0.05 * sizeFactor, 0.1 * sizeFactor, reticleWidth * sizeFactor ],...
                             [0, 0, -0.05 * sizeFactor, 0, -0.05 * sizeFactor, 0, 0] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
    % create the roll indicator
    simpleHud.rollIndicator.frame = hgtransform('Parent', simpleHud.ax);
    simpleHud.altitude = line([-0.8 * sizeFactor, -0.8 * sizeFactor], [-0.8 * sizeFactor, 0.8 * sizeFactor] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
    simpleHud.airspeed = line([0.8 * sizeFactor, 0.8 * sizeFactor], [-0.8 * sizeFactor, 0.8 * sizeFactor] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.ax);
    simpleHud.pitchIndicator.left.line = line([-0.7 * sizeFactor, -0.2 * sizeFactor], [0, 0] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.rollIndicator.frame);
    simpleHud.pitchIndicator.right.line = line([0.2 * sizeFactor, 0.7 * sizeFactor], [0, 0] , 'LineWidth', 1.5, 'Color', color, 'Parent', simpleHud.rollIndicator.frame);
    simpleHud.pitchIndicator.right.text = text(-0.7 * sizeFactor, 0, '0', 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
    simpleHud.pitchIndicator.left.text = text(0.7 * sizeFactor, 0, '0', 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);

    degPerTick = 90/numOfPitchTicks;
    simpleHud.pitchIndicator.pitchRange = pitchRange;
    simpleHud.pitchIndicator.lengthPerTick =  degPerTick / pitchRange;
    
    for i = 1 : numOfPitchTicks
        tickDis = i * simpleHud.pitchIndicator.lengthPerTick;
        tickDeg = i * degPerTick;
        simpleHud.pitchIndicator.upper{i}.line = line([-0.4 * sizeFactor, 0.4 * sizeFactor], [tickDis, tickDis] , 'LineWidth', 1, 'Color', color, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.upper{i}.textLeft = text(-0.45 * sizeFactor, tickDis, num2str(round(tickDeg)), 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.upper{i}.textRight = text(0.45 * sizeFactor, tickDis, num2str(round(tickDeg)), 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.lower{i}.line  = line([-0.4 * sizeFactor, 0.4 * sizeFactor], [-tickDis, -tickDis] , 'LineWidth', 1, 'Color', color, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.lower{i}.textLeft = text(-0.45 * sizeFactor, -tickDis, num2str(-round(tickDeg)), 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
        simpleHud.pitchIndicator.lower{i}.textRight = text(0.45 * sizeFactor, -tickDis, num2str(-round(tickDeg)), 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.rollIndicator.frame);
    end
    
    
    simpleHud.altitude = text(-0.9 * sizeFactor, 0, '000 m', 'HorizontalAlignment', 'right', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.ax);
    simpleHud.airspeed = text(0.9 * sizeFactor, 0, '000 m/s', 'HorizontalAlignment', 'left', 'Color', color, 'FontSize', fontSize, 'Parent', simpleHud.ax);
end