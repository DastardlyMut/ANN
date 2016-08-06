% cancer_train.m
% Author: Sean Devonport
% Script that deploys net on cancer data.
%%
clear
close all
clc

D=importdata('cancer_data.txt');
%%
raw_data=D(:,[2:11]);

dsize = size(raw_data);
row=dsize(1);
col=dsize(2);
%% Preprocess
% clean data
mean = mean(mean(D(:,6),'omitnan'));
for i=1:row
    if isnan(raw_data(i,6))
       raw_data(i,6)=mean; 
    end
end 

% preprocess
p=raw_data(:,1:9);
t=raw_data(:,10);
% organise patterns and targets
p=p'; t=t';

% change 2(benign) to 1 and 4 (malignant) to -1
t (t==2)=1;
t(t==4)=-1;
m=size(p,2);

%% Net architecture and training
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=20;
s2=20;

net=newff(p,t,[s1,s2]);
net=init(net);
[net,tr]=train(net,p,t);

% rename
cancernet=net;
%save all info
save cancerdata.mat




