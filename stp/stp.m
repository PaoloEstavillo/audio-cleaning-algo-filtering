%% Digital Speech Processing - calcSTE.m
% DSP Application Process - 1st Semester AY 2019-2020
% Submitted by: ESTAVILLO, Paolo G. 2015-02483
% Submitted on: 28 October 2019
% Created with: MATLAB R2018a

function [filtered_sig, STE] = stp(sig, window_length, window_overlap, window_type, filt_type, Fs)
% function for calculating the Short Time Energy of a signal
% [y, Fs] = audioread(filename);

% handle stereo files
y = sig;
input_sz = size(y);
if input_sz(1, 2) == 2
    y= sum(y, 2);
end

% % Normalize input y
% y = y/ max(abs(y));

% calculate the length, overlap, and jump in number of sampling points
nlength = round(window_length * Fs);
noverlap = round(window_overlap * Fs);
njump = nlength - noverlap;

win = window(window_type, nlength); % generate the window function

STE = []; % short time processed signal
ptr = 0; % index
filtered_sig = []; % vector for filtered signal
while 1
    
    % Extracct frame of input data
    if (ptr + nlength - 1 >= length(y))
        xseg = [y(ptr + 1:length(y))]; % pad zeroes if window length is too long
    else
        xseg = y(ptr + 1:ptr + nlength);
    end
    
    % Filter the signal here using the noise filter
    xseg = noise_filt(xseg, Fs, filt_type);
    filtered_sig = [filtered_sig; xseg];
    
    if (ptr + njump - 1 >= length(y)) % if the end of the window has reached the end of the signal
        break
    end
    
    ptr = ptr + njump; % jump the pointer by njump
end

% filtered_sig = filtered_sig/max(abs(filtered_sig)); % Normalize

end

