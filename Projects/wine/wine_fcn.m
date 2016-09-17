% wine_fcn.m
% Author: Sean Devonport
% Function that simulates in a new 13xn input pattern to determine wine origin.
%%
function y=wine_fcn(x)
    load wine_train.mat
    
    %simulate
    y=sim(net,x);
end