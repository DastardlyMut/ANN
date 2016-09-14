function py=disturb(y,e)
% perturbs a matrix y by e percent 
% usage: function py=perturb(y,e)

d=e/100;
r=randu(-d,d,size(y));
py=y+r.*y;