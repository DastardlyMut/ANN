% iono_train.m
% Author: Sean Devonport
% Script that trains on a net to find trend in foF2 values.
%%
clc; clear; close all

data = importdata('iondata.txt');
%%
p = [cos(2*pi*(data(:,1)/365)) sin(2*pi*(data(:,1)/365)) data(:,2) data(:,3)]';
t = data(:,4)';

% get training, test and validation sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

