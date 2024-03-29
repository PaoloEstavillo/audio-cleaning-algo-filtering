function [average_resulting_snr, average_perf_met] = tester_file(filt_type,smoothing_type, input_SNR)
    
    %% Initialize directories
    if ismac
        % Code to run on Mac platform
    elseif isunix
        % Code to run on Linux platform
        curr_path = pwd;
        addpath(curr_path);
        addpath(strcat(curr_path, '/test_files'));
        addpath(strcat(curr_path, '/noise_filter'));
        addpath(strcat(curr_path, '/stp'));
        addpath(strcat(curr_path, '/smoothing_algos'));
    elseif ispc
        % Code to run on Windows platform
        curr_path = pwd;
        addpath(curr_path);
        addpath(strcat(curr_path, '\test_files'));
        addpath(strcat(curr_path, '\noise_filter'));
        addpath(strcat(curr_path, '\stp'));
        addpath(strcat(curr_path, '\smoothing_algos'));
    else
        disp('Platform not supported')
        quit;
    end
    
    oldfold = cd('test_files'); % Change to /test_files
    
    %% Edit this array to use the files needed for testing
    input_filenames = ["1920S1_07M_01.wav", "1920S1_07M_02.wav", "1920S1_07M_03.wav", "1920S1_07M_04.wav", "1920S1_07M_05.wav", "1920S1_07M_06.wav", "1920S1_07M_07.wav", "1920S1_07M_08.wav", "1920S1_07M_09.wav", "1920S1_07M_10.wav"];
    
    %% Start Testing
    
    perf_met = 0;
    average_resulting_snr = 0;
    average_perf_met = 0;
    fprintf("Starting...\n");
    
    i = 1;
    fprintf("#        snr      performace\n");
    for myfilename = input_filenames
        t = cputime;
        [y, Fs] = audioread(myfilename); % Get input data
        
        inputsnr = snr(y);
        
        noisy = awgn(y, input_SNR, 'measured'); % Inject noise

        denoised = algo_den(noisy, filt_type, smoothing_type, Fs); % Denoise the message
        
        newsnr = snr(denoised) - inputsnr;
        average_resulting_snr = average_resulting_snr + newsnr;
        perf_met = numel(y)/(cputime - t);
        average_perf_met = average_perf_met + perf_met;
        
        fprintf("File %d   %.4f   %.4f\n", i, newsnr, perf_met);
        i = i + 1;
    end
    
    average_resulting_snr = average_resulting_snr/10;
    average_perf_met = average_perf_met/10;
    
    fprintf("Average Resulting SNR: %f\n", average_resulting_snr);
    fprintf("Average Performace: %f\n", average_perf_met);
    fprintf("Finished!\n");
    % Testing Finished
    
    cd(oldfold);
    
end

