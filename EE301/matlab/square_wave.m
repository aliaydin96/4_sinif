function [x,t]=square_wave(N,T1,T);
cj=sqrt(-1);
t=-T/2:T/1000:T/2;
x=2*T1/T*ones(size(t));
for k=1:N
    x=x+sin(2*pi*k*T1/T)/(k*pi)*exp(cj*k*2*pi/T*t)+sin(-2*pi*k*T1/T)/(-k*pi)*exp(-cj*k*2*pi/T*t);
end

end