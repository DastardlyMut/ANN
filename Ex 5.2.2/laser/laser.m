% laser_train.m
% Author: Sean Devonport
% Trains a net on the pulse of a laser from data set laser.mat.
%%
clc;clear;close all

load laser.mat

[p,t]=delay(y,8);
m=size(p,2);

s1=2;
s2=2;

%network architecture
net=newff(p,t,[s1,s2]);

%size of test set: the last n
n=10;
%ttest index
ti=[m-n:m];

%training index
tri=[1:m-n-1];

%val index
vi=[];

net.divideFcn='divideind';
net.divideParam.trainInd=tri;
net.divideParam.testInd=ti;
net.divideParam.valInd=[];

%net.trainFcn=’trainscg’;
%set goal>0 since there is no validation set
net.trainParam.goal=1e-8;
%initiate the weights and biases
net=init(net);
%train the net
[net,tr]=train(net,p,t);
%rename
lasernet=net;

save laser_train.mat