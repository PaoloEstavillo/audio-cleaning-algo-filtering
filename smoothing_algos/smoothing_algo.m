function [ma_out, sg_out, lr_out]=smoothing_algo(input)
%a function that produces three outputs:
%1.) Moving average output
%2.) Savitzky-Golay Filter Output
%3.) Local Regression Smoothing output

%Moving Average
ma_out = smooth(input);

%SG Filter Output
sg_out = smooth(input,'sgolay',3);

%Local Regression Smoothing output
lr_out = smooth(input, 'lowess');
end
