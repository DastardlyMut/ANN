%tsl_datagen.m
% Author: Sean Devonport
% Script that generates time sequence
%%
clc;clear;close all
x(1)=1;x(2)=1;
n=100;
for i=3:n
    x(i)=.76*x(i-1)+.25*x(i-2);
end

save tslseq.mat