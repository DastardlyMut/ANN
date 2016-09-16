% numbers_train.m
% Author: Sean Devonport
% Train network on numbers data
%%
clc; clear; close all
%% Import and preprocess data:
load numbersdata.mat

% Read in numbers
P = [ number_0(:) number_1(:) number_2(:) number_3(:) number_4(:) number_5(:) number_6(:) number_7(:) number_8(:) number_9(:)];
No = [number_0 number_1 number_2 number_3 number_4 number_5 number_6 number_7 number_8 number_9];
p = repmat(P,1,25);

T=eye(size(P,2));
t = repmat(T,1,25);

%split into sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);
%% Train net
%create net
net=newff(p,t,[30, 30]);
net.divideFcn='';

%set goal>0
net.trainParam.goal=1e-8;
net=init(net);
[net,tr]=train(net,ptrain,ttrain);
numbernet=net;

%simulate
atrain=sim(numbernet,ptrain); %train
atest=sim(numbernet,ptest); %test
a=sim(numbernet,p); %all

%degree of fit
[r2, r] = correlation(a,t)
r2
r

save numbers_train.mat

disp('Please go to numbers_sim.m to test net with new input')


