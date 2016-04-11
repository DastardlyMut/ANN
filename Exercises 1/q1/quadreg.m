%Data:
x=0:10;
y =[5.157 7.284 4.440 30.198 49.648 71.981 104.629 145.679 197.646 250.110 284.899];

%plot:
plot(x,y,'o');
xlabel('x');
ylabel('y');
%%
%compute matrix:
A = sum(x.^4);
B = sum(x.^3);
C = sum(x.^2);
D = sum(x);
E = 11;

M = [A B C;B C D;C D E];

F = sum((x.^2).*y);
G = sum(x.*y);
H = sum(y);

X =M\[F;G;H];

%coeffecients
a = X(1); b=X(2); c=X(3);

f = a*x.^2 + b*x + c;
%%
hold on;
plot(x,f);
hold off;

