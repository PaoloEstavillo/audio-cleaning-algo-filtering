%% Digital Speech Processing - calcSTE.m
% DSP Application Process - 1st Semester AY 2019-2020
% Submitted by: ESTAVILLO, Paolo G. 2015-02483
% Submitted on: 28 October 2019
% Created with: MATLAB R2018a

function [y, Fs, STE] = calcSTE(filename,window_length, window_overlap, window_type)
% function for calculating the Short Time Energy of a signal
[y, Fs] = audioread(filename);

% handle stereo files
input_sz = size(y);
if input_sz(1, 2) == 2
    y = sum(y, 2);
end

% Normalize input y
y = y / max(abs(y));

% calculate the length, overlap, and jump in number of sampling points
nlength = round(window_length * Fs);
noverlap = round(window_overlap * Fs);
njump = nlength - noverlap;

win = window(window_type, nlength); % generate the window function

STE = []; % short time energy vector, initialize to empty
ptr = 0; % index
new_y = [];
while 1
    
    % Extracct frame of input data
    if (ptr + nlength - 1 >= length(y))
        xseg = [y(ptr + 1:length(y)); zeros(nlength - (length(y) - ptr) , 1)]; % pad zeroes if window length is too long
    else
        xseg = y(ptr + 1:ptr + nlength);
    end
    new_y = [new_y; xseg];   
    xseg = xseg .* xseg; % Calculate the energy.
    xseg = xseg .* win; % Multiply the window.
    STE = [STE; xseg]; % calculate the short time energy
    
    if (ptr + njump - 1 >= length(y)) % if the end of the window has reached the end of the signal
        break
    end
    
    ptr = ptr + njump; % jump the pointer by njump
end

y = new_y;

end

