% Title: Generates math-model based frequency response datasets.
% Type: APPLICATION SPECIFIC
% Released: 28-Aug-2023
% Author: Roman Gorbunov
% Script and data info:
    % Calculates complex gains
    % at the frequencies specified by the 'linspace' as the 1D-array,
    % where 'FR_NUM_OF_POINTS' - number of frequencies.
    % OUTPUTS:
        % frDatasets{1..NUM_OF_DATASETS}(FR_NUM_OF_POINTS, 2)
            % 1D-cell-array (row-vector) as the global variable.
            % Each cell contains an independent dataset
                % as 2D-array with 2 columns:
                    % (:, 1) - frequency, Hz;
                    % (:, 2) - complex gain.

% Read the parameters.
run('calculationsInc/digitalControl.m');
run('calculationsInc/pwrStage.m');
run('calculationsInc/userSetups.m');

%==========================================================================
% Frequency interval for the frequency response.
%==========================================================================
FR_NUM_OF_POINTS = 10e3;
FR_FREQ_HZ_MIN = 10;
FR_FREQ_HZ_MAX = 15e3;
frequencyHz = linspace(FR_FREQ_HZ_MIN, FR_FREQ_HZ_MAX, FR_NUM_OF_POINTS);
%==========================================================================
% Construct the parameters structure for the functions.
%==========================================================================
% Power stage papameters.
paramStruct.Lout       = INV.Lout;
paramStruct.Cout       = INV.Cout;
paramStruct.ESR_Lout   = INV.ESR_Lout;
paramStruct.VOLTAGE_IN = 100;
paramStruct.TMR_PR_INV = TMR_PR_INV;
paramStruct.loadAbs    = 15;
paramStruct.loadPF     = 1.0;

% PWM papameters.
paramStruct.PWM.gain = 1 / double(TMR_PR_INV);
paramStruct.PWM.delay  = 0.45 * 0.8 / FREQ_UPDATE_TMR_INV;

% DAC papameters.
paramStruct.delayDAC.gain = 1;
paramStruct.delayDAC.delay = 0;

% Forward delay.
paramStruct.delayFWD.gain = 1;
paramStruct.delayFWD.delay = 0;

% Voltage feedback parameters.
paramStruct.VOLT_FB.gain  = 1;
paramStruct.VOLT_FB.delay = 0;

% Control loop parameters.
paramStruct.delayLOOP.gain  = 1;
paramStruct.delayLOOP.delay = 1 / FREQ_CTRL_INV;

% Digital IIR-filter parameters.
paramStruct.MAF.samplFreqHz = 240e3;
% Denominator.
paramStruct.MAF.a = 1;
% Numerator.
paramStruct.MAF.b = 1 / 4 * ones(1,4);
%==========================================================================
% Index.
%==========================================================================
clearvars varIndex
varIndex.frequency   = uint8(1);
varIndex.complex_mag = uint8(2);
%==========================================================================
% Calculations.
NUM_OF_DATASETS = 1;

frDatasets = cell(1,NUM_OF_DATASETS);
for idx = 1 : NUM_OF_DATASETS
    frDatasets{idx} = zeros(FR_NUM_OF_POINTS, length(fieldnames(varIndex)));
    frDatasets{idx}(:,varIndex.complex_mag) = ...
        pwrStageFunc(frequencyHz, paramStruct, 'mod_IL') .* ...
        gainDelayFunc(frequencyHz, paramStruct.delayLOOP) .* ...
        IIR_func(frequencyHz, paramStruct.MAF);

    frDatasets{idx}(:,varIndex.frequency  ) = frequencyHz;
end
