clear; close all; clc;

%% Initialization
Fs = 44100; % sampling frequency
tstart = 0; % start time
tend = 2; % end time
t = [tstart : 1/Fs : tend - 1/Fs]'; % time vector
w = linspace(0, Fs, length(t))';
L = length(t); % length of signal

%% Create Noisy message

% input frequency/ies
f = 200;     
f2 = 1000;

% message signal
m = sin(2*pi*f*t) + sin(2*pi*f2*t);

% message signal with 0 SNR
SNR = 0;
pm_with_noise = awgn(m, SNR, 'measured');

% Extract the noisy component
noise = m_with_noise - m;

%% STP Block

% Window length in seconds
window_length = .01;

% Overlap in seconds, fix this to zero
window_overlap = 0;

% Window type; 'rectwin' for rectangular window, 'hamming' for hamming window
window_type = 'rectwin';

% Noise Filter Type; 'nf' for Negative Feedback, 'wavelet' for wavelet denoising
filt_type = 'nf';

% Execute STP Block
denoised = stp(m_with_noise, window_length, window_overlap, window_type, filt_type, Fs);

%% Smoothing Algo Block
denoised = smoothing_algo(denoised, 'moving');

%% Plot results

res_SNR = 20*log10(norm(denoised)/norm(noise)); %% Resulting SNR in db

% Normalize Signals
m = m/max(abs(m));
m_with_noise = m_with_noise/max(abs(m_with_noise));
noise = noise/max(abs(noise));su
denoised = denoised/max(abs(denoised));

% Compare Signals
plot(m);
hold;
plot(denoised);
% plot(m_with_noise);