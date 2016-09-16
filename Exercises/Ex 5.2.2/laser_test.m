% laser_test.m
% Author: Sean Devonport
% Script that tests laser on test segment of length 10.
%%
clc; clear; close all

load laser_train.mat

%training set
ptrain=p(:,lasernet.divideParam.trainInd);
atrain=sim(lasernet,ptrain);
ttrain=t(:,lasernet.divideParam.trainInd);
[atrain(:) ttrain(:)]
[r2 R]=correlation(atrain,ttrain,'train');

disp('r2 and R value for train set')
r2
R

%test set
ptest=p(:,lasernet.divideParam.testInd);
atest=sim(lasernet,ptest);
ttest=t(:,lasernet.divideParam.testInd);
disp('atest ttest');
[atest(:) ttest(:)]
[r2 R]=correlation(atest,ttest,'test'); 

disp('r2 and R value for test set')
r2
R

% Whole set
a=sim(net,p);
disp('atest ttest');
[a(:) t(:)]
[r2 R]=correlation(a,t,'test'); 

disp('r2 and R value for test set')
r2
R

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