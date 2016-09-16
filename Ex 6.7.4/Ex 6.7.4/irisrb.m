% iris2rb.m
% Author: Sean Devonport
% Script that uses an Radial Based Net to train on iris data
%%
clc; clear;close all
%% Load and preprocess data
%irisrbe
clc;clear;
%load and organise the data
D   = fopen('iris.dat');
P = textscan(D,'%f,%f,%f,%f,%s');

%input patterns p is 150 X 4
%patterns are the ROWS
%arrrange as cols
p=[P{1} P{2} P{3} P{4}]';
%targets t is 3 X 150
t=[repmat([1;0;0],1,50) repmat([0;1;0],1,50) repmat([0;0;1],1,50)];

%number of centers
m=20;

%training index: choose m centers randomly
tri=randperm(150);
tri=tri(1:m);

%test index
ti=setdiff([1:150],tri);

%training and test sets:
ptrain=p(:,tri);
ttrain=t(:,tri);
ptest=p(:,ti);
ttest=t(:,ti);

%max dist and spread
d=max(max(dist(ptrain',ptrain)))
ss=d*sqrt(log(2))/sqrt(m)

S=linspace(ss-.2,ss+.2,11);
C=[];
for s=S
    %form the net:
    net=newrb(ptrain,ttrain,0,s,m,1);
    
    %simulate
    atrain=sim(net,ptrain);
    atrain-ttrain;
    atest=sim(net,ptest);
    atest=round(atest);
    
    %assess
    %correct classifications on test set
    c=sum(all((atest-ttest)==0));
    
    %percentage correct
    pc=c/(150-m)*100;
    C=[C; s c pc];
end
disp('   spread   correct   %correct')
C
best=max(C)
pc=best(3);

%form the net:
net=newrb(ptrain,ttrain,0.3,s,m,1);

%simulate
atrain=sim(net,ptrain);
train_err=atrain-ttrain;
atest=sim(net,ptest);
atest=round(atest);
%assess
%correct classifications:
cc=sum(all(round(atest-ttest)==0));

%percentage correct
pc=cc/(150-m)*100
fprintf('percentage correct = %4.2f\n',pc)
%rounded = round(atest-ttest)

