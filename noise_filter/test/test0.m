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
m_with_noise = awgn(m, -20, 'measured');   % message signal with 5dB noise added
m_with_noise_fft = (fft(m_with_noise)/L);     % Power Spectrum of noisy signal

% Get the single sided FFT of message signal
m_fft_pos = m_fft(1: L/2 + 1);
m_with_noise_fft_pos = m_with_noise_fft(1: L/2 + 1);

figure(1);
subplot(2, 1, 1);
plot(m_with_noise);
title('Signal with 5 db noise');
subplot(2, 1, 2);
plot(w(1: L/2 + 1), 10*log(abs(m_with_noise_fft_pos)));
title('Frequency Spectrum of noised signal');

% for i = 0:length(t) - 1
%     if abs(m_with_noise_fft)
% end