function [funcOut, fileList, numFiles] = importData(index, platformName, deviceName)
% Import DATA from 'data'-folder.

% DAC gains.
gainDACx = 4095 / 2;
gainDACy = 4095 / 2 / 20;

switch deviceName
    case 'AP300'
        % Variables: index within a file.
        fileColumnIndex.frequency_Hz = 1; % column 1
        fileColumnIndex.magnitude_dB = 2; % column 2
        fileColumnIndex.angle_deg    = 3; % column 3
    case 'Bode100'
        % Variables: index within a file.
        fileColumnIndex.frequency_Hz = 1; % column 1
        fileColumnIndex.magnitude_dB = 4; % column 2
        fileColumnIndex.angle_deg    = 7; % column 3
    otherwise
        error('USER ERROR: Unknown function parameter!');
end

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
            switch deviceName
                case 'AP300'
                    importData{idx} = dlmread(strcat(folder, fileList(idx,:)));
                case 'Bode100'
                    importData{idx} = dlmread(strcat(folder, fileList(idx,:)), ";", 1, 0);
            end
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
