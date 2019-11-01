function [denoised_message] = continuous_wt(noisy_message)
%% Denoise message using Continuous Wavelet Transform
% Use this for finer scaling
% [WT, F] = cwt(m_with_noise, Fs, 'NumOctaves', 10, 'VoicesPerOctave', 32);
[WT, F] = cwt(noisy_message, Fs);
denoised_message = icwt(WT);
end

