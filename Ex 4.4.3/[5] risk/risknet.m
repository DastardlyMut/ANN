%risknet.m
%Author: Sean Devonport
%Function which simulates functional relationship between input patterns
%and targets.
%%
function y=risknet(x)
    load risk_train.mat

    if(size(x,1) ~= r)
        error('x incorrect value');
    end

    %normalize
    xn=Dp*x+repmat(pc,1,size(x,2));

    for j=1:size(x,2)
        n1=W1*xn(:,j)+b1;
        a1=f1(n1);
        n2=W2*a1+b2;
        a2=f2(n2);
        n3=W3*a2+b3;
        a3=f3(n3);
        yn(:,j)=a3;
    end
    
    %rescale
    y=diag(1./tff)*(yn-repmat(tc,1,size(yn,2)));
end
