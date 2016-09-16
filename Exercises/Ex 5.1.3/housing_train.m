% housing_train.m
% Author: Sean Devonport
% A script that implements a strategy for deploying neural nets on housing data.

% Based off results from supervisor script, I chose a neural net with 5
% neurons in each layer.
%%
% housing
clear 
close all
clc

load housing.mat
[r,q]=size(p);
% network architecture
% neurons in layers 1,2
s1=5; s2=5;

net=newff(p,t,[s1,s2]);
display(net)

% training
net.trainFcn='trainscg';

% maxit
net.trainParam.epochs=1000;

% set the number of epochs that the error on the validation set increases
net.trainParam.max_fail=20;

%If we want to set the ratio:
% net.divideParam.trainRatio=.7;
% net.divideParam.testRatio=.2;
% net.divideParam.valRatio=.1;

%We can also set using:
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

% initiate
net=init(net);

% train
[net, netstruct]=train(net,ptrain,ttrain);

%name the net and structure
net.name='housing';
housingnet=net;
housingstruct=netstruct;

% save all the variables
save housing_train.mat