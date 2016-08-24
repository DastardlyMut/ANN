%ts3_test.m
%
load ts3.mat
clc;close all
%simulate on all input cells
%produces cell output
%use values in ptraini as initial conditions
ac=sim(ts3net,p,pi)
%convert to vectors
a=cell2mat(ac)
%compare
[a(:) x(:)]
[r2 R]=correlation(a,x,'all')
atest=a(:,ti);
xtest=x(:,ti);
%check:
[atest(:) xtest(:)]
[r2 R]=correlation(atest,xtest,'test')