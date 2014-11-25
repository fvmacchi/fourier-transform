clear all;
clc;

window = 4450;
start = 40000;
[s, Fs] = audioread('entertainer.mp3');
x = s(40000:40000+window,1);
T = 1/Fs;                     % Sample time
L = size(x,1);                     % Length of signal
t = (0:L-1)*T;                % Time vector
% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid

figure(1);
plot(Fs*t,x)

xlabel('time (milliseconds)')

[X, f] = fouriertransform(Fs, x);

% Plot single-sided amplitude spectrum.
figure(2);
plot(f,X) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')