function [bandwidth] = get_bandwidth(m_in, Fs)
%% Function for getting the bandwidth of the message min
% min = message input
% Fs = Sampling Frequency at which min was sampled

[bw, flo, fhi, powr] = powerbw(m_in, Fs);
% [bw, flo, fhi, powr] = obw(m_in, Fs);

bandwidth = [flo fhi];

end

