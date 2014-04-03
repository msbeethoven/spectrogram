function stftMatrix = spectrumAnalyzer(audioFilename, windowLength, hopSize, windowType)



audioFilename = audioread(audioFilename);

%how many rows and columns to tell if file is stereo or mono
channelSize = size (audioFilename);
%does file have two channels?
if channelSize(2) == 2
  stereo = audioFilename(:,1) + audioFilename (:,2);
  audioFilename = stereo ./ 2;
end


signalLength = length(audioFilename);

windowNum = signalLength/(windowLength - hopSize);

%rounding window number down to <= audiofile
windowNum = floor(windowNum);

% number of windows that fits in a signal but needs to be zero padded
windowSamples = windowNum * (windowLength - hopSize);


if windowSamples < signalLength

%starting point of last window
lastWindow = windowSamples - hopSize;

%zero amount needed
remainder = (lastWindow + windowLength) - signalLength - 1; 


%fill in remainding window with zeros
audioFilename = [audioFilename ; zeros(remainder, 1)];
end

switch windowType
    
    case 'rectangular'
        window = rectwin(windowLength);
    case 'hamming'
        window = hamming(windowLength);
    case 'hanning'
        window = hann(windowLength);
    case 'blackman'
        window = blackman(windowLength);
    case 'bartlett'
        window = bartlett(windowLength);
end

start = 1;
stftMatrix = zeros(windowLength, 1);

columnNum = 1;

while start + windowLength - 1 <= length(audioFilename)
   segment = audioFilename(start:start + windowLength - 1);
   windowedSignal = segment .* window;

   signalFFT = abs(fft(windowedSignal));
   signalFFT = 20*log(signalFFT); 
   signalFFT = signalFFT/(sum(window)/2);
   stftMatrix(:, columnNum) = signalFFT;

   

   start = start + hopSize;
   columnNum = columnNum +1;
   
   

end


imagesc(stftMatrix);




end
    
        
  




















    





