function outputDataset = gainDelayFunc(frequencyHz, inputStruct)
% Title: Transfer function of the delay block with gain.
% Version: 1.0
% Type: APPLICATION SPECIFIC
% Released: 29-Sep-2023
% Author: Roman Gorbunov
% Function info:
    % Calculates complex gains at the specified frequencies.
    % The function is built of the equations that depend on 's' only.
    % INPUTS:
        % frequencyHz - 1D-array (row).
        % inputStruct - structure with transfer function parameters.
    % OUTPUTS:
        % outputDataset - 1D-array (row) with the complex gains that
            % correspond to the frequencies in 'frequencyHz'.

% Transfer function parameters.
gain  = inputStruct.gain;
delay = inputStruct.delay; 

% Complex frequency.
s = 1i * 2 * pi * frequencyHz;

% Transfer function.
outputDataset = gain .* exp(-s * delay);