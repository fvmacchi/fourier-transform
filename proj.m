clear all;
clc;

% window for a 16th note
window = 4725;
start = 39250;
[x, Fs] = audioread('entertainer.mp3');
x = x(start:size(x,1)/4,1);
T = 1/Fs;                     % Sample time
L = size(x,1);                % Length of signal
t = (0:L-1)*T;                % Time vector

windows = square(t/window*Fs*pi)*0.4;

figure(1);
plot(x);
hold on;
plot(windows, 'r');
hold off;
%plot(Fs*t,x)

xlabel('time (milliseconds)')

notes = [];
amplitudes = [];
for k = 0:size(x,1)/window-2
   sample = x(window*k+1:window*(k+1),:);
   l = size(sample,1);
   [X, f] = fouriertransform(Fs, sample);
   [sampleNotes, sampleAmplitudes] = findnotes(X, f);
   columns = size(sampleNotes, 2) - size(notes,2);
   if(columns > 0)
       notes = [notes zeros(size(notes,1), columns)];
       amplitudes = [amplitudes zeros(size(notes,1), columns)];
   elseif(columns < 0) 
       sampleNotes = [sampleNotes zeros(1, -columns)];
       sampleAmplitudes = [sampleAmplitudes zeros(1, -columns)];
   end
   notes = [notes; sampleNotes];
   amplitudes = [amplitudes; sampleAmplitudes];
end

music = zeros(size(notes,1)*window, 1);
t = (0:window-1)*T;
for i = 1:size(notes,1)
    wave = zeros(window,1);
    for k = 1:size(notes,2)
        if(notes(i,k) == 0)
            break;
        end
        wave = wave + transpose(amplitudes(i,k)*sin(2*pi*notes(i,k)*t));
    end
    music((i-1)*window+1:i*window) = wave;
end
figure(2)
plot(music)

audiowrite('transcribed.wav',music, Fs);