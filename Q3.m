clc
clear all;
close all;



N=4;
t=0.01:0.01:1;
t1=0.01:0.01:N;
fs=1/2;


uc=gen(N,t)
us=gen(N,t);
p=length(uc);

figure;
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
t1=0.01:0.01:N;
up=uc.*cos(40*pi*t1*fs);



%------bpsk end------------

%%--------Qpsk---------

up=sqrt(2)*uc.*cos(40*pi*t1*fs)-sqrt(2)*us.*sin(40*pi*t1*fs);
figure;
plot(up)
axis([0 p -3 3])
hold on
plot(uc,"r")

plot(us,"y")
title('Up converter')
xlabel('time index');
ylabel('amplitude');
legend('Up conversion','Uc signal','Us signal')
hold off

%------Qpsk end------------







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
h=b;
x2=ones(1,p);
d=[];% empty vector set
for i=1:N
k=conv(h(i),x2);
d=[d k] ;  %modified +1,-1 stream

    
end
out=d;
end

