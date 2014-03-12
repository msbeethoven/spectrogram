%seori sachs
%ss5413
%3.12.14


function output = sigGen (signal, frequency, duration, numOT, sampleRate, fileName) 
%go back into each file and have error for nyquist, for fundamental, not
%for overtones

%error checking for parameters here expect for signal type (just tell them) 
switch signal 
    case ('sine')
        output = sineGen(frequency, duration, sampleRate, 0);
    case ('triangle')
        output = triGen(frequency, duration, numOT, sampleRate, 0);
    case ('sawtooth')
        output = sawGen(frequency, duration, numOT, sampleRate, 0);
    case ('square')
        output = squareGen( frequency, duration, numOT, sampleRate, 0);
    case ('cosine')
        output = cosGen( frequency, duration, numOT, sampleRate, pi/2);
    case ('white noise')
        output = noiseGen (duration, sampleRate);
        
    otherwise 
        
        error('invalid signal type');
  

end

if nargin == 6
  
   wavwrite(output, sampleRate, fileName)
   %audiowrite(fileName, output, sampleRate)
   %wave of signal
end
   plot(output)
   %plotting 
   %soundsc 
end
