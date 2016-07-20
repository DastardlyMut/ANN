%popt3.m
%Author: Sean Devonport
%Script that implements Newton's method
%%
clear all;
close all;
clc;

%initial point:
p(:,1)=input('Please input initial point p element of [-1,1]x[-1,1] as column vector\n');

gk=[(-1)*4*(p(2,1)-p(1,1))^3+8*p(2,1)-1;
    4*(p(2,1)-p(1,1))^3+8*p(1,1) + 1];

Hk = [12*(p(2,1)-p(1,1))^2 (-1)*12*(p(2,1)-p(1,1))^2 + 8;
      (-1)*12*(p(2,1)-p(1,1))^2 + 8 12*(p(2,1)-p(1,1))^2];
  
Hkinv=inv(Hk);

delXk=Hk\gk;

for k=2:500
    p(:,k)=p(:,k-1) - delXk;
    gk=[(-1)*4*(p(2,k)-p(1,k))^3+8*p(2,k)-1;
        4*(p(2,k)-p(1,k))^3+8*p(1,k) + 1];
    
    Hk = [12*(p(2,k)-p(1,k))^2 (-1)*12*(p(2,k)-p(1,k))^2 + 8;
      (-1)*12*(p(2,k)-p(1,k))^2 + 8 12*(p(2,k)-p(1,k))^2];
  
    delXk=Hk\gk;
end

%% Plot contour and points:

x = -1:.01:1;
y=x;
[X,Y] = meshgrid(x,y);
E=(Y-X).^4 + 8*X.*Y - X + Y + 3;
figure
hold on;
contour(X,Y,E,40);
plot(p(1,:),p(2,:));
hold off;

p = p(:,1:5); %return first five points
disp('the first five points are: ');
disp(p);
disp('converging to');
disp(p(:,5));
