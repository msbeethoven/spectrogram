function output = sawGen( frequency, duration, numOT, sampleRate, phase)
    
    output = sineGen(frequency, duration, sampleRate, phase); 
    % important to have the sineGen in the same folder
    figure(1);
    pause

    for overtoneNum = 1:numOT
        % will be executed 1 to as many overtones inputed
        multiple = overtoneNum + 1;
        % going up by even and odd multiples
        overtone = sineGen(multiple*frequency, duration, sampleRate, phase)/ multiple;
        %adding sine and then scaling it. could also be (1/multiple) * at
        %the beginning instead (it's just the k-number the users inputted)
        output = output - overtone; 
        % negative summation 
        
 
     
    end
soundsc(output, sampleRate)
plot(output);   
    
end 

%use this