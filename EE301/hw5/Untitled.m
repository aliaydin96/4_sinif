[xn, Fs] = audioread('hw5audio.wav');

%% Part a
%% Part i
k = 0:511;
xn_mag = abs(fft(xn, 512));
figure();
title("Magnitude of X[k]");
plot(k, xn_mag);

%% Part ii
a = find(xn_mag > 30)
%% Part b
%% Part i
k = -256:255;
xn_shift = fftshift(abs(fft(xn, 512)));

figure();
title("Magnitude of X[k]");
plot(k, xn_shift);
%% Part ii
%% There are six dominant frequency.

%% Part iii

w_axes = linspace(-Fs/2, Fs/2, 512);
figure();
title("Magnitude of X[k]");
plot(w_axes, xn_mag);
