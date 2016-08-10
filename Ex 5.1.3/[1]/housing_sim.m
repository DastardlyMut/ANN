% housing_sim.m
% Author: Sean Devonport
% Script that deploys housing_fcn to determine value of houses from
% housingpnew.txt
%%
clc; clear; close all

pnew = importdata('housingpnew.txt');

A=housing_fcn(pnew);

disp('Price of houses for housingpnew:')
disp(A)