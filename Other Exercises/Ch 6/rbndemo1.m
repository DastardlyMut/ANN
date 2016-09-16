%rbndemo1
clear
clc

m=input('number of patterns= ');

fprintf('input patterns and targets:\n');

p(1,:)=linspace(0,pi,m);
p(2,:)=linspace(pi/2,pi+pi/2,m);
p

%construct targets for toy problem
t=sin(p.^2+p.^3/10);
t=disturb(t,5)

s2=size(t,1);
pause

fprintf('The number of patterns = %d \n',m);
pause

s1=input('Number of centres = ');
fprintf('\n s1=%g : the number of neurons in the rad bas layer\n',s1)
pause

fprintf('\n indices of  centres\n');
I=randperm(m);
I=I(1:s1)
pause

%the centres
c=p(:,I);

disp('centres as rows of c:');
c=c'
pause

fprintf('\n compute distances between centres and patterns\n');
d=dist(c,p)
pause

s=max(max(d));

fprintf('\n spread=max(max(d))=%g the max distance between centres and patterns\n',s);
pause

fprintf('\n biases in s1 X m matrix\n');
b=sqrt(log(2))/s;
B=repmat(b,s1,m)
pause

fprintf('\n input into radbas function:\n')
n=B.*d
pause

fprintf('\n activation from radbas function \n a1=.5 when d(c,p)=s\n')
a1=radbas(n)
pause

fprintf('augment a1 with a row of 1s\n')
A1=[a1;ones(1,size(a1,2))]

fprintf('Solve for optimal W using W=t/A1\n')
W=t/A1
pause

fprintf('Extract w2 and b2 from W\n')
%w2 has bias in last column
w2=W(:,1:end-1)
b2=W(:,end)
pause

fprintf('\n compare a2 with t\n')

fprintf('final activation when rad bas layer has s1 = %g neurons\n',s1)
a2=W*A1

%equivalently
%a2=w2*a1+repmat(b2,1,size(t,2))

%targets
t
