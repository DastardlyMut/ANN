% alphabet_train.m
% Author: Sean Devonport
% Script that trains on alphabet dataset
%%
clc; clear; close all
%% 
% generate alphabet
[P,T] = prprob;
p   = repmat(P,1,25);
% corrupt data
r   = randi([1,size(P,1)],1,size(p,2)-size(P,2));

for i = size(P,2)+1:size(p,2)
    if p(r(i-size(P,2)),i) == 0
        p(r(i-size(P,2)),i) = 1;
    else
        p(r(i-size(P,2)),i) = 0;
    end
end

%targets
t = repmat(T,1,25);

%split into sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

%create net
net=newff(p,t,[30, 25, 20]);
net.divideFcn='';

%set goal>0
net.trainParam.goal=1e-8;
net=init(net);
[net,tr]=train(net,ptrain,ttrain);
alphnet=net;
%% Degree of fit:
%simulate
atrain=sim(alphnet,ptrain); %train
atest=sim(alphnet,ptest); %test
a=sim(alphnet,p); %all

%degree of fit
[r2, r]= correlation(atest,ttest);
r2
r

save alphabet_train.mat