%mpersim.m
%Author: Sean Devonport - g12d0625
%A function which loads the perceptron created by mpertrain.m and simulates
%on given input patterns using MATLAB functions.
%%
function a=mpersim(p)
load mpernet.mat

p=double(p);

a1=sim(net1,p);
a1=double(a1);
a=sim(net2,a1);

%identify inputs where a==1:
I=find(a==1);

%identify inputs where a==0:
J=find(a==0);

%plot points (a==1 is solid, a==0 is open):
close all;
hold on;
plot(p(1,I),p(2,I),'.b','markersize',15);
plot(p(1,J),p(2,J),'og');
%plot boundary lines:
x=-3:3;
y=(-1)*(W1(1)*x)/W1(2)-(b1/W1(2));
y2=(-1)*(W12(1)*x)/W12(2)-(b12/W12(2));
plot(x,y,'b');
plot(x,y2,'b');

