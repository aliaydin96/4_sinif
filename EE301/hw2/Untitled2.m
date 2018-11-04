t = linspace(-10,10);
k1=0;
w0= 2*pi/3;

x = ak(9)*exp(i*k1*w0*t);


m=8;
xsum = 0;
for k1=-m:m
    x = ak(k1+9) * exp(i*(k1)*w0*t);
    xsum = xsum + x;
end
plot(t,xsum);
grid on; 
title('Up to 8th Harmonic Components');
xlabel('time');
ylabel('Xm(t)');