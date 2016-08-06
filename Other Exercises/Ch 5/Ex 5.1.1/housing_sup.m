% housing_sup.m
% Author: Sean Devonport
% Supervising script for housing_train.m
%%
clear
close all
clc

load housing.mat
[r,q]=size(p);
%network architecture
%layer sizes
S=[1:50];

%matrix to store the assessments
A=zeros(size(S,1),3);

for i=1:size(S,2)
    close all
    s1=S(i);
    s2=s1;
    
    %create the net
    net=newff(p,t,[s1,s2]);
    
    %display(net)
    
    %training
    net.trainFcn='trainscg';
    
    %maxit
    net.trainParam.epochs=100;
    
    %set the number of epochs that the error on the validation set
    %increases
    net.trainParam.max_fail=20;
    
    %We can also set using:
    [ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
    [ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);
    
    %initiate
    net=init(net);
    
    %train
    [net,netstruct]=train(net,p,t);
    
    %name the net and structure
    net.userdata='housing';
    housingnet=net;
    housingstruct=netstruct;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%
    q1=size(ptrain,2);
    %using our own hand-made net:
    q2=size(ptest,2);
    %simulate
    atrain=sim(housingnet,ptrain); %train
    atest=sim(housingnet,ptest);   %test
    a=sim(housingnet,p);           %all
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %assessing the degree of fit
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    A(i,1)=s1;
    %train
    r2=rsq(ttrain,atrain);
    [R,PV]=corrcoef(ttrain,atrain);
    
    fprintf('Training:\n\n')
    fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
    disp('----------------------------------------------------------------------')
    
    figure
    plot(ttrain,ttrain,ttrain,atrain,'*')
    title(sprintf('training: With %g samples s1=s2=%g\n',q,s1))
	%------------------------------------------------------------------
    
    %test:
    r2=rsq(ttest,atest);
    [R,PV]=corrcoef(ttest,atest);
    A(i,2)=r2;
    A(i,3)=R(1,2);
    fprintf('Testing:\n\n')
    fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
    disp('----------------------------------------------------------------------')

    figure
    plot(ttest,ttest,ttest,atest,'*')
    title(sprintf('Testing: With %g samples s1=s2=%g\n',q,s1))
    %-------------------------------------------------
    
end

disp(' s1 r2 r')
A