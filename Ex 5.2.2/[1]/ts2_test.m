%ts2_test.m
%Author: Sean Devonport
%Script that tests the net.
%%
close all;clear all; clc
load ts2.mat

%training set
ptrain=p(:,ts2net.divideParam.trainInd);
atrain=sim(ts2net,ptrain);
ttrain=t(:,ts2net.divideParam.trainInd);
[atrain(:) ttrain(:)]
[r2 R]=correlation(atrain,ttrain,'train');
%test set
ptest=p(:,ts2net.divideParam.testInd);
atest=sim(ts2net,ptest);
ttest=t(:,ts2net.divideParam.testInd);
disp('atest ttest');
[atest(:) ttest(:)]
[r2 R]=correlation(atest,ttest,'test'); 