data=importdata('winequality-white.csv');
headers=data.colheaders;
D=data.data;

p = D(:,1:11)';
t = D(:,12)';
%% Create net
[r,q]=size(p);
% network architecture
% neurons in layers 1,2
s1=100; s2=50;s3=10;s4=1;

net=newff(p,t,[s1,s2]);
display(net)

% training
net.trainFcn='traingdm';

% maxit
net.trainParam.epochs=1000;

% set the number of epochs that the error on the validation set increases
net.trainParam.max_fail=20;

% Set training, testing and validation sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

% initiate
net=init(net);

% train
[net, netstruct]=train(net,ptrain,ttrain);

%name the net and structure
net.name='wineqwhite';
wineqwhinet=net;
wineqwhistruct=netstruct;

% save all the variables
save wineqwhite_train.mat