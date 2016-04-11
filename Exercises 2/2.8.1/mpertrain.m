%mpertrain.m
%Author: Sean Devonport - g12d0625
%A script that creates, trains and saves a multi-layer perceptron using
%MATLAB functions.
%%
%Define P and T:
P=[-.2 -.2 -.3 .2 .2 .3 .6 .7 .8 1.1 1.2 1.3; -.2 -.3 -.2 .2 .3 .2 .6 .8 .7 1.2 1.3 1.1];
T=[1 1 1 0 0 0 0 0 0 1 1 1];

%% Training for first layer of neurons.
T_1=[1 1 1 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 1 1 1]; %targets for intermediatary level.

%2 neurons in the first layer:
net1=newp([-.3 1.3;-.3 1.3],2);

%train first layer:
net1=train(net1,P,T_1);

W1=net1.iw{:}(1,:);
b1=net1.b{:}(1);
W12=net1.iw{:}(2,:);
b12=net1.b{:}(2);

%plot boundary lines:
hold on;
x=-3:3;
y=(-1)*(W1(1)*x)/W1(2)-(b1/W1(2));
y2=(-1)*(W12(1)*x)/W12(2)-(b12/W12(2));
plot(x,y,'b');
plot(x,y2,'b');

%1 neuron in layer 2:
net2=newp([0 1;0 1],1);

%train 2nd layer:
net2=train(net2,T_1,T);

%plot data set that the perceptron was trained on:
a=mpersim(P);

%save the net and other variables:
save C:\Users\TheBrick\Desktop\mpernet.mat