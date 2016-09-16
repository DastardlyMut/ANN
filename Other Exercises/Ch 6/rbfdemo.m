function rbfdemo
%demonstrates the 1-d rbf function
clear
clc

p=linspace(-10,10,101);
s=6;
w=4;
r=rbf(w,p,s);

p1=s;
r1=rbf(w,w+s,s);

close all
hold on
plot(p,r)
plot(p1,r1,'o')
plot(s,0,'.')

plot(w,0,'*')
title(sprintf('RBF with s=%5.4f w=%5.4f\n',s,w))
xlabel('p')
ylabel('rbf(p)')
hold off


