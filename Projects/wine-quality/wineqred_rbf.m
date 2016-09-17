% wineqred_train.m
% Author: Sean Devonport
% A script that makes a net to classify wine quality based on grape
% attributes.
%%
clc;close;clear all
%% Import and preprocess data
data=importdata('winequality-red.csv');
headers=data.colheaders;
D=data.data;

p = D(:,1:11)';
t = D(:,12)';

[~,q]=size(p);
%number of centers
m=q;

%training index: choose m centers randomly
tri=randperm(1599);
tri=tri(1:m);

%test index
ti=setdiff([1:1599],tri);

%training and test sets:
ptrain=p(:,tri);
ttrain=t(:,tri);
ptest=p(:,ti);
ttest=t(:,ti);

%max dist and spread
d=max(max(dist(ptrain',ptrain)))
ss=d*sqrt(log(2))/sqrt(m)

S=linspace(ss-.1,ss+.1,20);
C=[];

%form the net:
net=newrb(ptrain,ttrain,0.01,ss,m,1);

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
%% Test net:
%simulate
atrain=sim(net,ptrain);
train_err=atrain-ttrain;
atest=sim(net,ptest);
atest=round(atest);
a=sim(net,p)
%assess
%correct classifications:
[r2, r]=correlation(a,t)
disp('degree of fit: ');
r2
r

save wineqred_rbf.mat