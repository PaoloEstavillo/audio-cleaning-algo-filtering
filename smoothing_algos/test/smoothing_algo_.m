function [output]=smoothing_algo(input, type)
%a function that produces three outputs:
%1.) Moving average output
%2.) Savitzky-Golay Filter Output
%3.) Local Regression Smoothing output

if type == 'moving'     %Moving Average
    output = smooth(input);
elseif type == 'sgolay'     %SG Filter
    output = smooth(input,'sgolay',3);
else    %Local Regression Smoothing
    output = smooth(input, 'lowess');
end
