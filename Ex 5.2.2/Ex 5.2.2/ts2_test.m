%ts2_test.m
%Author: Sean Devonport
%Script that tests the net.
%%
close all;clear all; clc
load ts2.mat

%training set
ptrain=p(:,ts2net.divideParam.trainInd);
atrain=sim(ts2net,ptrain);
a = sim(ts2net,p);
ttrain=t(:,ts2net.divideParam.trainInd);
disp('atrain     ttrain');
[atrain(:) ttrain(:)]

[r2 R]=correlation(atrain,ttrain,'train');

disp('r2 and R value for train set')
r2
R
%test set
ptest=p(:,ts2net.divideParam.testInd);
atest=sim(ts2net,ptest);
ttest=t(:,ts2net.divideParam.testInd);
disp('atest     ttest');
[atest(:) ttest(:)]
[r2 R]=correlation(atest,ttest,'test');

disp('r2 and R value for test set')
r2
R

% Plots
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
plot([1:length(a)],a,[1:length(a)],t,'o')
title('activation on all')