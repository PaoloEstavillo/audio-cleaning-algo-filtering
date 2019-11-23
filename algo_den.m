function [denoised_message] = algo_den(input_message, filt_type, smoothing_type, Fs)

    %% STP Block
    
    % Window length in seconds
    window_length = .01;

    % Overlap in seconds, fix this to zero
    window_overlap = 0;

    % Window Type
    window_type = 'rectwin';
    
    % Execute STP Block
    denoised_message = stp(input_message, window_length, window_overlap, window_type, filt_type, Fs);

    %% Smoothing Algo Block
    denoised_message = smoothing_algo(denoised_message, smoothing_type);

end

