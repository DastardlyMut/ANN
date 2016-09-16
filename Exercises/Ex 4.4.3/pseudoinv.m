%pseudoinv.m
%Author:Sean Devonport
%Script that calculates coefficients of the regression function y=at+b. Ex
%4.4.3 [1]
%% Clean
clc
clear
close all
%%
Y   = [7.1 10.3 12.5 16.5 18.7 22.5 24.5 28.3 31.6 34.6]';
t   = 1:10;
T   = [t'   ones(length(t),1)];
    
C   = pinv(T)*Y

%% Compute regression function
f = C(1)*t + C(2);

%% Plot
plot(t,Y,'*',t,f,'r');