function wave = whiteGen(varargin)
%OSCILLATOR generates a standard waveform, click train, or noise
% OSCILLATOR(wavetype,duration,frequency)
%
% Input arguments:
%
%   wavetype (string):
%    'Sinusoid'
%    'Triangle'
%    'Square'
%    'Sawtooth'
%    'Reverse Sawtooth'
%    'Linear Sweep'
%    'Log Sweep'
%    'Click Train'
%    'White Noise'
%    'Pink Noise'
%    'Brown Noise'
%    'Blue Noise'
%    'Violet Noise'
%    'Grey Noise'
%    'Speech Noise'
%
%   duration (in seconds)
%   frequency (in Hz)
%       NOTE: linear and log sweeps require [start stop] frequency vector
%
% Optional input arguments:
%  OSCILLATOR(wavetype,duration,frequency,gate,phase,sample_freq) THIS IS
%  IMPORTANT. CHANGE VARIABLE NAMES!!!!! 
%   gate (in seconds): duration of a raised cosine on/off ramp
%   phase (in radians): starting phase of the waveform.
%   sample_rate (in samples): 44100 is default, custom rates are possible
%
% Examples:
%
%   wave = OSCILLATOR('Sinusoid',1,1000); % simple pure tone at 1000 Hz.
%   wave = OSCILLATOR('Sawtooth',2,440); % 2 second sawtooth at 440 Hz.
%   wave = OSCILLATOR('Pink Noise',1); % 1 second of pink (1/F) noise
%   wave = OSCILLATOR('Linear Sweep',2,[440 880]); % linear sweep from 440 to 880 Hz.
%   wave = OSCILLATOR('Log Sweep',2,[20 20000],.01); % ramped on/off log sweep.
%   wave = whiteGen('White Noise',1,[],0.1); %ramped on and off noise
%   wave = OSCILLATOR('Sinusoid',1,220,0,pi/2,48000); %pure tone with a
%            starting phase of 90 degrees and sample rate set to 48000.
%


%input handling:
switch nargin,
    case 0, wavetype='Sinusoid';duration=1;frequency=440;gate=0;phase=0;sample_rate=44100;
    case 1, wavetype=varargin{1};duration=1;frequency=440;gate=0;phase=0;sample_rate=44100;
    case 2, wavetype=varargin{1};duration=varargin{2};frequency=440;gate=0;phase=0;sample_rate=44100;
    case 3, wavetype=varargin{1};duration=varargin{2};frequency=varargin{3};gate=0;phase=0;
        sample_rate=44100;
    case 4, wavetype=varargin{1};duration=varargin{2};frequency=varargin{3};gate=varargin{4};
        phase=0;sample_rate = 44100;
    case 5, wavetype=varargin{1};duration=varargin{2};frequency=varargin{3};gate=varargin{4};
        phase=varargin{5};sample_rate = 44100;
    case 6, wavetype=varargin{1};duration=varargin{2};frequency=varargin{3};gate=varargin{4};
        phase=varargin{5};sample_rate = varargin{6};
    otherwise, error('incorrect number of input arguments');
end

%for noise, frequency is likely omitted or 0, set to default to avoid error:
if isempty(frequency) || any(frequency==0), frequency=1;end

%start input checking:
if ~isstr(wavetype),
    error('1st argument ''wavetype'' must be a string.')
end

if ~isnumeric(duration) || numel(duration) ~= 1 || duration < 0 || ~isreal(duration),
    error('2nd argument ''duration'' must be a single positive number.')
end

if ~isnumeric(frequency) || ~ismember(numel(frequency),[1 2]) || sum(frequency <= 0) || ~isreal(frequency) || sum(frequency>=sample_rate/2),
    error('3rd argument ''frequency'' must be 1 or 2 (for sweeps) positive numbers less than or equal to the Nyquist.')
end

if ~isnumeric(gate) || numel(gate) ~= 1 || gate < 0  || ~isreal(gate) || 2*gate>duration,
    error('optional 4th argument ''gate'' must be a positive number less than or equal to half the duration.')
end

if ~isnumeric(phase) || numel(phase) ~= 1 || ~isreal(phase),
    error('optional 5th argument ''phase'' should be a single number between -2pi and 2pi.')
end

if ~isnumeric(sample_rate) || numel(sample_rate) ~= 1 || sample_rate < 0 || ~isreal(sample_rate),
    error('optional 6th argument ''sample_rate'' must be a single positive number.')
end

if numel(frequency)>1,
    if ~any(strcmpi(wavetype,{'log sweep','linear sweep'})),
        error('For signals apart from sweeps, ''frequency'' must be 1 positive number.')
    end
else
    if any(strcmpi(wavetype,{'log sweep','linear sweep'})),
        error('For swept sine signals, ''frequency'' must be 2 positive numbers.')
    end
end
%end input checking

num_samples = floor(sample_rate*duration);%duration in samples
phase = mod(phase,2*pi)/(2*pi); %phase rescaled from 2*pi to 1

switch lower(wavetype), %generate the chosen waveform:
        
    case {'white noise','white','noise'},
        % use rand to create noise, wave is then normalized to a max of 1:
        wave = 2*(rand(num_samples,1)-0.5);wave = wave./max(abs(wave));
        soundsc(wave)
        plot(wave)
        
    otherwise,
        display('Unrecognized waveform type');wave = [];return
end

if gate>0,
    % create the raised cosine ramp:
    t = linspace(0,pi/2,floor(sample_rate*gate))';
    gate = (cos(t)).^2;
    % ramp the beginning of the signal on:
    wave(1:length(gate)) = wave(1:length(gate)).*flipud(gate);
    % ramp the end of the signal off:
    wave(end-length(gate)+1:end) = wave(end-length(gate)+1:end).*gate;
end






