clc
clear all;
close all;


N=4;
t=0.01:0.01:1;
t1=0.01:0.01:N;
fs=1/3;


uc=gen(N,t);
us=gen(N,t);
p=length(uc);



figure;
subplot(2,1,1)
plot(uc)
title('4 bit stream (uc)')
xlabel('time index');
ylabel('amplitude');
axis([0 p -2 2])
grid on

subplot(2,1,2)
plot(us)
title('4 bit stream (us)')
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

%------Qpsk end------------



%-----down counter---with same carier frequency---

theta=pi/4;

ud1=up.*cos(40*pi*t1*fs+theta)*sqrt(2);

ud2=-up.*sin(40*pi*t1*fs+theta)*sqrt(2)



%-------low pass filter-------



Ts=0.25*length(t);
x3=ones(1,Ts);
%----
vc=0.05*conv(ud1,x3);
vs=0.05*conv(ud2,x3);



%-----before correction-------
figure;
subplot(2,1,1)
plot(uc)
axis([0 p -3 3])
hold on
plot(vc);
title('Vc down conversion when θ=pi/4')
legend('Vc signal','low pass filter output of Us,θ=pi/4');
xlabel('time index');
ylabel('amplitude');
axis([0 p -3 3])
grid on;
hold off;



subplot(2,1,2)
plot(us)
axis([0 p -3 3])
hold on
plot(vs);
title('Vs down conversion when θ=pi/4')
legend('Vs signal','low pass filter output of Us,θ=pi/4')
xlabel('time index');
ylabel('amplitude');
axis([0 p -3 3])
grid on;
hold off;

%----------theta--correction----------

uc1=(vc*cos(theta))-(vs*sin(theta));
us1=(vc*sin(theta))+(vs*cos(theta));

%--------after theta correction------------------
figure;
subplot(2,1,1)
plot(uc)
axis([0 p -3 3])
hold on
plot(uc1);
title('Uc after phase correction')
legend('input signal','low pass filter output');
xlabel('time index');
ylabel('amplitude');
axis([0 p -3 3])
grid on;
hold off;



subplot(2,1,2)
plot(us);
axis([0 p -3 3])
hold on
plot(us1);
title('Us after phase correction')
legend('input signal','low pass filter output');
xlabel('time index');
ylabel('amplitude');
axis([0 p -3 3])
grid on;
hold off;














% creating the uc and us function.

function out=gen(N,t)

p=length(t);

a1=rand(1,N)>=0.5;
b=0;
for i=1:N;
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
for i=1:N;
k=conv(h(i),x2);
d=[d k] ;  %modified +1,-1 stream

    
end
out=d;
end

