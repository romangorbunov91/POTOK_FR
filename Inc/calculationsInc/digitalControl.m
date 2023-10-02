% Microcontroller settings.

% HEXT oscillator clock frequency.
HEXT_OSC_FREQ = 25e6;

% System clock.
AHB_CLK_FREQ = (HEXT_OSC_FREQ * 48) / 5;
APB2_CLK_FREQ = AHB_CLK_FREQ / 2;

% Timer clock.
% TIM1 - Inverter PWM.
TIM1_CLK_FREQ = APB2_CLK_FREQ * 2;
TIM1_CLK_PRD = 1 / TIM1_CLK_FREQ;

% Inverter switching frequency.
FREQ_SWITCH_INV = 60e3;
% Inverter timer update frequency.
FREQ_UPDATE_TMR_INV = FREQ_SWITCH_INV;
% Inverter control frequency.
FREQ_CTRL_INV = 30e3;
% Inverter PWM period in counts.
TMR_PR_INV = uint32(TIM1_CLK_FREQ / FREQ_UPDATE_TMR_INV - 1);