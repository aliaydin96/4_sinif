clear all,
close all;

% %Generate a lowpass filter with cutoff w=0.5pi rad. and length N=15 samples
 N=15;
 h=fir1(N-1,0.5);
 
 %Plot the frequency characteristics of the filter with a N=256 DFT
hg_m=(fft(h,256));
hg=abs(hg_m);
hg2=unwrap(phase(hg_m));


figure
plot((hg))
title('magnitude spectrum')
figure
plot(hg2)
title('phase spectrum')



n1=[0:256-1];
%Find the frequency where the magnitude spectrum is zero
[k1 k2]=min(hg);
M=k2-1;
Frequency_index=M
a=M/256*2*pi;
%Generate the sinusoid 
my_cos=cos(a*n1);

%Filter output and plot it
z=conv(my_cos,h);

figure
plot(z)
title('Complete Filter Output')


%Find the energy of h
my_energy=sum(h.*h)

