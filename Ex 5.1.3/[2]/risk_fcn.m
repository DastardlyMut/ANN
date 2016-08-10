% risk_fcn.m
% Author: Sean Devonport
% Script that deploys trained net for an input pattern.
%%
function y=risk_fcn(x)
    load risk_matrain.mat
    
    if(size(x,1) ~= r)
        error('x incorrect value');
    end
    
    y=risknet(x);
end
