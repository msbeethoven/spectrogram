function whiteNoise = noiseGen (duration, sampleRate)
    figure(1)

    whiteNoise = 2*rand(duration * sampleRate,1)-1; 
   
   
    whiteNoise= whiteNoise - mean (whiteNoise);
    %^ zero mean. the signal - mean of the signal 
    
   % plot(whiteNoise)
   % soundsc(whiteNoise, sampleRate)
    
end


%use this