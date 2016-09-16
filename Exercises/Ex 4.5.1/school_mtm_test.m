%school_mtm_test.m
%Author: Sean Devonport
%Uses school_mtm_train.mat net and propogates test data through.
%%
clc
clear close all

%load trained net.
load school_mtm_train.mat

clear a an

%% simulate
for j=1:q2
    a(:,j) = schoolmtmnet(pn2(:,j));
end

%%

M=[t2;a];
disp('targets          activations');
fprintf('%4.2f \t%4.2f \t%4.2f \t%4.2f\n',M);

t21=t2(1,:);
a21=a(1,:);

%assessing the degree of fit
r2=rsq(t2(1,:),a(1,:));
[R1,PV1]=corrcoef(a(1,:),t2(1,:));
fprintf('Testing: % obtained in first year:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R1(1,2),PV1(1,2),r2(1));
disp('----------------------------------------------------------------------')

figure
plot(t21,t21,t21,a21,'*')
title(sprintf('Testing: percentage obtained in first year with %g observations in total\n',q));