%seori sachs
%ss5413
%3.12.14


function output = sigGen (signal, frequency, duration, numOT, sampleRate, fileName) 
%go back into each file and have error for nyquist, for fundamental, not
%for overtones

%'sine' = sine wave 
%'triangle' = triangle wave 
%'cosine' = cosine 
%'square' = square wave 
%'saw' = sawtooth wave
%'white noise' = white noise 

%overtones (numOT) will not matter ffor white noise, sine, or cosine so use
%0 as placeholder.

%EXAMPLE:
%sigGen('sine',5,2,0,44100); 
%sine wave at 5Hz, 2 seconds, 0 overtones, 44100 sampling rate
%sigGen('sine',5,2,0,44100,'sine'); 
%sine wave at 5Hz, 2 seconds, 0 overtones, 44100 sampling rate, 'sine.wav'
%will be saved to your computer

%need to put ; at the end of argument to not have it spit out all the plots

%square and saw use pause so the user has to hit enter for all the
%overtones to go through them


switch signal
% switch-case (similiar to if-then) statement that says if you start
% sigGen, it will require these parameters...
    case ('sine')
        output = sineGen(frequency, duration, sampleRate, 0);
        % then if you want sine wave, type 'sine'
    case ('triangle')
        output = triGen(frequency, duration, numOT, sampleRate, 0);
        % then if you want triangle wave, type 'triangle'
    case ('saw')
        output = sawGen(frequency, duration, numOT, sampleRate, 0);
        % then if you want sawtooth wave, type 'saw'
    case ('square')
        output = squareGen( frequency, duration, numOT, sampleRate, 0);
        % then if you want square wave, type 'square'
    case ('cosine')
        output = cosGen( frequency, duration, numOT, sampleRate, pi/2);
        % then if you want cosine wave, type 'cosine'
    case {'white noise', 'white', 'noise'}
        output = noiseGen (duration, sampleRate);
        % then if you want white noise, type 'white noise' OR 'white' OR
        % 'noise'
        
    otherwise 
        
        error('invalid signal type. please choose from sine, triangle, saw, square, cosine, white noise, white, or noise');
        
        %if you mispell or type some other wave, will not recognize and
        %give that error message  

end

if nargin == 6
% if any of the above 6 arguments are satisfied with their parameters and
% the user types in file name at the end, then a wav file will be created
  
   wavwrite(output, sampleRate, fileName)
   %creates wave and takes the parameters, output, sampleRate, and the file
   %name that the user wanted. 
   %audiowrite(fileName, output, sampleRate)
   %^ alternate audio that was experimented with
   %wave of signal
end
   plot(output)
   %plotting 
  
end
