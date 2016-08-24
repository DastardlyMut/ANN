%copper_train.m
%analysis of copper prices
%%
%1998-01-05 to 2001-07-31
%
close all; clear;clc
%copper prices: the list c
load copperprice.mat;
c=c(:)';

%days list (903)
m=length(c);

r=180;

p=con2seq(c);

%size of test set: the last n
n=30;
%ttest index
ti=[m-n:m];
%training index
tri=[1:m-n-1];

ptrain=p(tri);

net=newfftd(ptrain,ptrain,[1:r],[20, 20 ]);

%set goal>0 since there is no validation set
net.trainParam.goal=1e-2;
net=init(net);

%initial inputs which have no targets
pi=p([1:r]);

%train the net
net=train(net,ptrain,ptrain,pi);

%rename
coppernet=net;

save copper.mat