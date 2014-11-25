function [ X, f ] = fouriertransform( Fs, x )
x = transpose(x);
L = size(x,2);                % Length of signal

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
X = fft(x,NFFT)/L;
X = 2*abs(X(1:NFFT/2+1));
f = Fs/2*linspace(0,1,NFFT/2+1);

end

