%backprop1.m
%Author: Sean Devonport
%Script that continues updating process in 4.3.2
%%

clc
close all
clear all

%input pattern
p=[.5;.2;.1];

%target
t=[1.5;.8];

%initialize wights and biases randomly between [-1;1]
W1=randu(-1,1,2,3);
b1=randu(-1,1,2,1);
W2=randu(-1,1,2,2);
b2=randu(-1,1,2,1);

f1=@tansig;
f2=@logsig;

%compute activations through network

n1=W1*p+b1;
a1=f1(n1);
n2=W2*a1+b1;
a2=f2(n2);

%compute error

EE(1)=sum((t-a2).^2);

%% Train the net
% repeat process
h=input('learning rate h= '); %learning rate
tol=0.3; %tolerance of Error.
maxit=140;
k=2;

while(abs(EE(k-1))>tol && k<maxit)
    
    n1=W1*p+b1;
    a1=f1(n1);
    n2=W2*a1+b1;
    a2=f2(n2);
    
    %compute error
    EE(k)=sum((t-a2).^2);
    
    %compute derivative matrices
    
    D2=diag((1-a2).*a2);
    D1=diag(1-a1.^2);
    
    %compute sensitivities.
    S2=-2*D2*(t-a2);
    S1=D1*W2'*S2;

    %update weights and biases

    W2=W2-h*S2*a1';
    b2=b2-h*S2;
    W1=W1-h*S1*p';
    b1=b1-h*S2;
    
    %update counter
    
    k= k+1;
end

%%
%Plot
figure

%plot errors

plot(EE);
xlabel('iterations');
ylabel('Errors');
title(sprintf('Performance with tolerance = %g\n',tol));


%%
%Display
disp('EE=');
disp(EE');

%simulate
pnew=input('simulate on new p = ');

n1=W1*pnew+b1;
a1=f1(n1);
n2=W2*a1+b1;
a2=f2(n2);

disp(pnew);
disp('the activation is:');
disp(a2);

plot((1:(k-1)),EE);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance tol=%g',tol));


