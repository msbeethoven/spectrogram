function signal = cosGen (frequency, duration, samplingRate)
    % start of cossine generator with  3 arguments
 
    signal = zeros(duration*samplingRate, 1);
    %left side of comma, how many rows 
    %right side, how many collumns 
    %just one collumn since you want signal to be one collumn 
    %preallocate signal space
    for sampleNumber = 1:(duration*samplingRate)
        %from the first sampling rate to an indefinite samplingRate
        %(depends on user input)
        signal(sampleNumber) = sin(2*pi*frequency*sampleNumber/samplingRate + pi/2);
        %phase = (pi/2)

    end
    plot(signal) 
    %plot
    %soundsc(signal, samplingRate)
    %sine sound
   
end 

