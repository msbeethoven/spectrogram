function signal = cosGen (frequency, duration, samplingRate, phase)
%signal = zeros(duration*samplingRate, 1);
    %for sampleNumber = 1:(duration*samplingRate)
       
        signal = sineGen(frequency, duration, samplingRate, phase);
        %send it as pi/2 from the signal generator
        figure(1)
        
       plot(signal)
end
%use this 