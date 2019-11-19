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

%% Use negative feedback
mlen = numel(m); % message length
r = m_with_noise;
feedbacksig = zeros(mlen, 1);
gain = 5000;
for i = 1:log2(mlen)
    e_s = r - feedbacksig;
    freq_range = get_bandwidth(e_s, Fs);
    y_out = gain*bandpass(e_s, freq_range, Fs);
    feedbacksig = (1/gain)*y_out;
end