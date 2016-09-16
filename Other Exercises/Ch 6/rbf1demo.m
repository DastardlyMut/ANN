function rbf1demo
%demonstrates the 1-d rbf function
clear
clc

x=linspace(-5,5,101);
s=1;
w=0;
y=rbf(w,x,s);

close all
hold on
plot(x,y)
plot(w,0,'*')
title(sprintf('RBF with s=%5.4f w=%5.4f\n',s,w))
xlabel('x')
ylabel('rbf(x)')
hold off

grid

