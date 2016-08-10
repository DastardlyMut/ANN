%nlrgd.m
%Author: Sean Devonport
%A script that returns coefficients for the regression function
%y=Asin(kt)
%%
function [A,k]=nlrgd
    clear all;
    close all;
    clc;

    %data points:
    t=0:10;
    y=[0 2.67 -2.32 -0.80 2.98 -1.55 -1.61 2.83 -0.86 -2.35 2.87];

    %learning rate:
    a=0.00002;

    %initial estimate:
    p(:,1)=[3.3,2.2]';
    
    %gradient
    g(:,1)=gr(p(:,1));
    
    %gradient descent updating:
    for j=2:250
        p(:,j)=p(:,j-1)-a*g(:,j-1);
        g(:,j)=gr(p(:,j));
    end
    
    A=p(1,end);
    k=p(2,end);

    fprintf('A=%g k=%g\n',A,k);
    
    figure
    plot(p(1,:),p(2,:),'.');
    xlabel('A values');
    ylabel('k values');
    
    figure
    plot(t,y,'o');
    hold on;
    tt=linspace(0,10,101);
    yy=rf(tt,A,k);
    plot(tt,yy);
    title(sprintf('Regression by GD:\n Regressing function: y=Asin(kt)\n with A=%g k=%g\n',A,k));
    xlabel('t');
    ylabel('y');
    hold off;

    %regression function
    function y=rf(t,A,k)
        y=A*sin(k*t);
        return;
    end

    %gradient function
    function gv=gr(p)
        A=p(1);
        k=p(2);
        t=0:10;
        y=[0 2.67 -2.32 -0.80 2.98 -1.55 -1.61 2.83 -0.86 -2.35 2.87];

        gv(1)=sum(2*(A*sin(k*t)-y).*(sin(k*t)));
        gv(2)=sum(2*(A*sin(k*t)-y).*(A*t.*cos(k*t)));
        gv=(gv(:))';
        return
    end
end