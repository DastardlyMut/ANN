%neur1.m
%Author: Sean Devonport - g12d0625
%A short script that implements the learning rule on a single neural
%perceptron.

%%
%variables:

P = [1.0 -1.0 0; 2.0 2.0 -1.0];
T = [1.0 0 0];
W=rand(1,2);
b=rand(1);

%% Plot points + initial boundary

%plot points:
plot(P(1,1),P(2,1),'ob',P(1,2),P(2,2),'*b',P(1,3),P(2,3),'*b' );
legend('1','0','0')
hold on;

%plot initial boundary line
x=[-3:3];y=(-1)*(W(1)*x)/W(2) - (b/W(2)); 
plot(x,y,'blue');
hold on;

%construct initial batch process matrices.
Wa = [W b];
Pa=[P;ones(1,3)];

%determine intial activations
A=hardlim(Wa*Pa);

%% Updating rule:

E=T-A; %error setup for batch processing.
%B = b * ones(1, 3); %bias setup for batch processing.

%set up list of weights, biases and activations.
WW=W;
bb=b;
AA=A;
halt =0; %set up halt counter.

while(sum(E.^2) ~= 0 || halt == 50)
    W = W+E*P'; %calculate new weight matrix (as batch)
    WW = [WW; W]; %add to weight list
    
    b = b + sum(E); %Calculate new bias
    bb = [bb ; b]; %add to bias list
    
    Wa = [W b];
    Pa = [P;ones(1,3)];
    Na=Wa*Pa; %calculate batch vector.
    
    A=hardlim(Na);  %calcuate activations (as batch)
    AA=[AA;A]; %add to activation list

    halt = halt + 1; %halting counter.
    
    E = T-A; %Calculate new errors.
    
        
    %plot new boundary line:
    ynew=(-1)*(W(1)*x)/W(2) - (b/W(2));
    plot(x,ynew,'-.r');
    hold on; 
end

%% Display results:
fprintf('Sequence of weight matrices:');
display(WW);
fprintf('Sequence of biases:');
display(bb);
fprintf('Sequence of activations:');
display(AA);
fprintf('The final weight matrix is:');
display(W);
fprintf('The final activation is:')
display(A);
fprintf('The targets were:');
display(T);
%% Final Plot:

ynew=(-1)*(W(1)*x)/W(2) - (b/W(2));
plot(x,ynew,'g'); %final plot is green


