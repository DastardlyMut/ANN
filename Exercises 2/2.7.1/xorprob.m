%xorprob.m
%Author: Sean Devonport - g12d0625
%A script that implements a multilayer neural network to solve the xor
%problem.

%% 
%set up XOR problem pattern and final target.
P = [0 1 1 0;0 0 1 1]; %input pattern
T_final = [0 1 0 1]; %final target
%% Training to solve logical OR problem. (First layer)
T_or = [0 1 1 1;1 1 0 1]; %targets for OR problem.
W_1 = [1.5 1.5;-1.5 -1.5]; %initialize weight matrix that solves OR problem
b_1 = [-1;2]; %initialize b that solves OR problem
%construct neuron
Wa_1= [W_1 b_1];
Pa_1 = [P;ones(1,4)];
Na_1 = Wa_1*Pa_1;

%plot boundary line:
hold on;
x=-2:2;y=(-1)*(W_1(1)*x)/W_1(3) - (b_1(1)/W_1(3)); 
plot(x,y,'b');
y2=(-1)*(W_1(2)*x)/W_1(4) - (b_1(2)/W_1(4)); 
plot(x,y2,'b');

%activations for first layer:
A_1 = hardlim(Na_1);

%% Training to solve logical AND. (Second layer)
T_and = [0 1 0 1];
W_2 = [1 1]; %initialize weight matrix that solves AND problem
b_2 = -2; %initialize b that solves AND problem

Wa_2 = [W_2 b_2];
Pa_2 = [A_1;ones(1,4)];
Na_2 = Wa_2*Pa_2;

%Activations for second layer:
A_2 = hardlim(Na_2);

%Plot points:
N_2=P(:, A_2(1:4)==1); %all patterns with activation 1
M_2=P(:, A_2(1:4)==0); %all patterns with activation 0
plot(N_2(1,:),N_2(2,:),'.','markersize',12); %Plot P where A==1
plot(M_2(1,:),M_2(2,:),'o'); %plot P where A==0

fprintf('Final activation:\n');
display(A_2);

