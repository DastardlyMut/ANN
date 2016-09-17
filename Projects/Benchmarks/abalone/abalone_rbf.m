% abalone_rbf.m
% Author: Sean Devonport
% Script that train rbf net on abalone data.
%%
clc;clear;close all
%% Import and encode data:
data=fopen('abalone.data');
D=textscan(data,'%c,%f,%f,%f,%f,%f,%f,%f,%f');
D1=[];
for i=1:size(D{1},1)
    if D{1}(i) == 'M'
        D1=[D1; 2];
    elseif D{1}(i) == 'F'
        D1=[D1; 1];
    else
        D1=[D1;0];
    end
end
p=[D1 D{2} D{3} D{4} D{5} D{6} D{7} D{8}]';
t=D{9}';

%number of centers
m=round(size(p,2)*0.5);

%training index: choose m centers randomly
tri=randperm(size(p,2));
tri=tri(1:m);

%test index
ti=setdiff([1:size(p,2)],tri);

%training and test sets:
ptrain=p(:,tri);
ttrain=t(:,tri);
ptest=p(:,ti);
ttest=t(:,ti);

%max dist and spread
d=max(max(dist(ptrain',ptrain)))
ss=d*sqrt(log(2))/sqrt(m)

% S=linspace(ss-.2,ss+.2,20);
% C=[];
% for s=S
%     %form the net:
%     net=newrb(ptrain,ttrain,0.3,ss,m,1);
%     
%     %simulate
%     atrain=sim(net,ptrain);
%     atrain-ttrain;
%     atest=sim(net,ptest);
%     atest=round(atest);
%     
%     %assess
%     %correct classifications on test set
%     c=sum(all((atest-ttest)==0));
%     
%     %percentage correct
%     pc=c/(150-m)*100;
%     C=[C; s c pc];
% end
% disp('   spread   correct   %correct')
% C
% best=max(C)
% pc=best(3);

%form the net:
net=newrb(ptrain,ttrain,0.3,ss,m,1);

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

save abalone_rbf.mat