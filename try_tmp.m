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
m_with_noise = awgn(m, SNR, 'measured');

% Extract the noisy component
noise = m_with_noise - m;
% resulting_SNR = 20*log10(norm(m)) - 20*log10(norm(noise));
resulting_SNR = snr (m_with_noise);
fprintf("Input SNR: %f\n", resulting_SNR);

%% STP Block

% Window length in seconds
window_length = .01;

% Overlap in seconds, fix this to zero
window_overlap = 0;

% Window type; 'rectwin' for rectangular window, 'hamming' for hamming window
window_type = 'rectwin';

% Noise Filter Type; 'nf' for Negative Feedback, 'wavelet' for wavelet denoising
filt_type = 'nf';

% Smoothing Type for smoothing algo
smoothing_type = 'moving';

% Execute STP Block
denoised = stp(m_with_noise, window_length, window_overlap, window_type, filt_type, Fs);

%% Smoothing Algo Block
denoised = smoothing_algo(denoised, smoothing_type);

%% Plot results

% Normalize Signals
% m = m/max(abs(m));
% m_with_noise = m_with_noise/max(abs(m_with_noise));
% denoised = denoised/max(abs(denoised));
denoised = denoised * (max(abs(m))/max(abs(denoised)));

noise = denoised - m;

% Resulting SNR in dB
% resulting_SNR = 20*log10(norm(denoised)) - 20*log10(norm(noise));
resulting_SNR = snr(denoised);
fprintf("Resulting SNR: %f\n", resulting_SNR);

% Compare Signals
plot(m);
hold;
plot(denoised);
% plot(m_with_noise);