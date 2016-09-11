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
%test set
ptest=p(:,lasernet.divideParam.testInd);
atest=sim(lasernet,ptest);
ttest=t(:,lasernet.divideParam.testInd);
disp('atest ttest');
[atest(:) ttest(:)]
[r2 R]=correlation(atest,ttest,'test'); 