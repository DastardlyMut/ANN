function r2=rsq(x,y)

%%% Compute the coefficient of determination (r_squared) between vectors x and y
%%% Source: http://www.mathworks.nl/help/matlab/data_analysis/linear-regression.html
%%% Adapted by Didier Gonze
%%% Created: 14/4/2014
%%% Updated: 14/4/2014

p = polyfit(x,y,1);

yfit = polyval(p,x);

yresid = y - yfit;

SSresid = sum(yresid.^2);

SStotal = (length(y)-1) * var(y);

r2 = 1 - SSresid/SStotal;


%%% adjusted R2:

% r2_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(p));