%Copyright 2016 The MathWorks, Inc.

%% Load a signal
load noisysig.mat
figure; 
subplot(2,1,1); plot(f0); grid on; title('Original signal'); axis tight; 
subplot(2,1,2); plot(f); title('Original signal with noise'); 
axis tight; grid on;


%%  Decompose signal using Discrete Wavelet Transform  
dwtmode('per','nodisplay');
wname = 'sym6';
level = 5;
[C, L] = wavedec(f,level,wname);

plotDetCoefHelper(f,C,L); %helperFunction to plot the coefficients at every level

%% Analyze the subbands and determine the threshold

%% Denoise the signal 
fd = wden(f,'rigrsure','s','sln',level,wname);

figure; 
subplot(2,1,1); 
plot(f);axis tight; grid on;title('Noisy Signal');
subplot(2,1,2)
plot(fd); axis tight; grid on;
title(sprintf('Denoised Signal SNR:  %0.2f dB',-20*log10(norm(abs(f0-fd))/norm(f0))));

%% Comparing with other techniques
figure; 
subplot(2,2,1); 
plot(f);axis tight; grid on;title('Noisy Signal');
subplot(2,2,2)
plot(fd); axis tight; grid on;
title(sprintf('Wavelet Denoising SNR:  %0.2f dB',-20*log10(norm(abs(f0-fd))/norm(f0))));
subplot(2,2,3)
fsg = sgolayfilt(f,31,101);
plot(fsg); axis tight; grid on;
title(sprintf('Savitzky Golay SNR:  %0.2f dB',-20*log10(norm(abs(f0-fsg))/norm(f0))));
subplot(2,2,4)
movavg = 1/20*ones(20,1);
fmv = filtfilt(movavg,1,f);
plot(fmv); axis tight; grid on;
title(sprintf('Moving Average SNR:  %0.2f dB',-20*log10(norm(abs(f0-fmv))/norm(f0))));

