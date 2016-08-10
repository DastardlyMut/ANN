% risk_fcn.m
% Author: Sean Devonport
% Script that deploys trained net for an input pattern.
%%
function a=risk_fcn(x)
    load riskdata.mat    
    if(size(x,1 ~= r)
     error('x incorrect value');
    end
     
    % send pattern through net
    a=sim(cancernet,x);
end