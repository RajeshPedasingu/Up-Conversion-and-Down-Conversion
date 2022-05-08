clc;
clear all;
close all;



N=4;
t=0.01:0.01:1;
t1=0.01:0.01:N;
fs=1/3;


uc=gen(N,t);
us=gen(N,t);
p=length(uc);



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
ud2=-up.*sin(40*pi*t1*fs+theta)*sqrt(2);




%-------low pass filter-------

Ts=0.25*length(t);
x3=ones(1,Ts);
%------------
vc=0.05*conv(ud1,x3);
vs=0.05*conv(ud2,x3);

%-----out put of low pass filter----------eyeballing-------
figure;

plot(uc)
axis([0 p -3 3])
hold on
plot(vc);
axis([0 p -3 3])
title('Uc Down converrsion when θ=pi/4')
xlabel('time index');
ylabel('amplitude');
legend('Uc signal','low pass filter output of UC,θ=pi/4');
grid on;
hold off;


figure;

plot(us)
axis([0 p -3 3])
hold on
plot(vs);
axis([0 p -3 3])
title('Us Down conversion when θ=pi/4')
legend('Us signal','low pass filter output of Us,θ=pi/4');
xlabel('time index');
ylabel('amplitude');
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

