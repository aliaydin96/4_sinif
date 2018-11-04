k=-8;
ak =zeros(1,17);
for n = 1:17
    ak(n) = (i/(k*pi))*(exp(-i*2*pi*k/3)-1);
    k=k+1;
end
k = -8:8;
ak(9) = 2/3;
figure;
stem(k, ak);
