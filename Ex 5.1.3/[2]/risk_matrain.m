%risk_matrain.m
%Author: Sean Devonport
%A script that use a MATLAB neural network on the riskdata.txt Ex 5.1.3 [2]
%%
clc, clear, close all
data=importdata('riskdata.txt');
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
s1=20;
s2=20;

net=newff(p,t,[s1,s2]);
net=init(net);
[net,tr]=train(net,p,t);

% rename
risknet=net;
%save all variables
save riskdata.mat