%momentumnet.m
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
%% Initiatilze architecture
%number of neurons in each layer
s1=9;
s2=9;
s3=s;
%transfer functions
f1=@tansig;
f2=@logsig;
f3=@purelin;

k=1;
W1(:,:,k)=randu(-1,1,s1,r);
b1(:,:,k)=randu(-1,1,s1,1);
W2(:,:,k)=randu(-1,1,s2,s1);
b2(:,:,k)=randu(-1,1,s2,1);
W3(:,:,k)=randu(-1,1,s3,s2);
b3(:,:,k)=randu(-1,1,s3,1);

% Propogate through net and obtain first error
h1=0.05; % learning rate
h2=1; % momentum

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
    e(:,j)=t1(:,j)-an(:,j);

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
    W3=W3-h1*S3*a2';
    b3=b3-h1*S3;
    W2=W2-h1*S2*a1';
    b2=b2-h1*S2;
    W1=W1-h1*S1*pn1(:,j)';
    b1=b1-h1*S1;
end

mse = sum(sum(e).^2)/q1;

E(k)=mse;
%% Training parameters

%set tolerance (usually <1)
tol=1e-15;
maxit=16000;

E=[];
SS=[];
%h=input('learning rate h= '); %learning rate

%% Send patterns through net with momentum
while(mse>tol & k<maxit)
    %increment epoch counter
    k=k+1;
    %select random index
%     j = round(randu(1,q1));

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
        e(:,j)=t1(:,j)-an(:,j);

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
        W3(:,:,k+1)=W3(:,:,k)-h1*S3*a2'+h2*(W3(:,:,k)-W3(:,:,k-1));
        b3(:,:,k+1)=b3(:,:,k)-h1*S3 + h2*(b3(:,:,k)-b3(:,:,k-1));
        
        W2(:,:,k+1)=W2(:,:,k)-h1*S2*a1'+h2*(W2(:,:,k)-W2(:,:,k-1));
        b2(:,:,k+1)=b2(:,:,k)-h1*S2 + h2*(b2(:,:,k) - b2(:,:,k-1));
        
        W1(:,:,k+1)=W1(:,:,k)-h1*S1*pn1(:,j)' + h2*(W1(:,:,k)-W1(:,:,k-1));
        b1(:,:,k+1)=b1(:,:,k)-h1*S1 + h2*(b1(:,:,k)-b1(:,:,k-1));
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
EE=EE(1:end);
plot(EE);
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
title('linear model: first semester');
hold off;

L21=rsq(t1(1,:),L1(1,:));
fprintf('Training: Linear fit Semester 1 %g\n',L21(1));

%save variables
save momentrain.mat