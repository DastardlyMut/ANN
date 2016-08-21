%delay3_datagen.m
% Generates 2-d recurrence relation data
%%
clc;clear;close all

x(1)=1;x(2)=1;
m=100;
for i=3:m
    x(i)=.76*x(i-1)+.25*x(i-2);
end

y(1)=1;y(2)=1;
m=100;
for i=3:m
    y(i)=.79*x(i-1)+.23*x(i-2);
end
v=[x;y];

save delay3.mat