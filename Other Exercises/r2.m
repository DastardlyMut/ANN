function r=r2(a,t)
%function r=r2(a,t)
%Finds the R^2 statistic for 
%a: activation vector
%t: target vector


%calculating r2:
tbar=mean(t,2);
tBar=repmat(tbar,1,length(t));
%tT=repmat(t,1,length(t));
ss=sum((a-t).^2,2)/length(t);
sstB=sum((t - tBar).^2,2)/length(t);
r2v=1-ss./sstB;
r=mean(r2v);