clear; close all; clc;

%% Initialization
Fs = 44100; % sampling frequency
tstart = 0; % start time
tend = 2; % end time
t = [tstart : 1/Fs : tend - 1/Fs]'; % time vector
w = linspace(0, Fs, length(t))';
L = length(t); % length of signal

%% Create Noisy message
f = 200;     % input frequency/ies
f2 = 1000;
m = sin(2*pi*f*t) + sin(2*pi*f2*t);  % message signal
m_with_noise = awgn(m,5, 'measured');   % message signal with 0 SNR
noise = m_with_noise - m;

%% Denoise message here using wavelet denoising (1)
% denoised_message = wdenoise(m_with_noise, 5);

% Denoise message using Negative Feedback (2)
denoised_message = noise_filt(m_with_noise, Fs, 'nf');

figure(1);
subplot(2, 1, 1)
plot(t, m_with_noise, t, denoised_message);
title('Noisy Message and Denoised Message');
subplot(2, 1, 2)
plot(t, abs(denoised_message - m));
title('Error Plot');

