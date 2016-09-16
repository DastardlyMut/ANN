% interprbe1.m
% Author: Sean Devonport
% Script that makes a radial based net to find holes in data.
%%
clc;clear;close all

data=importdata('interprbe1data.txt');
p=data.data(1,:);
t=data.data(2,:);

%%
%test index
m=size(p,2);
I=randperm(m);
ti=I(1:floor(m/5))

%training index
tri=setdiff([1:m],ti);

%training and test sets:
ptrain=p(:,tri);
ttrain=t(:,tri);
ptest=p(:,ti);
ttest=t(:,ti);

d=dist(p',p);
dm=max(max(d))
fprintf('max distance between inputs = %4.2f\n',dm)

%sr=input(’spread range = [min, max] =  ’);
sr=[50,70];
%% Train:
%use this procedure to find the best spread:
%matrix for storing spread and r
R=[];
for s=sr(1):0.1:sr(2)
    %train on training set
    net=newrbe(ptrain,ttrain,s);
    %simulate on test set
    atest=sim(net,ptest);
    [r2,r]=correlation(atest,ttest);
    R=[R;[s r2 r]];
end

disp('  spread      r2          r')
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R')

%% Find training stats:
% find the best spread with r2 stat
[mr2,i]=max(R(:,2));
bs2=R(i,1);

% simulate with best spread
net = newrbe(ptrain,ttrain,bs2);
a   = sim(net,p);
[r2,r]=correlation(a,t);


% simulate on continuous data
pcon = linspace(0,10,101);
acon = sim(net,pcon);

% find the value at 6
a6 = sim(net,6);
%% Plot:
figure
hold on
plot(p,t,'ob',pcon,acon,'b',6,a6,'*r');

hold off
title(sprintf('mixing s=%4.2f\n y(6)=%4.2f',bs2,a6))
xlabel('targets')
ylabel('activation')