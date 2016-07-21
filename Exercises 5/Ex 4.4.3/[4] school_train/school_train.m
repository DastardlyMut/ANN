%school_train.m
%Author: Sean Devonport
%A script that uses a neural network to model school.txt data. Ex 4.4.3
%[4].
%%
clc
clear
close all

%% Preprocess data

data=importdata('school.txt');
