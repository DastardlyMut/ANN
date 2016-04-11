%data:
x=0:10;
y=[0  1.8127  3.2968  4.5119  5.5067  6.3212  6.9881  7.5340  7.9810  8.3470  8.6466];

%plot:
figure(1);
plot(x,y,'o');
xlabel('x');
ylabel('y');
hold on;
%%
%modelfunction +approx method:
my_fun = @(beta,x) ((beta(1).*(1-exp(-beta(2)*x))));

initials = [1,1];

new_co = nlinfit(x,y,my_fun,initials);

new_y = my_fun(new_co,x);

plot(x,y,x,new_y);
%%
%calculating r^2 value:
SSR = sum((y - new_y).^2);
SSY = sum((y - mean(y)).^2);
r2 = 1 - (SSR/SSY);

%% Results:
% new coeffs: M=0; k=0
% r2 = 1. Perfect fit.




