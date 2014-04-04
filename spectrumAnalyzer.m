%seori sachs 
%4.3.14

function stftMatrix = spectrumAnalyzer(audioFilename, windowLength, hopSize, windowType)

%put a short wav file in the directory of this to call upon
%'hanning' = hanning
%'hamming' = hamming 
%'blackman' = blackman 
%'bartlett' = bartlett
%'rectangle' = rectangle 

audioFilename = audioread(audioFilename);

%determination of mono or stereo 
channelSize = size (audioFilename);
%if the channel is stereo, produce a comma seperated list in order to make
%it mono 
if channelSize(2) == 2
    %making it mono
  stereo = audioFilename(:,1) + audioFilename (:,2);
  audioFilename = stereo ./ 2;
end


signalLength = length(audioFilename);

winNum = signalLength/(windowLength - hopSize);

%rounding window number up in case the hop number makes the window end
%before the actual number of windows
winNum = ceil(winNum);

% nzero padding for windows 
winSamples = winNum * (windowLength - hopSize);


if winSamples < signalLength

%????
endWindow = winSamples - hopSize;

%zeros left over
remainder = (endWindow + windowLength) - signalLength - 1; 


%fill in remainding window with zeros
audioFilename = [audioFilename ; zeros(remainder, 1)];
end

switch windowType
% spectrumAnalyzer will require these parameters    
    case {'rectangular', 'rectangle'}
        window = rectwin(windowLength);
        % could type 'rectangular' or 'rectangle'
    case ('hamming')
        window = hamming(windowLength);
    case ('hanning')
        window = hann(windowLength);
    case {'blackman', 'black'}
        window = blackman(windowLength);
    case ('bartlett')
        window = bartlett(windowLength);
end

start = 1;
%1 column
stftMatrix = zeros(windowLength, 1);

%starting column line
columnNum = 1;


%the amount that you get when you start with the first column, add the
%windowlength and minus 1 (for the end) should be equal to or less than the
%length of the of the audio file, then run this loop until it no longer is.
%Then it will run onto the next window.
while start + windowLength - 1 <= length(audioFilename)
   segment = audioFilename(start:start + windowLength - 1);
   windowedSignal = segment .* window;

   %need absolute value for the nyquist (hence the mirror image)
   signalFFT = abs(fft(windowedSignal));
   signalFFT = 20*log(signalFFT); 
   signalFFT = signalFFT/(sum(window)/2);
   stftMatrix(:, columnNum) = signalFFT;

   %accounting for the hop size and jumping over for the next window
   start = start + hopSize;
   columnNum = columnNum +1;
   
   

end


imagesc(stftMatrix);




end

