% wine_train.m
% Author: Sean Devonport
% A script that makes a net to classify wine quality based on grape
% attributes.
%%
clc;close;clear all
%% Import and preprocess data
data=importdata('wine.data');

p = data(:,2:14)';
t = data(:,1)';

%% Create net
[r,q]=size(p);
% network architecture
% neurons in layers 1,2
s1=10; s2=20;

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
net.name='wine';
winenet=net;
winestruct=netstruct;

% save all the variables
save wine_train.mat
