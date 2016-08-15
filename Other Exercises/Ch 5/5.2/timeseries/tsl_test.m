%tsl_test.m
%Author: Sean Devonport
%Script that tests the net.
%%
close all;clear all; clc
load ts1.mat

%training set
ptrain=p(:,ts1net.divideParam.trainInd);
atrain=sim(ts1net,ptrain);
ttrain=t(:,ts1net.divideParam.trainInd);
[atrain(:) ttrain(:)]
[r2 R]=correlation(atrain,ttrain,'train');
%test set
ptest=p(:,ts1net.divideParam.testInd);
atest=sim(ts1net,ptest);
ttest=t(:,ts1net.divideParam.testInd);
disp('atest ttest');
[atest(:) ttest(:)]
[r2 R]=correlation(atest,ttest,'test'); 

