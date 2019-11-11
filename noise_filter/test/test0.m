clear; close all; clc;

%% Initialization
Fs = 44100; % sampling frequency
tstart = 0; % start time
tend = 2; % end time
t = [tstart : 1/Fs : tend - 1/Fs]'; % time vector
w = linspace(0, Fs, length(t))';
L = length(t); % length of signal

%% Create Noisy message
f = 200;     % input frequency
f2 = 1000;
m = sin(2*pi*f*t) + sin(2*pi*f2*t);  % message signal
m_fft = (fft(m)/L);   % Power Spectrum of the message signal
m_with_noise = awgn(m,0, 'measured');   % message signal with 20dB noise added
noise = m_with_noise - m;
m_with_noise_fft = (fft(m_with_noise)/L);     % Power Spectrum of noisy signal

% Get the single sided FFT of message signal
m_fft_pos = m_fft(1: L/2 + 1);
m_with_noise_fft_pos = m_with_noise_fft(1: L/2 + 1);

%% Discrete Wavelet Transform
denoise_m = m_with_noise;
for i = 1:8
    level = 6;
%     denoised_m = discrete_wt(denoise_m);
    WT = cwt(denoise_m, Fs);
    denoise_m = icwt(WT, F, get_bandwidth(denoise_m, Fs), 'morse', 'SignalMean', mean(denoise_m));
end

% [WT, F] = cwt(denoised_m, Fs);
% denoised_m = icwt(WT, F, get_bandwidth(m_with_noise, Fs), 'morse', 'SignalMean', mean(m_with_noise));
% [WT, F] = cwt(denoised_m, Fs);
% denoised_m = icwt(WT, F, get_bandwidth(m_with_noise, Fs), 'morse', 'SignalMean', mean(m_with_noise));

figure(1);
plot(t, m_with_noise, t, denoise_m);
