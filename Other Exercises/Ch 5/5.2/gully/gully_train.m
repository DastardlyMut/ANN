% gully_train.m
% Author: Sean Devonport
% Script that implements sliding window approach on gully temperatures.
%%
clc;clear;close all

x=xlsread('Temperatures',1,'d2:d1874');

%view the data
figure
plot(x)
xlabel('time periods')
ylabel('temperature')

[p,t]=delay(x,150);
m=size(p,2);

%size of test set
n=150;

%     m-n             n
%<---train----><----test--->
%1,2,.........m-n,m-n+1,...m

%ttest index
ti=[m-n+1:m];
%training index
tri=[1:m-n];
%test set: last n
ptest=p(:,ti);
ttest=t(:,ti);
%train set
ptrain=p(:,tri);
ttrain=t(:,tri);

s1=10;
s2=10;

%network architecure
net=newff(ptrain,ttrain,[s1,s2]);

% Net training
net.TrainParam.epochs=1000;

% net.performfcn='msereg';
% net.performparam.ration=.7;
%training
net.trainFcn='trainscg';

net.trainParam.max_fail=40;

%initiate the weights and biases
net=init(net);

%train the net
[net,netstr]=train(net,ptrain,ttrain);

%rename
gullynet=net;

%activations
atrain=sim(net,ptrain);
atest=sim(net,ptest);
a=sim(net,p);

%degree of fit
r2=correlation(atest,ttest)
[R,pv]=corrcoef(ttest,atest)
figure
plot(ttest,ttest,ttest,atest,'.')
title('test')
figure
hold on
plot([1:length(atest)],ttest,'o')
plot([1:length(atest)],atest,'.')
hold off
title(sprintf('activation on test set'))

figure
%myfigureposition(pos2)
plot([1:length(a)],a,[1:length(a)],t,'o')
title('activalion on all')
save gully.mat