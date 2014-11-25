clear all;
clc;

% window for a 16th note
window = 4715;
start = 39250;
[x, Fs] = audioread('entertainer.mp3');
x = x(start:size(x,1),1);
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

[X, f] = fouriertransform(Fs, x);

% Plot single-sided amplitude spectrum.
figure(2);
plot(f,X) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')