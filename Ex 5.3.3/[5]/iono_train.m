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

s1=30;
s2=15;
s3=10;

%create the net
net=newff(ptrain,ttrain,[s1,s2 s3]);

%display(net)

%training
net.trainFcn='trainscg';

%maxit
net.trainParam.epochs=800;
net.trainParam.goal = 1e-6;

%set the number of epochs that the error on the validation set
%increases
net.trainParam.max_fail=20;

%We can also set using:
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

%initiate
net=init(net);

%train
[net,netstruct]=train(net,ptrain,ttrain);

%name the net and structure
net.userdata='iono';
iononet=net;
ionostruct=netstruct;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
q1=size(ptrain,2);
%using our own hand-made net:
q2=size(ptest,2);
%simulate
atrain=sim(iononet,ptrain); %train
atest=sim(iononet,ptest);   %test
a=sim(iononet,p);           %all

%degree of fit
disp('Train r and R values')
r2=rsq(ttrain,atrain)
[R,pv]=corrcoef(ttrain,atrain)

disp('Test r2')
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

%plot results
% training
x = 1:size(ttrain,2);
plot(x,ttrain,'bo',x,atrain,'r*');
xlabel('day')
ylabel('FoF2 level')
title('Results')
legend('Train Targets','Train Activations')

x = 1:size(ttest,2);
plot(x,ttest,'bo',x,atest,'r*');
xlabel('day')
ylabel('FoF2 level')
title('Results')
legend('Test Targets','Test Activations')

