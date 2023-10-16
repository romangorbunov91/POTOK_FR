% Plots.
set(0, "defaultaxesfontsize", 24); % axes labels fontsize.

% Power stage frequency response.
X_LIM = [10, 15e3];
%USER_LEGEND = fileList;
%USER_TITLE = 'Power Plant';
%USER_LEGEND = {'2x125 V' '2x250 V'};
USER_LEGEND = {'16.5 \Omega (9.0 A)' '300 \Omega (0.5 A)'};
%USER_LEGEND = {'16.5 \Omega (9.0 A)' '33.0 \Omega (4.5 A)' '300 \Omega (0.5 A)'};
USER_TITLE = [];

[~, numPlotDatasets] = size(plotData);

subplot(2,1,1);
for idx = 1 : numFiles
    semilogx(dataset{idx}(:,index.frequency_Hz), ...
             dataset{idx}(:,index.magnitude_dB));
    hold on;
end
legend(USER_LEGEND);
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
title(USER_TITLE);

subplot(2,1,2);
for idx = 1 : numFiles
    semilogx(dataset{idx}(:,index.frequency_Hz), ...
             dataset{idx}(:,index.angle_deg   ));
    hold on;
end
legend(USER_LEGEND);
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