function [filtered_sig] = noise_filt(noisy_sig, Fs, type)

    mlen = numel(noisy_sig); % message length
    r = [];
    feedbacksig = [];
    gain = 0;
    e_s = [];
    y_out = [];
    if type == "nf"     % Negative Feedback filter
        r = noisy_sig;
        feedbacksig = zeros(mlen, 1);
        gain = 5000;
        for i = 1:log2(mlen)
            e_s = r - feedbacksig;
            freq_range = get_bandwidth(e_s, Fs);
            if isnan(freq_range(1,2)) || isnan(freq_range(1,1))
                y_out = e_s;
                break;
            end
            if abs(freq_range(1,2) - freq_range(1,1)) < 200
                y_out = e_s;
                break;
            end
            y_out = gain*bandpass(e_s, freq_range, Fs);
            feedbacksig = (1/gain)*y_out;
        end
        filtered_sig = y_out;
    else
        filtered_sig = wdenoise(noisy_sig, 5);
    end
    
%     filtered_sig = filtered_sig/(max(abs(filtered_sig)));
    
end

