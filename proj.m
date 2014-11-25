clear all;
clc;

Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = 15000;                     % Length of signal
t = (0:L-1)*T;                % Time vector
% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
x = 0.7*sin(2*pi*50*t) + 2*sin(2*pi*440*t); 

figure(1);
plot(Fs*t(1:50),x(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('time (milliseconds)')

[X, f] = fouriertransform(Fs, x);

% Plot single-sided amplitude spectrum.
figure(2);
plot(f,X) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')