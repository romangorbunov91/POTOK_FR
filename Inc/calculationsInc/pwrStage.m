% Power stage.

%==========================================================================
% Power Inverter.
%==========================================================================
% Input capacitors.
INV.Cin = 470e-6;
INV.ESR_Cin = 0.20 / (2 * pi * 120 * INV.Cin);
INV.Cin_tot = 2 * INV.Cin;
INV.ESR_Cin_tot = INV.ESR_Cin / 2;
% Discharge/balance resistors.
INV.R_dis_in_tot = 2 * 150e3;

% Inductor at the output.
INV.Lout = 300e-6;
INV.ESR_Lout = 10e-3;
% Capacitor at the output.
INV.Cout = 15e-6;
INV.ESR_Cout = 6e-3;

% Half-bridge MOSFETs (IMW120R090M1H).
INV.HB_Rds_on = 115e-3;
INV.HB_Vd_on = 4.0;
% AC-switch MOSFETs (SCTW35N65G2V).
INV.ACsw_Rds_on = 55e-3;
INV.ACsw_Vd_on = 3.3;

% Input/output.
INV.VOLTAGE_IN_NOM  = 700;
INV.VOLTAGE_OUT_NOM = 230; % RMS.
INV.POWER_OUT_NOM   = 2000;
INV.OUTPUT_FREQ_NOM = 50;
%==========================================================================