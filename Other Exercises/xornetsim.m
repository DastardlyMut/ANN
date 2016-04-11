%xornetsim.m
%Author: Sean Devonport - g12d0625
%A function that returns the activation for any set of inputs using MATLAB
%%
function a=xornetsim(p)
load F:\Work\Maths\'Maths Hons'\ANN\data\NNmfiles\xornet.mat;

p=double(p);

a1=sim(xornet1,p);
a1=double(a1);
a=sim(xornet2,a1);

%identify inputs where a==1:
I=find(a==1);

%identify inputs where a==0:
J=find(a==0);

%plot points (a==1 is solid, a==0 is open) + boundary lines:
close all;
hold on;
plot(p(1,I),p(2,I),'.b','markersize',15);
plot(p(1,J),p(2,J),'og');
axis([-.5,1.5,-.5,1.5]);