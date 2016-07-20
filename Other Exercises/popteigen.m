%popteigen.m
%Author: Sean Devonport
%Script that shows convergence of smaller eigenvalues.
%%

M=[.1 0 .2;0 .3 .4;.2 .4 .5];

C=[1 2 3]';

X=[1 3 5]';

eigs = eigs(M);

X = M*X+C;



