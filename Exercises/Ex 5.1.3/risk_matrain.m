%risk_matrain.m
%Author: Sean Devonport
%A script that use a MATLAB neural network on the riskdata.txt Ex 5.1.3 [2]
%%
clc, clear, close all
%% Preprocess data:
headerlines = 1;
fmt = repmat('%f',1,5);
fid = fopen('riskdata.txt', 'rt');
data = textscan(fid, fmt, 'HeaderLines', headerlines, 'CollectOutput', 1);
fclose(fid);
data = cell2mat(data);

%Section off input patterns and targets. Dimension s x q
P=data(:,[1 2 3 4]);
T=data(:,5);

%arrange as rows
p=P';
t=T';

%check:
[r,q]=size(p);
[s,qt]=size(t);
if q ~= qt
    error('different batch sizes');
end

%% Net architecture and training
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=9; s2=9;

net=newff(p,t,[s1,s2]);

% training
net.trainFcn='trainscg';

% maxit
net.trainParam.epochs=1000;

% set the number of epochs that the error on the validation set increases
net.trainParam.max_fail=20;

%Set train,test and validation set
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

net=init(net);

[net,netstruct]=train(net,p,t);

% name net and structure
net.name='risknet';
risknet=net;
riskstruct=netstruct;

%save all variables
save risk_matrain.mat