% alphabet_train.m
% Author: Sean Devonport
% Script that trains on alphabet dataset
%%
clc; clear; close all

% generate alphabet
[alphabet, targets]=prprob;
a=alphabet(:,1);
a=reshape(a,7,5);
spy(a)