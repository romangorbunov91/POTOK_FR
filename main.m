% pkg load control;
% pkg install -auto;
clear; clc;

%===============================================================================
% User-defined parameters.
platformName = 'Matlab'; % 'Matlab' or 'Octave'
deviceName = 'AP300'; % 'AP300' or 'Bode100'
% Data interpolation enable.
interpEnable = false; % true/false
% Number of interpolation points.
numPoints = 1000;
%===============================================================================
% Variables: index within an array.
index.frequency_Hz = 1;
index.magnitude_dB = 2;
index.angle_deg    = 3;

% Import DATA from 'importData'-folder.
[importDataset, fileList, numFiles] = importData(index, platformName, deviceName);

% Pre-plot data processing.
run('Inc/processing.m');
run('Inc/calculations.m');
% Plots.
plotData = complex2bode( frDatasets );
run('Inc/plotBode.m');
