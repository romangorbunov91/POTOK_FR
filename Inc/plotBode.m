% Plots.

set(0, "defaultaxesfontsize", 24); % axes labels fontsize.

% Power stage frequency response.
X_LIM = [10, 40e3];

[~, numPlotDatasets] = size(plotData);

%figure(1,"position",get(0,"screensize"));
subplot(2,1,1);
for idx = 1 : numFiles
    semilogx(dataset{idx}(:,index.frequency_Hz), ...
             dataset{idx}(:,index.magnitude_dB));
    hold on;
end
legend(fileList);
for idx = 1 : numPlotDatasets
    semilogx(plotData{idx}(:,index.frequency_Hz), ...
             plotData{idx}(:,index.magnitude_dB));
    hold on;
end
hold off;
xlim(X_LIM);
grid on;
xlabel('Frequency, Hz');
ylabel('Magnitude, dB');
title('Power Plant');

subplot(2,1,2);
for idx = 1 : numFiles
    semilogx(dataset{idx}(:,index.frequency_Hz), ...
             dataset{idx}(:,index.angle_deg   ));
    hold on;
end
legend(fileList);
for idx = 1 : numPlotDatasets
    semilogx(plotData{idx}(:,index.frequency_Hz), ...
             plotData{idx}(:,index.angle_deg   ));
    hold on;
end
hold off;
xlim(X_LIM);
grid on;
xlabel('Frequency, Hz');
ylabel('Phase, deg');