%xormatlab.m
%Author: Sean Devonport - g12d0625
%A script that trains neurons to solve the XOR problem. Using MATLAB.

%% 
%set up XOR problem pattern and final target.
P = [0 1 1 0;0 0 1 1]; %input pattern
T = [0 1 0 1]; %final target

%% Training to solve logical OR problem. (First layer)
T_1 = [0 1 1 1;1 1 0 1]; %targets for OR problem.

%2 Neurons in one layer:
xornet1=newp([0 1;0 1],2);

%train to solve 
%0 1 1 0            0 1 1 1
%        --------->
%0 1 1 1            1 1 0 1

xornet1=train(xornet1,P,T_1);

W1 = xornet1.iw{:}(1,:);
b1 = xornet1.b{:}(1);
W12 = xornet1.iw{:}(2,:);
b12 = xornet1.b{:}(2);

%plot boundary lines:
hold on;
x=-3:3;
y=(-1)*(W1(1)*x)/W1(2)-(b1/W1(2));
y2=(-1)*(W12(1)*x)/W12(2)-(b12/W12(2));
plot(x,y,'b');
plot(x,y2,'b');
axis([-.5,1.5,-.5,1.5]);

%1 neuron in layer 2:

xornet2=newp([0 1;0 1],1);

%train to solve
%0 1 1 1
%        ---------> 0 1 0 1
%1 1 0 1

xornet2=train(xornet2,T_1,T);

xornetsim(P);

%save the net and other variables:
save F:\Work\Maths\'Maths Hons'\ANN\data\NNmfiles\xornet.mat