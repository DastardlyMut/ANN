%interp1
%interpolates the sine function
%uses a linear combination  of rbfs
clear
clc

%generate data: 5 data point
p=linspace(0,pi,5)';
t=sin(p);

%spread and bias
s=1;
b=sqrt(log(2))/s;

%compute F
for j=1:length(p)
    n=b*abs((p-p(j)));
    F(:,j)=exp(-n.^2);%F(:,j)=f_j(p)
end
%show F
F
%solve for c
c=F\t

%activation on data points
a=F*c;

%compare:
[t a]

%plot
x=linspace(0,2*pi,101)';
for j=1:length(p)
    n=b*abs((x-p(j)));
    FF(:,j)=exp(-n.^2); %F(:,j)=f_j(t)
end

%activation on x
y=FF*c;

%sine values outside training set
X=[pi:pi/10:2*pi];
T=sin(X);
%plot to compare
close all
hold on
plot(x,y)
plot(p,t,'o')
plot(p,a,'*')
plot(X,T,'+')
plot([0 ;2*pi],[0 ;0])
hold off
title(sprintf('Interpolation with RBFs  s=%5.4f\n',s))



