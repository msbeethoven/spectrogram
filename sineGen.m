function signal = sineGen (frequency, duration, samplingRate, phase)
    % start of sine generator with  3 arguments
    % output = function name (input arguments) 
    % signal doesn't come into play until the very end 
    %signal = zeros(1, duration*samplingRate);
 
    signal = zeros(duration*samplingRate, 1);
    %left side of comma, how many rows 
    %right side, how many collumns 
    %just one collumn since you want signal to be one collumn 
    %preallocate signal space
    for sampleNumber = 1:(duration*samplingRate)
        %from the first sampling rate to an indefinite samplingRate
        %(depends on user input)
        signal(sampleNumber) = sin(2*pi*frequency*sampleNumber/samplingRate + phase);
        %phase = (pi/2)
        %signal(sampleNumber) = sin(2*pi*frequency*sampleNumber/samplingRate +( pi/2));
        % sine wave formula
    end
    plot(signal) 
    %plot
    soundsc(signal, samplingRate)
    %sine sound
   
end 

%use this 3