function outputDataset = pwrStageFunc(frequencyHz, inputStruct, funcType)
% Title: Transfer functions of the inverter power stage.
% Version: 1.2
% Type: APPLICATION SPECIFIC
% Released: 28-Aug-2023
% Author: Roman Gorbunov
% Function info:
    % Calculates complex gains at the specified frequencies.
    % The function is built of the equations that depend on 's' only.
    % No additional delays are taken into account.
    % INPUTS:
        % frequencyHz - 1D-array (row).
        % inputStruct - structure with transfer function parameters.
        % funcType - char, that defines the transfer function:
            % 'mod_IL' - modulation-to-inductor's current;
            % 'mod_UC' - modulation-to-capacitor's voltage;
            % 'IL_UC' - inductor's current-to-capacitor's voltage;
            % 'mod_IL_decouple' - modulation-to-inductor's current when
                % the capacitor's voltage is decoupled ideally.
    % OUTPUTS:
        % outputDataset - 1D-array (row) with the complex gains that
            % correspond to the frequencies in 'frequencyHz'.


% Transfer function parameters.
Uin       = inputStruct.VOLTAGE_IN;
Rload     = inputStruct.Rload;
loadPF    = inputStruct.loadPF;
L         = inputStruct.Lout;
C         = inputStruct.Cout;
rL        = inputStruct.ESR_Lout;
outFreqHz = inputStruct.outFreqHz;

% Complex frequency.
s = 1i * 2 * pi * frequencyHz;

% Parameters of the transfer functions.
% Load (R||L).
if loadPF < 1
    Lload = Rload / (2 * pi * outFreqHz) / sqrt(1 / loadPF^2 - 1);
    Zload = s * Lload ./ (1 + s * Lload / Rload);
else
    Zload = Rload;
end

Qw0 = 1 ./ (L ./ Zload + rL * C);
omega0_sq = 1 / (L *C);
omegaL = rL / L;

% Denominator of the transfer functions.
denomVar = 1 + rL ./ Zload + s ./ Qw0 + s.^2 / omega0_sq;

switch funcType
    case 'mod_IL'
        outputDataset = Uin / 2 * (1 + s .* Zload * C) ./ Zload ./ denomVar;
    case 'mod_UC'
        outputDataset = Uin / 2 ./ denomVar;
    case 'IL_UC'
        outputDataset = Zload ./ (1 + s .* Zload * C);
    case 'mod_IL_decouple'
        outputDataset = 1 / rL ./ (1 + s / omegaL);
    otherwise
        error('USER ERROR: Unknown function parameter!');
end