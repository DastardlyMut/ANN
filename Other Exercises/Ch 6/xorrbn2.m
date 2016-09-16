%xorrbn2

clc;clear
%patterns and targets
p=[1 1 0 0; 1 0 1 0]
t=[0 1 1 0]

%rbf net
net=newrb(p,t,0.0001,.5,4,1);
w2=net.LW{2,1}
y=sim(net,p)

%input for simulation
n=51;
x=linspace(-3,3,n);

% %simulate on values in x X x
[X,Y]=meshgrid(x,x);
XX=X(:)';
YY=Y(:)';
P=[XX;YY];
A=sim(net,P);
z=reshape(A,n,n);

close all
surf(x,x,z)

figure
hold on
contour(x,x,z)
plot(1,1,'o')
plot(0,0,'o')
plot(1,0,'*')
plot(0,1,'*')
hold off
 
 
 
 