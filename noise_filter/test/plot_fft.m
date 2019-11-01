function [] = plot_fft(m, Fs)
%% Plots the FFT of a signal m with sampling rate Fs

L = length(m);
Y = fft(m);
P = 10*log10(abs(Y)./L);
P = P(1:L/2 + 1);
w = linspace(0,Fs, L);

plot(w(1:L/2 + 1), P);

end

