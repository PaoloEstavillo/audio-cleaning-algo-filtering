clear; close all; clc;

Fs = 44100; % sampling frequency
tstart = 0; % start time
tend = 2; % end time
t = [tstart : 1/Fs : tend - 1/Fs]; % time vector
w = linspace(0, Fs, length(t));
L = length(t); % length of signal

f = 200;     % input frequency
m = sin(2*pi*f*t);  % message signal
m_fft = (fft(m)/L);   % Power Spectrum of the message signal
m_with_noise = awgn(m, -20, 'measured');   % message signal with 20dB noise added
m_with_noise_fft = (fft(m_with_noise)/L);     % Power Spectrum of noisy signal

% Get the single sided FFT of message signal
m_fft_pos = m_fft(1: L/2 + 1);
m_with_noise_fft_pos = m_with_noise_fft(1: L/2 + 1);
%% Discrete Wavelet Transform
level = 6;
% denoised_m = wden(m_with_noise, 'sqtwolog', 'h', 'mln', level, 'sym6');
[WT, F] = cwt(m_with_noise, Fs, 'NumOctaves', 10, 'VoicesPerOctave', 32);
denoised_m = icwt(WT, F,  [2 500], 'morse', 'SignalMean', mean(m_with_noise));

figure(1);
subplot(2, 1, 1);
plot(m_with_noise);
title('Signal with 20 db noise');
subplot(2, 1, 2);
plot(denoised_m);
title('Denoised signal');