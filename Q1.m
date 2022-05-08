clc
clear all;
close all;



N=10;
t=0.01:0.01:1;



uc=gen(N,t)
us=gen(N,t);
p=length(uc);


subplot(2,1,1)
plot(uc)
title('10 bit stream (uc)')
xlabel('time index');
ylabel('amplitude');
axis([0 p -2 2])
grid on

subplot(2,1,2)
plot(us)
title('10 bit stream (us)')
xlabel('time index');
ylabel('amplitude');
axis([0 p -2 2])
grid on

%%--------bpsk---------




function out=gen(N,t)

p=length(t);

a1=rand(1,N)>=0.5;
b=0;
for i=1:N
    if a1(i)==0
        b(i)=-1;
    else
        b(i)=1;% +1,-1 stream
    end
end
%--------------
h=b
x2=ones(1,p);
d=[]% empty vector set
for i=1:N
k=conv(h(i),x2);
d=[d k] ;  %modified +1,-1 stream

    
end
out=d;
end

