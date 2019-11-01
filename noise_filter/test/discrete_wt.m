function [denoised_message] = discrete_wt(noisy_message)

    % Denoise message using discrete wavelet tranform
    denoised_message = wdenoise(noisy_message);
end

