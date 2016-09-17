% wineqrednet.m
% Author: Sean Devonport
% Function that simulates on input to produce wine quality
%%
function y=wineqrednet(p)
    load wineqred_train.mat    
    % Simulate on input
    y = sim(net,p);
end