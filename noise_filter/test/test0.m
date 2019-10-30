clear; close all; clc;

Fs = 44100; % sampling frequency
tstart = 0; % start time
tend = 2; % end time
t = [tstart : 1/Fs : tend - 1/Fs]; % time vector

f = 200 % input frequency
m = sin(2*pi*f*t);
m_with_noise = awgn(m, 5, 0);

figure(1)
subplot(2, 1, 1);
plot(m);
title('Pure signal');
subplot(2, 1, 2);
plot(m_with_noise);
title('Signal with 5 db noise');