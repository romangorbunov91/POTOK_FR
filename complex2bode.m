function outputDataset = complex2bode(inputDataset)
% Title: Convertes complex frequency response to BODE response.
% Version: 1.1
% Type: GENERAL
    % GENERAL - created for a varaity of applications.
    % SPECIFIC - based on the GENERAL (version x.x), but its funcionality is
        % modified in a way it looses its generality.
% Released: 21-Mar-2023
% Author: Roman Gorbunov
% Function info:
    % INPUTS:
        % 'inputDataset' as a cell array
            % inputDataset {1:NUM_OF_DATASETS}( 1:numberOfFrequencies, 1:2)
            % or as a 2D-array:
                % (:, 1) - frequency, Hz;
                % (:, 2) - complex gain.
   % OUTPUTS:
        % 'outputDataset' - same type and suze as 'inputDataset',
            % but each dataset consists of 3 columns:
                % (:, 1) - frequency, Hz;
                % (:, 2) - magnitude, dB;
                % (:, 3) - argument, deg.

internalDataset = inputDataset;
if iscell(inputDataset)
    [numOfRows, ~] = size(internalDataset);
    if (numOfRows > 1)
        error('USER ERROR: It must be a single-row cell-array!!!');
    end
else
    internalDataset = cell(1,1);
    internalDataset{1} = inputDataset;
end

[~, NUM_OF_DATASETS] = size(internalDataset);
outputDataset = cell(1, NUM_OF_DATASETS);
for idx = 1:NUM_OF_DATASETS
    [numOfPointsWithinDataset, ~] = size(internalDataset{idx});
    outputDataset{idx} = zeros(numOfPointsWithinDataset, 3);
    outputDataset{idx}(:,1) =                 internalDataset{idx}(:, 1);
    outputDataset{idx}(:,2) = mag2db ( abs  ( internalDataset{idx}(:, 2) ));
    outputDataset{idx}(:,3) = rad2deg( angle( internalDataset{idx}(:, 2) ));
    clearvars numOfPointsWithinDataset
end

if ~iscell(inputDataset)
    outputDataset = outputDataset{1};
end
end