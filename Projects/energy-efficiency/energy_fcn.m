% energy_fcn.m
% Author: Sean Devonport
% Script that simulates new input patterns on net.
%%
function y=energy_fcn(x)
    load energy_train.mat
    
    %simulate
    y=sim(net,x);
end