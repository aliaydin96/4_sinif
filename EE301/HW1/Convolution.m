y= [1,2,3,2,2,1]; % input signal
indexy=[-2 -1 0 1 2 3 ]; % index of signal
h=[1,5,10,11,8,4,1]; % impulse response 
figure(1);
stem(indexy,y);
title('input signal');
grid on;
xlim([-5,5]);
figure(2)
stem(h);
title('impulse response');
grid on;


lenConv= length(h)+length(y); % length of convolution sum
Conv=[]; % output of signal

for i=1:lenConv;
    sum=0;
        for j=1:length(y);
        
            if i-j>0 && i-j<(length(h)+1)
            sum= sum+ h(i-j)*y(j);
            end
        
        end
    Conv=[ Conv sum];
       
end


indexConv=[];

for i=1:lenConv
    indexConv= [indexConv ,(indexy(1)+i-2)];

end

figure(3);
stem(indexConv, Conv);
title('Convolution Signal');
xlim([-4 11]);
grid on;
