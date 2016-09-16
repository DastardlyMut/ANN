function a=rbf(w,p,s)
%rbf
%illustrates the radial basis function
%p is r X m  : a batch of m rX1 vectors
%w is s1 X r : s1 neurons as rows of w

%rXm
%p---------->dist------>*-------n------>radbas------>a
%             ^         ^      rXm                  rXm
%             |         |
%             |         |
%             w         b
%          s1 X r    s1 X 1     

% m=size(p,2);
% w=repmat(w,m,1);
% w=w';


b=sqrt(log(2))/s;
d=dist(w,p);
n=b*d;
%a=exp(-n.^2);
a=radbas(n);

