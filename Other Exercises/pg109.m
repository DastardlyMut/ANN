%pg109.m
%Script that goes through activations using transfer functions Eq 4.3.2
%%

%input pattern
p=[.5;.2;.1];

%target
t=[1.5;.8];

%initialize wights and biases randomly
W1=randu(0,1,2,3);
b1=randu(0,1,2,1);

W2=randu(0,1,2,2);
b2=randu(0,1,2,1);

f1=inline('tansig(n)');
f2=inline('logsig(n)');

%compute activations through network

n1=W1*p+b1;

a1=f1(n1);

n2=W2*a1+b1;

a2=f2(n2);

%compute error

E(1)=sum((t-a2).^2);

%compute derivative matrices
D2=[(1-a2(1))*a2(1) 0;
    0 (1-a2(2))*a2(2)];

D1=[1-a1(1)^2 0 ;
    0 1-a1(2)^2];

%compute sensitives.
%note that the first component is larger than the second because the
%greatest was in the second component.

S2=-2*D2*(t-a2);

S1=D1*W2'*S2;

%learning rate

h=.1;

%update weights and biases

W2=W2-h*S2*a1';

b2=b2-h*S2;

W1=W1-h*S1*p';

b1=b1-h*S2;

%send p through the net again

n1=W1*p+b1;

a1=f1(n1);

n2=W2*a1 + b1;

a2=f2(n2);

%compute new error

E(2)=sum((t-a2).^2);

%% repeat process




