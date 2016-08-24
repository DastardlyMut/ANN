%copper_test
% Test copper_train net
%%
clear;clc;close all
load copper.mat
%simulate on all input cells
%produces cell output
%use values in ptraini as initial conditions
ac=sim(coppernet,p,pi)

%convert to vectors
a=cell2mat(ac)

%compare
[a(:) c(:)]
[r2 R]=correlation(a,c,'all')
atest=a(:,ti);
ctest=c(:,ti);

%check:
[atest(:) ctest(:)]

[r2 R]=correlation(atest,ctest,'test')

figure
plot([1:size(atest,2)],atest,'*')
hold on
plot([1:size(ctest,2)],ctest,'o')
hold off
title('test')

figure
plot([1:size(a,2)],a,'*')
hold on
plot([1:size(c,2)],c,'o')
hold off
title('all')