%%Weight matrix and Bias:
% W=[1 1], b=-1.5
%%
%P = input('p (as vertical matrix) = '); 
P = [.6 .9 .3 .9 .4 1;.1 .2 .2 .9 .8 .9];
W=[1 1]; b=-1.5;
A=hardlim(W*P+b);

N=P(:, A==1); %all patterns with activation 1
M=P(:, A==0); %all patterns with activation 0

%plot boundary line

x=[0:0.1:2];y=-x+1.5;%Set up boundary line
plot(x,y);
hold on

%plot patterns
plot(N(1,:),N(2,:),'.','markersize',12); %Plot P where A==1
plot(M(1,:),M(2,:),'o'); %plot P where A==0

fprintf('Results for activation: ');
display(A);

hold off;
