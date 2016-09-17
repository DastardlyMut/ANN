% abalonerbf_test.m
% Author: Sean Devonport
% Script that tests the Abalone RBF net.
%%
clc; clear; close all;
load abalone_rbf.mat

[~,q]=size(p)
q1=size(ptrain,2);
%
q2=size(ptest,2);

%simulate
atrain=round(sim(net,ptrain)); %train
atest=round(sim(net,ptest)); %test
a=round(sim(net,p)); %all

%% Assessing Degree of Fit
% train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);

fprintf('Testing:\n\n')
fprintf('  corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2);
disp('-------------------------------------------------------------')

figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples \n r2=%g',size(ttrain,2),r2))

%to see the activations:
display=input('display train activations?: 1=yes, 0=no');
if display == 1
    disp('train')
    disp('activation       target')
    M=[atrain ;ttrain];
    fprintf('%4.1f\t\t\t%4.1f\n',M)
end
disp('-------------------------------------------------------------')

% test:
r2=rsq(ttest,atest);
[R,PV]=corrcoef(ttest,atest);

fprintf('Testing: \n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')

figure
plot(ttest,ttest,ttest,atest,'*')
title(sprintf('Testing: With %g samples \n r2: %g\n',size(ttest,2),r2))
%To see the activations:
display=input('display activations? 1=yes, 0=no');
if display == 1
    disp('test')
    disp('activation      target')
    M=[atest ;ttest];
    fprintf('%4.1f\t\t\t%4.1f\n',M)
end
disp('----------------------------------------------------------------------')

% all
r2=rsq(t,a);
[R,PV]=corrcoef(t,a);
fprintf('Testing:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(t,t,t,a,'*')
title(sprintf('All: With %g samples \n r2=%g\n',q,r2))
display=input('display all activations? 1=yes,0=no');
if display == 1
    %To see the activations:
    disp('all')
    disp('activation      target')
    M=[a ;t];
    fprintf('%4.1f\t\t\t%4.1f\n',M)
end
disp('----------------------------------------------------------------------')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%
%MATLAB post regression functions
r=postreg(a,t);
rtest=postreg(atest,ttest);
rtrain=postreg(atrain,ttrain);

disp('MATLAB postregression')
disp('-----------------------')
fprintf('train r=%g\n',rtrain)
fprintf('test r=%g\n',rtest)
fprintf('all r=%g\n',r)

%MATLAB regression plotting functions:
plotregression(ttest,atest)
title('test')
plotregression(ttrain,atrain)
title('train')
plotregression(t,a)
title('all')

%save all variables
save abarbf_test.mat