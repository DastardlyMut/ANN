% abalone_train.m
% Author: Sean Devonport
% Script that trains net on abalone dataset.
%%
clc; clear; close all
%% Import and encode data
data=fopen('abalone.data');

D=textscan(data,'%c,%f,%f,%f,%f,%f,%f,%f,%f');

D1=[];
for i=1:size(D{1},1)
    if D{1}(i) == 'M'
        D1=[D1; 2];
    elseif D{1}(i) == 'F'
        D1=[D1; 1];
    else
        D1=[D1;0];
    end
end
p=[D1 D{2} D{3} D{4} D{5} D{6} D{7} D{8}]';
t=D{9}';

%% Create net
[r,q]=size(p);
% network architecture
% neurons in layers 1,2
s1=25; s2=5; 
s3=5;s4=20;

net=newff(p,t,[s1,s2,s3,s4]);
display(net)

% training
net.trainFcn='trainscg';
%net.trainFcn='traingdm';

% gradient descent parameters
% net.trainParam.lr = 0.02;
% net.trainParam.mc = 0.85;

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
net.name='abalone';
abanet=net;
abastruct=netstruct;

% save all the variables
save abalone_train.mat