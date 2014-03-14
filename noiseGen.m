function whiteNoise = noiseGen (duration, sampleRate)
    figure(1)

    whiteNoise = 2*rand(duration * sampleRate,1)-1;
    %multiplying rand(1), which is from 0-1, and going from 0-2, and then
    %-1 will make it from -1 to 1 via subtraction
   
   
    whiteNoise= whiteNoise - mean (whiteNoise);
    %^ zero mean. the signal - mean of the signal 
    
    plot(whiteNoise)
   % soundsc(whiteNoise, sampleRate)
    
end


