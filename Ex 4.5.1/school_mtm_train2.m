%school_mtm_train2.m
%Author: Sean Devonport
%A script that uses a neural network to model school.txt data. Ex 4.5.1 [1]
%% Clean
clc
clear
close all

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

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Construct net and train net:

%network architecture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%         W1(s1Xr)          W2(s2Xs1)          W3(s3Xs2)
%  p(2Xq)---------->a1 ------------->a2----------->----->a3(s3Xq)
%         b1(s1X1)          b2(s2Xs1)          b3(s3Xs2)
%
%                   tansig          logsig          purelin

%number of neurons in each layer
s1=3;
s2=3;
s3=s;
%transfer functions
f1=@tansig;
f2=@logsig;
f3=@purelin;

%% Initiate Weights and bias
k=1; 
% initialise
W1(:,:,k)=randu(-1,1,s1,r);
b1(:,:,k)=randu(-1,1,s1,1);

W2(:,:,k)=randu(-1,1,s2,s1);
b2(:,:,k)=randu(-1,1,s2,1);

W3(:,:,k)=randu(-1,1,s3,s2);
b3(:,:,k)=randu(-1,1,s3,1);

E=[];
% learning rate and momentum
h1=0.005;
h2=0.95;
% Propagate pattern through net to obtain first values
%   select random index
for j=1:q1
% j = round(randu(1,q1));

    %get activations for pn
    n1=W1(:,:,k)*pn1(:,j)+b1(:,:,k);
    a1=f1(n1);
    n2=W2(:,:,k)*a1+b2(:,:,k);
    a2=f2(n2);
    n3=W3(:,:,k)*a2+b3(:,:,k);
    a3=f3(n3);
    an(:,j)=a3;

    % error for each pattern
    e(:,j)=t1(:,j)-an(:,j);

    % Compute sensitivities and derivative matrices
    %derivative matrices
    D3=eye(s3);
    D2=diag((1-a2).*a2);
    D1=diag(1-a1.^2);

    %sensitivites
    S3= -2*D3*e(:,j);
    S2= D2*W3(:,:,k)'*S3;
    S1= D1*W2(:,:,k)'*S2;

    % First update
    W3(:,:,k+1)=W3(:,:,k)-h1*S3*a2';
    b3(:,:,k+1)=b3(:,:,k)-h1*S3;

    W2(:,:,k+1)=W2(:,:,k)-h1*S2*a1';
    b2(:,:,k+1)=b3(:,:,k)-h1*S2;

    W1(:,:,k+1)=W1(:,:,k)-h1*S1*pn1(:,k)';
    b1(:,:,k+1)=b1(:,:,k)-h1*S1;
end

% Error for epoch
mse = sum(sum(e).^2)/q1;
% Accumulate error in vector
E(k)=mse;

%% Training parameters
%set tolerance (usually <1)
tol=1e-10;
maxit=24000;

%% Send patterns through net
while(mse>tol & k<maxit)
    %increment epoch counter
    k=k+1;
    %select random index
%     j = round(randu(1,q1));
    % run the batch
    for j=1:q1
        % propagate
        n1=W1(:,:,k)*pn1(:,j)+b1(:,:,k);
        a1=f1(n1);
        n2=W2(:,:,k)*a1+b2(:,:,k);
        a2=f2(n2);
        n3=W3(:,:,k)*a2+b3(:,:,k);
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
        S2= D2*W3(:,:,k)'*S3;
        S1= D1*W2(:,:,k)'*S2;

        %store sensitivities
        SS([1:s1],k-1,1) = S1;
        SS([s1+1:s1+s2],k-1) = S2;
        SS([s1+s2+1:s1+s2+s3],k-1) = S3;

        %update weights and biases
        W3(:,:,k+1)=W3(:,:,k)-h1*S3*a2'+h2*(W3(:,:,k)-W3(:,:,k-1));
        b3(:,:,k+1)=b3(:,:,k)-h1*S3 + h2*(b3(:,:,k)-b3(:,:,k-1));
        
        W2(:,:,k+1)=W2(:,:,k)-h1*S2*a1'+h2*(W2(:,:,k)-W2(:,:,k-1)) ;
        b2(:,:,k+1)=b2(:,:,k)-h1*S2 + h2*(b2(:,:,k)-b2(:,:,k-1));
        
        W1(:,:,k+1)=W1(:,:,k)-h1*S1*pn1(:,j)'+h2*(W1(:,:,k)-W1(:,:,k-1));
        b1(:,:,k+1)=b1(:,:,k)-h1*S1+h2*(b1(:,:,k)-b1(:,:,k-1));
    end
    
    %error for epoch
    mse = sum(sum(e).^2)/q1;

    E(k)=mse;
    
end

ds=input('display sensitivities? 1=yes 0=no ');
if ds==1
disp('The initial and final sensitivites are:')
SS(:,[1:10, end-10:end])
end

%scale up
a=diag(1./tff)*( an-repmat(tc,1,size(t1,2)));

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
% t12=t1(2,:);
% a12=a(2,:);
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
title('linear model: first semester');
hold off;

L21=rsq(t1(1,:),L1(1,:));
fprintf('Training: Linear fit Semester 1 %g\n',L21(1));


%save variables
save school_mtm_train.mat