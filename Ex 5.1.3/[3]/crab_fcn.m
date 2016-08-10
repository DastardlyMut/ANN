% crab_fcn.m
% Author: Sean Devonport
% Script which deploys crabnet on pattern. Takes [6xq] input
%%
function y=crab_fcn(x)
    load crab_train.mat
    
    if (size(x,1) ~= r)
       error('Incorrect pattern size');
    end
    
    y=round(crabnet(x));
end