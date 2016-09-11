%ts5_train.m
%Author: Sean Devonport
%Script that uses MATlab newfftd on toy problem
%%
clc;clear;close all
load ts5seq.mat

%x(i) depends on two previous: x(i-1), x(i-2)
%so initial delay, id =[1 2]
%net is not trained on x(1), x(2) and there are no targets for x(1),x(2)
%r=length of initial delay vector
r=2;

%obtain sequential inputs
p=con2seq(x);
m=size(x,2);

%size of test set: the last n
n=10;

%ttest index
ti=[m-n:m];
%training index
tri=[1:m-n-1];

ptrain=p(tri);

net=newfftd(ptrain,ptrain,[1:r],[2, 2 ]);

%set goal>0 since there is no validation set
net.trainParam.goal=1e-8;
net=init(net);

%initial inputs which have no targets
pi=p([1:r]);

%train the net
net=train(net,ptrain,ptrain,pi);

%rename
ts5net=net;

save ts5.mat
