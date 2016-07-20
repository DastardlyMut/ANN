%backpropdemo3.m
%Script that demos the back propogation algorithm. Using toy data from a
%known function.
%%

clear 
clc
close all;

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
%learning rate
h=.1;

%% Initiate Weights and bias

W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);
W2=randu(-1,1,s2,s1);
b2=randu(-1,1,s2,1);
W3=randu(-1,1,s3,s2);
b3=randu(-1,1,s3,1);

%set tolerance (usually <1)
tol=.001;

%% Send p repeatedly through the net
%counter
k=1;
maxit=100;
E(1)=1;

while(abs(E(k))>tol & k<maxit)
    k=k+1;
    
    %propagate through the net
    n1=W1*p+b1;
    a1=f1(n1);
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    
    %compute error
    e=t-a3;
    sse=sum(e.^2);
    E(k)=sse;
    
    %derivative matrices
    D3=eye(s3);
    D2=diag(1-a2.^2);
    D1=diag((1-a1).*a1);
    
    %sensitivites
    S3= -2*D3*e;
    S2= D2*W3'*S3;
    S1= D1*W2'*S2;
    
    %update
    W3=W3-h*S3*a2';
    b3=b3-h*S3;
    
    W2=W2-h*S2*a1';
    b2=b2-h*S2;
    
    W1=W1-h*S1*p';
    b1=b1-h*S1;
end

%remove first error
E=E(2:end);

%% Plot

figure

%plot errors

plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n',tol));

[R,pval] = corrcoef(a3,t);
rsq=R(1,2).^2;

%compare with function
x=linspace(0,2*pi,101);
y=3*sin(2*x)+1;

figure
plot(p,t,'o');
hold on;
plot(p,a3,'*');
plot(x,y);
hold off;
title(sprintf('activation vs targets r2 stat = %g\n',rsq));

%simulate on another input of the same size
u=input('simulate on another 9X1 input: x =');
u=u(:);

%produce activation
a1=f1(n1);
n2=W2*a1+b2;
a2=f2(n2);
n3=W3*a2+b3;
v=f3(n3);
w=2*sin(3*v)+1;

%compare
disp('new activation and function value');
disp([v w(:)]);

figure
plot(p,t,'o');
hold on
plot(u,v,'*');
plot(x,y)
hold off;
title(sprintf('new activation and tarets \n'));




