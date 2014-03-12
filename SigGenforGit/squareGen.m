function output = squareGen( frequency, duration, numOT, sampleRate, phase)
    
    output = sineGen(frequency, duration, sampleRate, phase); 
    % important to have the sineGen in the same folder
    figure(1);
    plot(output);

    for overtoneNum = 1:numOT
        % will be executed 1 to as many overtones inputed
        multiple = 2*overtoneNum + 1;
        % going up by odd mutliples
        overtone = sineGen(multiple*frequency, duration, sampleRate, phase)/ multiple;
        %adding sine and then scaling it. could also be (1/multiple) * at
        %the beginning instead (it's just the k-number the users inputted)
        output = output + overtone; 
        figure(1);
        plot(output);
        %xlim ([0, 1/frequency*2]) %zoom in
        pause
    end
    soundsc(output, sampleRate)
    
end 

%use this
% and need to put % at the end of argument to not have it spit out all the
% plots 