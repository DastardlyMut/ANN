%neur1a.m
%Author: Sean Devonport - g12d0625
%A short script that implements the learning rule on a single neuron
%perceptron. This also allows for classification of new point.

%%
%variables:
col = [0 0]; %variables for column dimensions of P and T
checkm = false;
%check dimensions of P and T are correct:
while(checkm==false)
    P=input('P is the matrix of patterns and is 2xm:\n');
    T=input('T is the matrix of targets and is 1xm:\n');
    col = [length(P) length(T)];
    if(col(1) == col(2))
        checkm = true;
    else
        fprintf('Please try again, wrong dimensions\n');
    end

end

%initiate weight matrices and bias randomly.
W=rand(1,2);
b=rand(1);

%construct initial batch process matrices.
Wa = [W b];
Pa=[P;ones(1,col(2))];

%determine intial activations
A=hardlim(Wa*Pa);

%% Updating rule:

E=T-A; %error setup for batch processing.

%set up list of weights, biases and activations.
WW=W;
BB = b;
AA=A;
iter =0; %set up halt counter.
x = -3:3;
while(sum(E.^2) ~= 0 && iter <= 50)
    W = W+E*P'; %calculate new weight matrix (as batch)
    WW = [WW; W]; %add to weight list

    b = b + sum(E); %Calculate new bias (as batch)
    BB = [BB ; b]; %add to bias list

    Wa = [W b];
    Pa = [P;ones(1,length(P))];
    Na=Wa*Pa; %calculate batch vector.

    A=hardlim(Na);  %calcuate activations (as batch)
    AA=[AA;A]; %add to activation list

    iter = iter + 1; %halting counter.

    E = T-A; %Calculate new errors.
    
    N=P(:, A==1); %all patterns with activation 1
    M=P(:, A==0); %all patterns with activation 0
    
   
    %plot patterns
    plot(N(1,:),N(2,:),'.b','markersize',12); %Plot P where A==1
    plot(M(1,:),M(2,:),'og'); %plot P where A==0
    
    %plot new boundary line:
    hold on;
    ynew=(-1)*(W(1)*x)/W(2) - (b/W(2));
    plot(x,ynew,'-.r');
    
    
    pause(1);
end
%% Results:

%if success plot final points and boundary line.
if (iter ~= 50) 
    %% Display results:
    
    fprintf('Iterations: ');
    display(iter);
    fprintf('Final weight: ');
    display(W);
    fprintf('bias: ');
    display(b);
    
    %plot patterns
    fprintf('Press any key for final plot\n');
    waitforbuttonpress;
    clf;
    hold on;
    plot(N(1,:),N(2,:),'.b','markersize',12); %Plot P where A==1
    plot(M(1,:),M(2,:),'og'); %plot P where A==0
    
    %plot final boundary line:
    ynew=(-1)*(W(1)*x)/W(2) - (b/W(2));
    plot(x,ynew,'b');
    hold on; 

%% classify more points:

    rep = 1;
    while (rep == true)
        classify = input('Classify another point? 1=yes, 0=no\n');
        if(classify)
           p = input('Please input new point\np= ');
           a = hardlim(W*p' + b);
           display(a);
           if(a)
               plot(p(1),p(2),'.b','markersize',12);
           else
               plot(p(1),p(2),'og');
           end
        end
        rep = input('repeat? 1=yes, 0=no\n');


    end
    hold off;
else
    fprintf('Search failed'); %if search is over 50 iterations.
end



