% risk_test.m
% Author: Sean Devonport
% Script that sees how well the net did.
%%
clear all
close all
clc
load energy_train.mat

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1=size(ptrain,2);
%
q2=size(ptest,2);

%simulate
atrain=sim(energynet,ptrain); %train
atest=sim(energynet,ptest); %test
a=sim(energynet,p); %all

%% Assessing Degree of Fit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);

fprintf('Train Cooling load:\n\n')
fprintf('  corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2);
disp('-------------------------------------------------------------')

figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples \n',q))
disp('train')
disp('activation       target')

%to see the activations:
M=[atrain ;ttrain];
fprintf('%4.1f\t\t\t%4.1f\n',M)
disp('-------------------------------------------------------------')

% test:
r2=rsq(ttest,atest);
[R,PV]=corrcoef(ttest,atest);

fprintf('Testing: \n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')

figure
plot(ttest,ttest,ttest,atest,'*')
title(sprintf('Testing: With %g samples \n',q))
% %To see the activations:
% disp('test')
% disp('activation      target')
% M=[atest ;ttest];
% fprintf('%4.1f\t\t\t%4.1f\n',M)
% disp('----------------------------------------------------------------------')

%all
r2=rsq(t,a);
[R,PV]=corrcoef(t,a);
fprintf('All:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(t,t,t,a,'*')
title(sprintf('All: With %g samples \n',q))
% %To see the activations:
% disp(�all�)
% disp(�activation      target�)
% M=[a ;t];
% fprintf(�%4.1f\t\t\t%4.1f\n�,M)
% disp('----------------------------------------------------------------------')

% plot
x=1:size(t,2);
figure
plot(x,t(1,:),'ob',x,a(1,:),'*r');
xlabel('patterns')
ylabel('heating load')
title('heating load for all patterns')
figure
plot(x,t(2,:),'ob',x,a(2,:),'*r');
xlabel('patterns')
ylabel('cooling load')
title('cooling load for all patterns')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%
%MATLAB post regression functions
figure
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
plotregression(t,a)
title('train')
plotregression(t,a)
title('all')

%MATLAB performanc plots
plotperform(netstruct)

%save all variables
save energy_test.mat