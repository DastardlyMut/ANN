% numbers_sim.m
% Author: Sean Devonport
% Script that simulates on corrupted numbers. If number is corrupted it
% returns best approximation
%%
clc;clear;close all

load numbers_train.mat

no=input('P = ');
in=P(:,no+1);
spy(reshape(in,5,5))
crpt = input('corrupt data? (1 = yes, 0 = no) ');
N=zeros(5,5);
while crpt == 1
    %close all
    if no <= 9 && no >= 0
        pos = input('which row and column? [row col] ');
        N=reshape(in,5,5);
        if N(pos(1),pos(2)) == 1
            N(pos(1),pos(2))=0;
        else
            N(pos(1),pos(2))=1;
        end
        
        spy(N)
        in = N(:);
    else
       disp('invalid number selection') 
    end
    crpt = input('corrupt again? (1 = yes, 0 = no) ');
end
% P=P(:,no+1);
a=sim(numbernet,in);
%find the number closest to a:
for j=1: size(p,2)
    d(j)=norm(a-t(:,j));
end
[m,k]=min(d);
fig=zeros(30,1);
switch k
    case 1
        fig=number_0;
    case 2
        fig =number_1;
    case 3
        fig =number_2;
    case 4
        fig=number_3;
    case 5
        fig =number_4;
    case 6
        fig =number_5;
    case 7
        fig=number_6;
    case 8
        fig =number_7;
    case 9
        fig =number_8;
    case 10
        fig=number_9;
end
in=reshape(in,5,5);
figure
spy(in)
in=num2str(in);
disp('input pattern')
in
fig=reshape(fig,5,5);
spy(fig)

fig=num2str(fig);
disp('identified as:')
fig
