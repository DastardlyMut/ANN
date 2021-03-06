% wineqred_test.m
% Author: Sean Devonport
% Script that tests RBF net on data
%%
clc;clear;close all

load wineqred_rbf.mat
%% Run simulations:
atrain=sim(net,ptrain);
atest=sim(net,ptest);
a=sim(net,p);

%% Assessing Degree of Fit:
% train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);

fprintf('Testing:\n\n')
fprintf('  corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2);
disp('-------------------------------------------------------------')

figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples \n r2=%g',size(ttrain,2),r2))

%plot results
figure
x = 1:size(ttrain,2);
plot(x,ttrain,'bo',x,atrain,'r*');
ylabel('wine quality')
title('training activations')

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

%plot results
figure
x = 1:size(ttest,2);
plot(x,ttest,'bo',x,atest,'r*');
ylabel('wine quality')
title('testing activations')

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
title(sprintf('All: With %g samples \n r2=%g\n',size(p,2),r2))
display=input('display all activations? 1=yes,0=no');
if display == 1
    %To see the activations:
    disp('all')
    disp('activation      target')
    M=[a ;t];
    fprintf('%4.1f\t\t\t%4.1f\n',M)
end
disp('----------------------------------------------------------------------')

%plot results
figure
x = 1:size(ttest,2);
plot(x,ttest,'bo',x,atest,'r*');
ylabel('wine quality')
title('testing activations')