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
m_with_noise = awgn(m,40, 'measured');   % message signal with 0 SNR
noise = m_with_noise - m;

denoised_moving = smoothing_algo(m_with_noise, 'moving'); % Moving Average
denoised_sg = smoothing_algo(m_with_noise, 'sgolay'); % Sgolay filter
denoised_lr = smoothing_algo(m_with_noise, 'lowess'); % Linear Regression

error_moving = norm(abs(denoised_moving - m));
error_sg = norm(abs(denoised_sg - m));
error_lr = norm(abs(denoised_lr - m));
% figure(1);
% plot(t, abs(m - denoised_moving), t, abs(m - denoised_sg), t, abs(m - denoised_lr));
