%backpropdemo3a.m
%Author: Sean Devonport
%Script that implements the backprogation algorithm on a 
%3 layer neural network.
%%

clear 
clc
close all;

%generate inputs and targets
%input pattern
%generate inputs and targets
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
s1=3;
s2=2;
s3=s;
%transfer functions
f1=@logsig;
f2=@tansig;
f3=@purelin;

%% Initiate Weights and bias

W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);
W2=randu(-1,1,s2,s1);
b2=randu(-1,1,s2,1);
W3=randu(-1,1,s3,s2);
b3=randu(-1,1,s3,1);

%set tolerance (usually <1)
tol=.001;
h=.1;
%h=input('learning rate h= '); %learning rate

%% propogate p

maxit=140;
EE(1)=1;
k=1;

tic %timer

while(abs(EE(k))>tol & k<maxit)
    k=k+1;
    
    %get activations for p
    n1=W1*p+b1;
    a1=f1(n1);
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    
    %compute error
    e=t-a3;
    sse=sum(e.^2);
    EE(k)=sse;
    
    %derivative matrices
    D3=eye(length(a3));
    %D3=eye(s3);
    D2=diag(1-a2.^2);
    D1=diag((1-a1).*a1);
    
    %sensitivites
    S3= -2*D3*e;
    S2= D2*W3'*S3;
    S1= D1*W2'*S2;
    
    %update weights and biases
    W3=W3-h*S3*a2';
    b3=b3-h*S3;
    W2=W2-h*S2*a1';
    b2=b2-h*S2;
    W1=W1-h*S1*p';
    b1=b1-h*S1;
end

toc
%% Display Error and R^2 value

%remove first error
EE=EE(2:end);

disp('EE=');
disp(EE');

[R,pval] = corrcoef(a3,t);
rsq=R(1,2).^2;
disp('R^2 value =');
disp(rsq);

%% Plot p vs activations

x=linspace(0,2*pi,101);
y=3*sin(2*x)+1;

figure
plot(p,t,'o');
hold on;
plot(p,a3,'*');
plot(x,y);
hold off;
title(sprintf('activation vs targets r2 stat = %g\n',rsq));

%% Simulate and demonstrate 4.3.5 [3]

% simulate batch of new pattern inputs (for ex4.3.5 [3])
pbatch=[[0:pi/8:pi]' [0:pi/16:pi/2]' [0:pi/32:pi/4]' [0:pi/64:pi/8]'];

disp('new input patterns to be simulated on');
disp(pbatch);
vv=[];
EEs=[];
for l=1:size(pbatch,2)
    
    n1=W1*pbatch(:,l)+b1;
    a1=f1(n1);
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    vv=[vv a3];
  
    EEs=[EEs sum((t-a3).^2)];
end

disp('The errors of each new pattern');
disp(EEs);

figure
plot((1:1:size(pbatch,2)),EEs);
xlabel('every new input pattern');
ylabel('errors');
title('each new input patterns vs their error');

%% Let user simulate new pattern

repeat=input('Simulate more patterns? yes=1, no=0 ');
while(repeat==1)
    pnew=input('simulate a new 9x1 p = ');
    pbatch=[pbatch pnew];

    n1=W1*pnew+b1;
    a1=f1(n1);
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    v=2*sin(3*a3)+1;
    E = sum((t-a3).^2);
    EEs=[EEs E];
    
    disp('new pattern');
    disp(pnew);
    disp('activation');
    disp(a3);
    disp('error');
    disp(E);
    
    repeat = input('add another pattern? yes=1, no=0 ');
    if(repeat == 0)
        repeat=0;
        plot((1:1:size(pbatch,2)),EEs);
        xlabel('every new input patterns');
        ylabel('errors');
        title('each new input pattern vs their error');
    end
end