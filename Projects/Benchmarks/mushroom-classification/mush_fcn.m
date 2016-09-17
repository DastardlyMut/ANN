%mush_fcn.m
%Author: Sean Devonport
%Script that simulates patterns on mushroom net.
%%
function y=mush_fcn(x)
    load mush_train.mat
    encode(x)
    if (size(x,1) ~= r)
       error('Incorrect pattern size');
    end
    
    y=round(mushnet(x));
end