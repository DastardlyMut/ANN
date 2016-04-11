%function handles:
f = {@hardlim,@hardlims,@purelin,@satlin,@satlins,@logsig,@tansig,@poslin};

%prompts for input:

p = input('p (as vertical matrix) = ');
W = input('W matrix of layer weights = ');
b = input('b (a vertical list of biases) = ');
fprintf('available transfer functions:\n1:hardlin, 2:hardlims, 3:purlin, 4:satlin, 5:satlins, 6:logsig, 7:tansig, 8:poslin\n')
fnum = input('Please select number of function: ');
f=f{fnum};

%inputs of network:
n = W*p + b;

%activations:
a = f(n);

%results:
display(n);
display(a);


