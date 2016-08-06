% housing_sim.m
% Author: Sean Devonport
% A script that implements a strategy for deploying neural nets on housing data.
%%

atrain=sim(housingnet,ptrain); %train
atest=sim(housingnet,ptest);   %test
a=sim(housingnet,p);           %all