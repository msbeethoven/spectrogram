%seori sachs
%4.17.14

function outputSignal = convolver(irFilename, signalFilename, convType)


% setting variables 

%ImpulseResponse = any wav file there is assigned as impulse response
ImpulseResponse = audioread(irFilename);
% signal = any wav file there is assigned as signal 
signal = audioread(signalFilename);
%to make it mono
ImpulseResponse = sum(ImpulseResponse,2)/2;

%ERROR CHECKING

%These three statements check to see if the first three inputs are valid
if ~ischar(irFilename)
    error('"irFilename" must be a string!')
end

if ~ischar(signalFilename)
    error('"signalFilename" must be a string!')
end

%fast conv
switch convType 
    case 'fast'
    %output = fastConv(ImpulseReponse,signal)
    %ImpulseResponse = audioread(irFilename);
    %signal = audioread(signalFilename);
    %monoized. sum adds takes a matrix, it will add either row by row or column
    %by column. we want row. divide by 2 to avoid clippig.the second number
    %after comma indicates row. (1 would be column) 
    %ImpulseResponse = sum(ImpulseResponse,2)/2;

    sigLen= length(signal);
    irLen = length(ImpulseResponse);

    %zero pad
    signal = [signal; zeros(irLen-1,1)];
    ImpulseResponse = [ImpulseResponse; zeros(sigLen-1, 1)];

    %it's automatically rectangular window sonormalize by depending by half 
    SIGNAL = fft(signal);%/ (length(signal)/2);
    IMPULSERESPONSE = fft(ImpulseResponse);% / (length(ImpulseResponse)/2);

    %multiply ffts together
    OUTPUT = SIGNAL .* IMPULSERESPONSE;
    %ifft
    outputSignal = ifft(OUTPUT);

    case 'direct'
        irLen = length(ImpulseResponse);
        sigLen = length(signal);
        
        
        %Matrix of rows and length of convolved signal
        convMatrix = zeros(irLen,irLen + sigLen - 1);
        
        %starting index
        shift = 1
        
        for n = 1 : irLen;
            
            for j = 1 : sigLen;
       %Within this loop the variable n is used to index the n'th sample
       %of the output file.  The loop variable t indexes the t'th
       %sample of the impulse response being convolved.      
                convMatrix(n,shift) = ImpulseResponse(n) * signal(j);
                shift = shift + 1;
            end
            
            shift = n+1;

            
        end
        outputSignal = sum(convMatrix);
end
%sound
soundsc(outputSignal, 44100)



end

