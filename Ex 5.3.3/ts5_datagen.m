%ts5_datagen.m
% Author: Sean Devonport
% Script that generates time sequence
%%
clc;clear;close all
x(1)=1;x(2)=1;
y(1)=3*x(1)^2-x(1); y(2)=3*x(2)^2-x(2)
n=100;
for i=3:n
    x(i)=.76*x(i-1)+.25*x(i-2);
    y(i)=3*x(i)^2-x(i);
end

v=[x;y]

save ts5seq.mat