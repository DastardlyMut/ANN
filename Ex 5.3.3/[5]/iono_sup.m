% iono_sup.m
% Author: Sean Devonport
% Script that makes multiple neural nets and tests which has best
% performance for ionosphere problem.
%%
clc; clear; close all

data = importdata('iondata.txt');

p = [cos(2*pi*(data(:,1)/365)) sin(2*pi*(data(:,1)/365)) data(:,2) data(:,3)]';
t = data(:,4)';

[r,q]=size(p);

%network architecture
%layer sizes
S=[5:5:30];

%matrix to store the assessments
A=zeros(size(S,1),3);

for j=1:size(S,2)
    for i=1:size(S,2)
        close all
        s1=S(i);
        s2=S(j);

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

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %assessing the degree of fit
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Ar(i+1,1)=s1;
        Ar(1,j+1)=s2;
        Ar2(i+1,1)=s1;
        Ar2(1,j+1)=s2;
        
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
        % test:
        r2=rsq(ttest,atest);
        [R,PV]=corrcoef(ttest,atest);
        
        Ar(i+1,j+1)=R(1,2);
        Ar2(i+1,j+1)=r2;
        
        fprintf('Testing:\n\n')
        fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
        disp('----------------------------------------------------------------------')

        figure
        plot(ttest,ttest,ttest,atest,'*')
        title(sprintf('Testing: With %g samples s1=s2=%g\n',q,s1))
        %-------------------------------------------------

    end
end
%disp(' s1 r2 r')
fprintf('Corr coef on test set')
Ar
fprintf('R^2 value on test set')
Ar2