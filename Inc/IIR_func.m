function outputDataset = IIR_func(frequencyHz, inputStruct)
% Title: Transfer function of the IIR-filter.
% Version: 1.1
% Type: APPLICATION SPECIFIC
% Released: 28-Aug-2023
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
a = inputStruct.a;
b = inputStruct.b;
N = length(a);
M = length(b);
T = 1 / inputStruct.samplFreqHz;

% Complex frequency.
s = 1i * 2 * pi * frequencyHz;
z = exp(T * s);

% Numerator.
B = 0;
for m = 1:M
    B = B + b(m) * z.^(-(m - 1));
end
% Denumerator.
A = 0;
for n = 1:N
    A = A + a(n) * z.^(-(n - 1));
end

outputDataset = B ./ A;