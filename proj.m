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
for k = 0:15
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
