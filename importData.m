function [funcOut, fileList, numFiles] = importData(index, platformName)
% Import DATA from 'data'-folder.

% DAC gains.
gainDACx = 4095 / 2 / 40;
gainDACy = 4095 / 2 / 40;

% Variables: index within a file.
fileColumnIndex.frequency_Hz = uint8(1); % file column 1
fileColumnIndex.magnitude_dB = uint8(2); % file column 2
fileColumnIndex.angle_deg    = uint8(3); % file column 3

folder = 'importData/';
fileList = ls(folder);
switch platformName
    case 'Octave'

    case 'Matlab'
        fileList(1:2,:) = [];
    otherwise
        error('USER ERROR: Unknown function parameter!');
end
[numFiles, ~] = size(fileList);

importData = cell(1, numFiles);
outputData = cell(1, numFiles);
for idx = 1:numFiles
    switch platformName
        case 'Octave'
            importData{idx} = dlmread(strcat(folder, fileList(idx,:)));
            % Delete the 1st row (columns' titles).
            importData{idx}(1,:) = [];
        case 'Matlab'
            importData{idx} = readmatrix(strcat(folder, fileList(idx,:)));
        otherwise
            error('USER ERROR: Unknown function parameter!');
    end

  outputData{idx}(:,index.frequency_Hz) = importData{idx}(:,fileColumnIndex.frequency_Hz);
  outputData{idx}(:,index.magnitude_dB) = importData{idx}(:,fileColumnIndex.magnitude_dB) ...
      + mag2db(gainDACx / gainDACy);
  outputData{idx}(:,index.angle_deg)    = importData{idx}(:,fileColumnIndex.angle_deg);
end
funcOut = outputData;
end
