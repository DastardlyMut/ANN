%popt2.m
%Author: Sean Devonport
%Script that minimises a performance function along a line.
%%
function p=minline
    clear all;
    close all;
    clc;

    %initial point
    p(:,1)=input('Please input initial point p element of [-1,1]x[-1,1] as column vector\n');
    %set up for gk and Hk

    gk=[2*p(1,1) + p(2,1);
        2*p(2,1) + p(1,1)];

    Hk = [2 1;
          1 2];

    vk = -gk;
    ak = -1*((gk'*vk)/(vk'*Hk*vk));

     for k=2:500
         p(:,k)=p(:,k-1)+ ak*vk;
         gk=[2*p(1,k) + p(2,k);
             2*p(2,k) + p(1,k)];
         vk = -gk;
         ak = -1*((gk'*vk)/(vk'*Hk*vk));
     end
    
%% Plot contour and points:

    x1 = -1:.01:1;
    x2=x1;
    [X,Y] = meshgrid(x1,x2);
    E=X.^2 + X.*Y + Y.^2;
    figure
    hold on;
    contour(X,Y,E,40);
    plot(p(1,:),p(2,:));
    hold off;
    
    p = p(:,1:5); %return first five points
    disp('the first five points are: ');
end


