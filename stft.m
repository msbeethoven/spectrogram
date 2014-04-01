function output = stft(signal, windowLength, hopSize)
%how much you want the window to move over by (overlap) 

    start = 1;
    output = zeros(windowLength, 1);% 1 collumn
    countNum = 1;
    
    while start + windowLength - 1 <= length(signal);
        segment = signal(start: start+windowLength - 1);
        window = hann(windowLength);
        windowedSignal = segment .* window; 
        
        signalFFT = abs(fft(windowedSignal));
        % Put this into a variable somehow
        output(:, countNum) = signalFFT;
        
        start = start + hopSize;
        countNum = countNum +1; 
    end
end

%first time loop, computer sftf, collumn of 100 numbers (for exmaple) 
%first 100 numbers in matrix 
%each set numbers generated go into sepearte collumns of matrix 