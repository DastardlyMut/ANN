% housing_fcn.m
% Author: Sean Devonport
% A function which takes accepts 13x1 input and returns the house value.
%%
function y=housing_fcn(x)
    load housing_train.mat
    
    if(size(x,1) ~= r)
        error('x incorrect value');
    end
    
    y=sim(housingnet,x);
end
