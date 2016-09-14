% housingrb.m
% Author: Sean Devonport
% Script that train a radial based net on housing data
%%
clc; clear; close all
%% Import and preprocess data
load housing.mat
%data=importdata('housingpnew.txt');

%number of centers
m=250;

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

% %max dist and spread
% d   = max(max(dist(ptrain',ptrain)));
% s = d*sqrt(log(2))/sqrt(m);
% 
% %form the net:
% net = newrb(ptrain,ttrain,0.01,s,m,1);
% 
% %simulate
% atrain  = sim(net,ptrain);
% atest   = sim(net,ptest);
% atest   = round(atest,1);
% 
% %assess
% %correct classifications:
% cc  = sum(all((atest-ttest)==0));
% 
% %percentage correct
% pc  = cc/(506-m)*100;
% fprintf('percentage correct = %4.2f\n',pc)

%max dist and spread
d=max(max(dist(ptrain',ptrain)))
ss=d*sqrt(log(2))/sqrt(m)

S=linspace(ss-.2,ss+.2,5);
C=[];
for s=S
    %form the net:
    net=newrb(ptrain,ttrain,0.01,s,m,1);
    
    %simulate
    atrain=sim(net,ptrain);
    atrain-ttrain;
    atest=sim(net,ptest);
    atest=round(atest);
    
    %assess
    %correct classifications on test set
    c=sum(all((atest-round(ttest))==0));
    
    %percentage correct
    pc=c/(150-m)*100;
    C=[C; s c pc];
end
disp('   spread   correct   %correct')
C
best=max(C)
pc=best(3);

% %form the net:
% net=newrb(ptrain,ttrain,0.3,s,m,1);

% %simulate
% atrain=sim(net,ptrain);
% train_err=atrain-ttrain;
% atest=sim(net,ptest);
% atest=round(atest);
% %assess
% %correct classifications:
% cc=sum(all(round(atest-ttest)==0));

%percentage correct
% pc=cc/(150-m)*100
fprintf('percentage correct = %4.2f\n',pc)
%rounded = round(atest-ttest)

