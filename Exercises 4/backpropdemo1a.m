%backpropdemo1a.m
%Author: Sean Devonport
%Script that implements the back propogation on a 1 layer neural network.
%%

clear 
clc
close all;
%%
%generate inputs and targets
%input pattern
p=[0:pi/4:2*pi]';
t=3*sin(2*p)+1;
% p=[3;-4;2];
% t=[3;-3];
% p=[1;-1;0.5];
% t=[1;-1];

[r, q]=size(p);
[s,q1]=size(t);

%check that number of examples are he same
if(q~=q1)
    error('different sample sizes');
end

%% Now we decide on network architecture

%number of neurons in each layer
s1=s;

%transfer function
f1=@tansig;

%learning rate
h=.1;

%% Initiate Weights and bias

W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);

%set tolerance (usually <1)
tol=.01;

%% Train the net
%counter
k=1;
maxit=100;
E(1)=1;

tic

while(abs(E)>tol & k<maxit)
    k=k+1;
    
    %get activations for p
    n1=W1*p+b1;
    a1=f1(n1);
    
    %compute error
    e=t-a1;
    sse=sum(e.^2);
    E(k)=sse;
    
    %derivative matrices
    D1=diag((1-a1.^2));
    
    %sensitivites
    S1= -2*D1*e;
    
    %update weights and biases
    W1=W1-h*S1*p';
    b1=b1-h*S1;
end

toc

%% Display errors and R^2 value

%remove first error
E=E(2:end);

disp('EE=');
disp(E');

[R,pval] = corrcoef(a1,t);
rsq=R(1,2).^2;
disp('R^2 value =');
disp(rsq);

%% Plot

% x=linspace(0,2*pi,101);
% y=3*sin(2*x)+1;
% 
% %plot function, input patterns and targets, and activations
% figure
% plot(p,t,'o');
% hold on;
% plot(p,a1,'*');
% plot(x,y);
% hold off;
% title(sprintf('activation vs targets r2 stat = %g\n',rsq));

%plot errors

figure
plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n',tol));