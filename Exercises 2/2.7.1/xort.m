%xort.m
%Author: Sean Devonport - g12d0625
%A script that trains neurons to solve the XOR problem.

%% 
%set up XOR problem pattern and final target.
P = [0 1 1 0;0 0 1 1]; %input pattern
T_final = [0 1 0 1]; %final target

%% Training to solve logical OR problem. (First layer)
T_or = [0 1 1 1;1 1 0 1]; %targets for OR problem.

%Neuron 1:
[W_1, b_1,i_1] = neurtrain(P,T_or(1:4));
fprintf('iterations = \n     %d\n',i_1)
fprintf('Neuron 1 in layer 1 has been trained to solve the first classifiation:\n[0 1 1 0]\n|       |    -------> [0 1 1 1]\n[0 0 1 1]\nStrike to continue\n');
waitforbuttonpress;

%construct neuron 1:
Wa_1= [W_1 b_1];
Pa_1 = [P;ones(1,4)];
Na_1 = Wa_1*Pa_1;
 
A_1 = hardlim(Na_1); %activations for first neuron in first layer
 
%Plot points:
hold on;
N_1=P(:, A_1(1:4)==1); %all patterns with activation 1
M_1=P(:, A_1(1:4)==0); %all patterns with activation 0
plot(N_1(1,:),N_1(2,:),'.','markersize',12); %Plot P where A==1
plot(M_1(1,:),M_1(2,:),'o'); %plot P where A==0

%Plot boundary line:
x=-2:2;y=(-1)*(W_1(1)*x)/W_1(2) - (b_1/W_1(2)); 
plot(x,y,'b');
 
waitforbuttonpress;
 
%Neuron 2:
[W_12, b_12,i_12] = neurtrain(P,T_or(2,1:4));
fprintf('iterations = \n     %d\n',i_12)
fprintf('Neuron 2 in layer 1 has been trained to solve the second classifiation:\n[0 1 1 0]\n|       |    -------> [1 1 0 1]\n[0 0 1 1]\nStrike to continue\n')
waitforbuttonpress;
clf
%construct neuron
Wa_12= [W_12 b_12];
Pa_12 = [P;ones(1,4)];
Na_12 = Wa_12*Pa_12;
 
A_12 = hardlim(Na_12); %activations for second neuron in first layer
 
%Plot points:
hold on;
N_12=P(:, A_12(1:4)==1); %all patterns with activation 1
M_12=P(:, A_12(1:4)==0); %all patterns with activation 0
plot(N_12(1,:),N_12(2,:),'.','markersize',12); %Plot P where A==1
plot(M_12(1,:),M_12(2,:),'o'); %plot P where A==0
   
%plot boundary line:
y2=(-1)*(W_12(1)*x)/W_12(2) - (b_12/W_12(2)); 
plot(x,y2,'b');
 
W1 = [W_1; W_12];
b1 = [b_1;b_12];
 
waitforbuttonpress;
%% Display A1 that goes into the second layer as well as network architecture:
fprintf('The network architecture is\n[p_2x1, 2, 1]\n');
a1 = [A_1; A_12];
display(a1);
 
%% Training to solve logical AND. (Second layer)
T_and = [0 1 0 1];
[W_2,b_2,i_2]=neurtrain(a1,T_and(1:4));
fprintf('iterations = \n     %d\n',i_12)
fprintf('A single neuron in layer 2 has been trained to solve the problem:\n[0 0 1 0]\n|       |    -------> [0 1 0 1]\n[1 0 0 0]\nThis is the inclusive OR problem\nStrike to continue and find final activation a2\n');

waitforbuttonpress;
Wa_2 = [W_2 b_2];
Pa_2 = [a1;ones(1,4)];
Na_2 = Wa_2*Pa_2;

% %Activations for second layer:
A_2 = hardlim(Na_2);
clf
%Plot points:
hold on;
N_2=P(:, A_2(1:4)==1); %all patterns with activation 1
M_2=P(:, A_2(1:4)==0); %all patterns with activation 0
plot(N_2(1,:),N_2(2,:),'.','markersize',12); %Plot P where A==1
plot(M_2(1,:),M_2(2,:),'o'); %plot P where A==0
plot(x,y,'b');
plot(x,y2,'b');

%% Display W1,b1,W2,b2 as well as final activation and targets: 
fprintf('Final activation:');
display(A_2);
fprintf('and the target is:');
display(T_final);
fprintf('The weights and biases are:');
display(W1);
display(b1);
display(W_2);
display(b_2);

%% Check results:
fprintf('Please strike any key to check results\n');
waitforbuttonpress;
fprintf('Check results:\n');
B1=repmat(b1,1,4);
a1=hardlim(W1*P+B1);
B2=repmat(b_2,1,4);
a2=hardlim(W_2*a1+B2);
display(a2);