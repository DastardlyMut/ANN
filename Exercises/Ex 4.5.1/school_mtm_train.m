%school_mtm_train.m
%Author: Sean Devonport
%A script that constructs a neural net with a momentum factor
%%
clc
clear
clear all
%% Preprocess data:
data=importdata('school.txt');

%Section off input patterns and targets. Dimension s x q
P=data(:,[1 2]);
T=data(:,3);

%arrange as rows
p=P';
t=T';

%check:
[r,q]=size(p);
[s,qt]=size(t);
if q ~= qt
    error('different batch sizes');
end

%% Scale down:
%Normalize data
pM = max(p')';
pm = min(p')';
pf = 2./(pM-pm);
pc = -(pM+pm)./(pM-pm);
Dp = diag(pf);
pn = Dp*p+repmat(pc,1,size(p,2));

tM = max(t')';
tm = min(t')';
tff = 2./(tM-tm);
tc = -(tM+tm)./(tM-tm);
Dt = diag(tff);
tn = Dt*t+repmat(tc,1,size(t,2));

%Set indices (2/3 of original set 1/3 Testing set). 
I1=randperm(floor(2*q/3));
q1=length(I1);
I2 = setdiff([1:q],I1);
q2 = length(I2);

%Partitions
p1 = p(:,I1);
t1 = t(:,I1);

t2 = t(:,I2);
p2 = p(:,I2);

%Partitions (normalized)
pn1 = pn(:,I1);
tn1 = tn(:,I1);

tn2 = tn(:,I2);
pn2 = pn(:,I2);
%% Construct net and train net:

%network architecture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%         W1(s1Xr)          W2(s2Xs1)          W3(s3Xs2)
%  p(2Xq)---------->a1 ------------->a2----------->----->a3(s3Xq)
%         b1(s1X1)          b2(s2Xs1)          b3(s3Xs2)
%
%                   tansig          logsig          purelin

%% Initiatilze architecture
%number of neurons in each layer
s1=9;
s2=9;
s3=s;
%transfer functions
f1=@tansig;
f2=@logsig;
f3=@purelin;

%% First values
W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);
W2=randu(-1,1,s2,s1);
b2=randu(-1,1,s2,1);
W3=randu(-1,1,s3,s2);
b3=randu(-1,1,s3,1);

% Propogate through net and obtain first error
k=1; % counter
h1=0.005; % learning rate
h2=0.95; % momentum

E=[];
SS=[];
for j=1:q1
    %get activations for pn
    n1=W1*pn1(:,j)+b1;
    a1=f1(n1);
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    an(:,j)=a3;

    %compute error
    e(:,j)=tn1(:,j)-an(:,j);

    %derivative matrices
    D3=eye(s3);
    D2=diag((1-a2).*a2);
    D1=diag(1-a1.^2);

    %sensitivites
    S3= -2*D3*e(:,j);
    S2= D2*W3'*S3;
    S1= D1*W2'*S2;
    
    %update weights and biases
    W3=W3-h1*S3*a2';
    b3=b3-h1*S3;
    W2=W2-h1*S2*a1';
    b2=b2-h1*S2;
    W1=W1-h1*S1*pn1(:,j)';
    b1=b1-h1*S1;
    
    W3o = W3;
    b3o = b3;
    W2o = W2;
    b2o = b2;
    W1o = W1;
    b1o = b1;
end

% Compute first error
mse = sum(sum(e).^2)/q1;

E(k)=mse;

%set tolerance (usually <1)
tol=1e-9;
maxit=800;


%% Send patterns through net with momentum
while(mse>tol && k<maxit)
    %increment epoch counter
    k=k+1;
    % Send batch through net
    for j=1:q1
    %get activations for pn
        n1=W1*pn1(:,j)+b1;
        a1=f1(n1);
        n2=W2*a1+b2;
        a2=f2(n2);
        n3=W3*a2+b3;
        a3=f3(n3);
        an(:,j)=a3;

        %compute error
        e(:,j)=tn1(:,j)-an(:,j);

        %derivative matrices
        D3=eye(s3);
        D2=diag((1-a2).*a2);
        D1=diag(1-a1.^2);

        %sensitivites
        S3= -2*D3*e(:,j);
        S2= D2*W3'*S3;
        S1= D1*W2'*S2;

        %store sensitivities
        SS([1:s1],k-1,1) = S1;
        SS([s1+1:s1+s2],k-1) = S2;
        SS([s1+s2+1:s1+s2+s3],k-1) = S3;

        %update weights and biases
        W3n=W3-h1*S3*a2'+h2*(W3-W3o);
        b3n=b3-h1*S3 + h2*(b3-b3o);
        
        W2n=W2-h1*S2*a1'+h2*(W2-W2o);
        b2n=b2-h1*S2 + h2*(b2 - b2o);
        
        W1n=W1-h1*S1*pn1(:,j)' + h2*(W1-W1o);
        b1n=b1-h1*S1 + h2*(b1-b1o);
        
        W3o = W3;
        b3o = b3;
        W2o = W2;
        b2o = b2;
        W1o = W1;
        b1o = b1;
        W3 = W3n;
        b3 = b3n;
        W2 = W2n;
        b2 = b2n;
        W1 = W1n;
        b1 = b1n;
    end
    
    %error for epoch
    mse = sum(sum(e).^2)/q1;

    E(k)=mse;
end

%scale up
a=diag(1./tff)*( an-repmat(tc,1,size(t1,2)));

%%
ds=input('display sensitivities? 1=yes 0=no ');
if ds==1
disp('The initial and final sensitivites are:')
SS(:,[1:10, end-10:end])
end

%% assessing the degree of fit

%Rˆ2 statistic
r2=rsq(t1(1,:),a(1,:));

%corrcoeff
[R1,PV1]=corrcoef(a(1,:),t1(1,:));
fprintf('Training: Percentage obtained in first year:\n\n');
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R1(1,2),PV1(1,2),r2(1));
disp('----------------------------------------------------------------------')

%% Plots

t11=t1(1,:);
a11=a(1,:);
%plot error (performance function)
close all
E=E(1:end);
plot(E);
title('MSE')
figure
hold on
plot(t11,t11)
plot(t11,a11,'*')
title(sprintf('Training: Percentage obtained in first year with %g samples\n',q));
hold off

%% Compare with Linear Model
disp('Compare with Linear Model');

%find M such that || Mp - t || is a minimum
M=t/p;

%activate using M
L=M*p;
L1=L(:,I1);

figure
hold on
plot(t11,t11);
plot(t11,L1(1,:),'*');
title('linear model: % obtained in first year');
hold off;

L21=rsq(t1(1,:),L1(1,:));
fprintf('Training: Linear fit Semester 1 %g\n',L21(1));

%save variables
save school_mtm_train.mat