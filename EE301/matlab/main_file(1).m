% Arithmetic Operations
A=randn(5,3);
B=rand(2,2);
A+B

A=randn(5,3);
B=0.75;
A+B

A=2*ones(3,2);
A.^3
B=[ 1 2 ; 3 4 ; 5 6];
A.^B

% Indexing Operations

x=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16;
  17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32;
  33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48;
  49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64];
x(:,2:3:end)
x(1:end-2,1:10:20)

% Logical Operations
a=-30;
b=20;
if (a<b)&&(abs(a)<b)
    disp('Both of the conditions are true')
else
    disp('At least one of the conditions is not true')
end

if (a<b)||(abs(a)<b)
    disp('At least one of the conditions is true')
else
    disp('Both conditions are not true')
end

% Flow Control
b=[];
for a=[ 1 4 9 16 25 36 49];
    b=[b sqrt(a)];
end
b


b=[];
for a=0:5:10000
    b=[b exp(a)];
    if a>50
        break 
    end
end
b

c=0;
while c<10
    c=c+1.2;
end
c
 while 1
     c=rand;
     if c<0.3
         c
     elseif c<0.5
         c+pi
     else
         break 
     end
 end
 % Sinusoidal Example
 t=0:0.01:1;
 N=length(t);
 xt=zeros(1,N);
 for n=1:N
     temp=0;
     for k=1:3
         temp=temp+(1/k)*sin(2*pi*k*t(n));
     end
     xt(n)=temp;
 end
 
 
 t=0:0.01:1;
 xt=zeros(1,length(t));
 for k=1:3
     xt=xt+(1/k)*sin(2*pi*k*t);
 end
 
 t=0:0.01:1;
 k=1:3;
 xt=(1./k)*sin(2*pi*k'*t);
 
 %Functions, Gibbs Phenomenon
T=1;
T1=0.25;
[x,t]=square_wave(0,T1,T);
plot(t,x);

for N=1:10:100
  hold on 
[x,t]=square_wave(N,T1,T);
plot(t,x);
end

% Sinusoidal signals
x=2*cos(pi/4*(0:99));
plot(0:99,x)
y=fft(x)
figure
plot(0:99,abs(y))
figure
plot(0:99,angle(y))

x=2*sin(pi/4*(0:119));
y=fft(x);
figure
plot(0:119,abs(y))


x=0.5*sin(pi/3*(0:119))+1.5*sin(pi/5*(0:119));
y=fft(x);
figure
plot(0:119,abs(y))

% Fourier Transform for real signals
x=[1 2 3 4 5 6 7 8]
fft(x)

% Complex Exponential Signals
j=sqrt(-1);
x=exp(j*pi/4*(0:119));
figure
plot(real(x))
figure
plot(imag(x))

x=exp((-0.05+j*pi/4)*(0:119));
figure
plot(0:119,real(x))

x=exp((0.05+j*pi/4)*(0:119));
figure
plot(0:119,real(x))

% Real Sinusoidal Signals vs. Complex Exponential Signals

x1=cos(pi/5*(0:99));
figure
plot(abs(fft(x1)))
x2=exp(j*pi/5*(0:99));
figure
plot(abs(fft(x2)))

% Basic Signal Transformations
x=[1 2 3 4 5 6];
figure
stem(x)
y=[zeros(1,3) x];
hold on
stem(y)

x=[1 2 3 4 5 6];
y=fliplr(x);
x
y

% Convolution in Time
x=[1 2 3 4 5 6];
h=[1 -1 2];
y=conv(x,h)

% Multiplication in Frequency
X=fft(x,128);
H=fft(h,128);
Y=X.*H;
ifft(Y)

% Lowpass Filtering
x=sin(2*pi/3*(0:119))+sin(pi/6*(0:119));
figure
plot(abs(fft(x)))
h=[1 1 1];
figure
plot(abs(fft(h,128)))
y=conv(x,h);
figure
plot(abs(fft(y,128)))

load handel
sound(y,Fs)
h=ones(1,25);
z=conv(y,h);
sound(z,Fs)
figure
plot(abs(fft(y)))
figure
plot(abs(fft(z)))

% Highpass Filtering
x=[1 2 3 4 5 6];
figure
plot(abs(fft(x,128)))

h=[1 -1 1];
figure
plot(abs(fft(h,128)))
y=conv(x,h);
figure
plot(abs(fft(y,128)))

load handel
sound(y,Fs)
h=ones(1,25);
h(2:2:end)=-1;
z=conv(y,h);
sound(z,Fs)
figure
plot(abs(fft(y)))
figure
plot(abs(fft(z)))

