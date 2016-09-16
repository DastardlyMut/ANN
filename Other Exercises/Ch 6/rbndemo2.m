 %rbndemo2
%Uses newrbe 
%Allows the user to experiment with the spread

clear
clc
close all

m=input('Number of patterns = ');
fprintf('input patterns and targets:\n');

%generate targets for toy problem
p(1,:)=linspace(0,pi,m);
p(2,:)=linspace(pi/2,pi+pi/2,m);
p
%form targets using a function:  
t=sin(p.^2+p.^3/10);
t=disturb(t,5)

s2=size(t,1);
pause

d=dist(p',p);

fprintf('Experiment with spread\n')
fprintf('Smoothness of the function approximation improves with increasing spread.\n')
fprintf('Too large a spread can cause numerical problems.\n')
fprintf('Too small a spread will cause overfitting\n')

d=max(max(d));
fprintf('max dist between patterns = %g\n',d)

s=input('spread = ');

fprintf('\n Using newrbe with spread %g \n',s);
net=newrbe(p,t,s);

fprintf('compare activation and target vectors\n')
a=sim(net,p)
t

pause

fprintf('Now deploy the net to activate on a finer mesh\n')
fprintf('The activation interpolates between the targets\n')

x(1,:)=linspace(0,pi,101);
x(2,:)=linspace(pi/2,pi/2+pi,101);
y=sim(net,x);

fprintf('Display components of activations and targets\n')
for i=1:size(t,1)
    figure
    plot(x(i,:),y(i,:))
    hold on
    plot(p(i,:),t(i,:),'o')
    hold off
    title(sprintf('Component %d with spread = %g\n',i,s))
end






% 








