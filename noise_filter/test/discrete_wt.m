function [denoised_message] = discrete_wt(noisy_message, level)

    % Denoise message using discrete wavelet tranform
    denoised_message = wden(noisy_message, 'sqtwolog', 'h', 'mln', level, 'sym6');
end

