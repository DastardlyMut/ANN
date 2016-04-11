%mper2.m
%Author: Sean Devonport - g12d0625
%A script that creates, trains and saves a multi-layer perceptron using
%MATLAB functions
%%
%Define P and T:
P=[-.2 -.2 -.3 .2 .2 .3 .6 .7 .8 1.1 1.2 1.3;-.2 -.3 -.2 .2 .3 .2 .6 .8 .7 1.2 1.3 1.1];
T=[0 0 0 0 0 0 1 1 1 1 1 1;0 0 0 1 1 1 0 0 0 1 1 1];

%% Training for first layer of neurons.
T_1=[[0 0 0 1 1 1 1 1 1 1 1 1];[0 0 0 0 0 0 1 1 1 1 1 1];[0 0 0 0 0 0 0 0 0 1 1 1]];
%3 neurons in the first layer:
net1=newp([-.3 1.3;-.3 1.3],3);

%train first layer:
net1=train(net1,P,T_1);

%1 neuron in the 2nd layer:
net2=newp([[0 1];[0 1];[0 1]],2);

%train 2nd layer:
net2=train(net2,T_1,T);

%plot data set that the perceptron was trained on:
a=mper2sim(P);

save F:\Work\Maths\'Maths Hons'\ANN\'Exercises 2'\mper2net.mat