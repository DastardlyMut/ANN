% housingrb.m
% Author: Sean Devonport
% Script that train a radial based net on housing data
%%
clc; clear; close all
%% Import and preprocess data
load housing.mat
%number of centers
m=size(p,2);
% 
%training index: choose m centers randomly
tri=randperm(506);
tri=tri(1:m);

%test index
ti=setdiff([1:506],tri);

%training and test sets:
ptrain=p(:,tri);
ttrain=t(:,tri);
ptest=p(:,ti);
ttest=t(:,ti);

%max dist and spread
d   = max(max(dist(p',p)));
s = d*sqrt(log(2))/sqrt(m);

%form the net:
net = newrb(ptrain,ttrain,0.01,s,m,1);
%% Degree of fit:
%simulate
atrain  = sim(net,ptrain);
atest   = sim(net,ptest);
atest   = round(atest,1);
a = sim(net,p);
a = round(a,1);

[r2,r]=correlation(a,t);
disp('degree of fit')
r2
r
%% Simulate:
disp('simulate')
p=importdata('housingpnew.txt')

anew = sim(net,p);
anew







