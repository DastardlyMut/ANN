%risk_test.m
%Author: Sean Devonport
%Uses risk_train.m net and propogates test data through.
%%
clc
clear close all

%load trained net.
load risk_train.mat

clear a an

%% simulate

for j=1:q2
    n1=W1*p2(:,j)+b1;
    a1=f1(n1);
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    a(:,j)=a3;
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
fprintf('Testing: Semester 1:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R1(1,2),PV1(1,2),r2(1));
disp('----------------------------------------------------------------------')

figure
plot(t21,t21,t21,a21,'*')
title(sprintf('Testing: Semester 1 with %g observations\n',q));