%energy_train.m
%Author: Sean Devonport
%Script that trains a net on the energy efficiency data. 
%%
clc;clear;close all
%%
data=xlsread('eneff.xlsx');

%section off data:
p=data(:,1:8);
t=data(:,9:10);
p=p';
t=t';

[r,q]=size(p);
% network architecture
% neurons in layers 1,2
% Based off supervisor script, I choose 30 neurons in first layer and 5 in
% second
s1=30; s2=5;

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
[net, netstruct]=train(net,p,t);

%name the net and structure
net.name='energy';
energynet=net;
energystruct=netstruct;

% save all the variables
save energy_train.mat

