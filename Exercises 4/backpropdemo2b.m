%backpropdemo2b.m
%Author: Sean Devonport
%Script that implements the back propogation on the 2 layer neural network.
%%

clear 
clc
close all;

%generate inputs and targets
%input pattern
p=[0:pi/4:2*pi]';
t=3*sin(2*p)+1;

[r, q]=size(p);
[s,q1]=size(t);

%check that number of examples are he same
if(q~=q1)
    error('different sample sizes');
end

%% Now we decide on network architecture

%number of neurons in each layer
s1=2;
s2=s;
%transfer functions
f1=@logsig;
f2=@purelin;
%learning rate
h=.1;

%% Initiate Weights and bias

W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);
W2=randu(-1,1,s2,s1);
b2=randu(-1,1,s2,1);

%set tolerance (usually <1)
tol=.001;

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
    n2=W2*a1+b2;
    a2=f2(n2);
    
    %compute error
    e=t-a2;
    sse=sum(e.^2);
    E(k)=sse;
    
    %derivative matrices
    D2=eye(length(a2));
%     D2=eye(s2);
    D1=diag((1-a1).*a1);
    
    %sensitivites
    S2= -2*D2*e;
    S1= D1*W2'*S2;
    
    %update 
    W2=W2-h*S2*a1';
    b2=b2-h*S2;
    W1=W1-h*S1*p';
    b1=b1-h*S1;
end

toc

%% Show Errors and R^2 value

%remove first error
E=E(2:end);

disp('EE=');
disp(E');

[R,pval] = corrcoef(a2,t);
rsq=R(1,2).^2;
disp('R^2 value =');
disp(rsq);

%% Plot

x=linspace(0,2*pi,101);
y=3*sin(2*x)+1;

figure
plot(p,t,'o');
hold on;
plot(p,a2,'*');
plot(x,y);
hold off;
title(sprintf('activation vs targets r2 stat = %g\n',rsq));

figure

%plot errors

plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n',tol));