% cancer_test.m
% Author: Sean Devonport
% Script that deploys net on cancer data.
%%

clear; clc; close all
load cancerdata.mat

%train set
ttrain=t(:,tr.trainInd);
ptrain=p(:,tr.trainInd);
atrain=sim(cancernet,ptrain);

%test set
ttest=t(:,tr.testInd);
ptest=p(:,tr.testInd);
atest=sim(cancernet,ptest);

%validation set
tval=t(:,tr.valInd);
pval=p(:,tr.valInd);
aval=sim(cancernet,pval);

[r2train, Rtrain] = correlation(atrain,ttrain)

[r2test, Rtest] = correlation(atest,ttest)

%compare:
[atrain' ttrain'];

%compare:
[atest' ttest'];

%make diagnosis
atest=hardlims(atest);
[atest' ttest'];

%find accuracy
%number correct
nc=sum(atest==ttest);

%percentage correct
pc=nc/length(ttest)*100;

fprintf('percentage accuracy is %5.2f\n',pc)

at=(atest+1)/2;
tt=(ttest+1)/2;
plotconfusion(at,tt);



