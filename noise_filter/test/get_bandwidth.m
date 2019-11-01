function [bandwidth] = get_bandwidth(m_in, Fs, threshold)
%% Function for getting the bandwidth of the message min
% min = message input
% Fs = Sampling Frequency at which min was sampled
% threshold = power threshold in dbW. Hard Thresholding Method - anything below this threshold will be
% zeroed out, anything above will be kept.

% Initialization
L = length(m_in) % Length of the message
Y = fft(m_in); % Get FFT of message signal
P = 10*log10(abs(Y)./L); % Get Power Spectrum of Message Signal in dBW
P = P(1:L/2 + 1); % Consider only the first half of the spectra
spacing = Fs/(L - 1);
bandlow = 1000000000;
bandhigh = -bandlow;

% traversal
for i = 0:(L/2)
    frequency = i * spacing;
    if P(i + 1, 1) >= threshold
        bandlow = min(bandlow, frequency);
        bandhigh = max(bandhigh, frequency);
    end
end

bandwidth = [bandlow bandhigh];

end

