% ts2_datagen.m
% Author: Sean Devonport
% Script that generates time sequence for function y=f(u,v,w)
%%
clc;clear;close all
x(1)=1;x(2)=2;x(3)=1;
n=100;
for i=4:n
    x(i)=.76*x(i-1)+.25*x(i-2)-.67*x(i-3);
end

save ts2seq.mat