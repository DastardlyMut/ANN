%investigate.m
%Author: Sean Devonport
%Script that deploys ugradnet to investigate relationships.
%%

clear all 
close all
clc 

load ugrad_train.mat

%% (a) First question

%vary Swedish points
x1(1,:)=linspace(24,46,91);
%vary school quality
x1(2,:)=linspace(1,10,91);
%fixed test mark
x1(3,:)=repmat(50,1,91);

%simulate on net
y1=ugradnet(x1);

%plots
% % (a)
figure
plot(x1(2,:),y1(1,:));
title('semester 1 vs school quality for fixed test mark of 50');

figure
plot(x1(2,:),y1(2,:));
title('semester 2 vs school quality for fixed test mark of 50');

figure
plot(x1(1,:),y1(1,:));
title('semester 1 vs Swedish points for fixed test mark of 50');

figure
plot(x1(1,:),y1(2,:));
title('semester 2 vs Swedish points for fixed test mark of 50');

disp('Press any key to check the next question');
waitforbuttonpress


%% (b) Second question
%fix Swedish points
x2(1,:)=repmat(30,1,91);
%vary school quality
x2(2,:)=linspace(1,10,91);
%vary text marks
x2(3,:)=linspace(1,100,91);

%simulate on net
y2=ugradnet(x2);

figure
plot(x2(2,:),y2(1,:));
title('semester 1 vs school quality for fixed Swedish point score of 30');

figure
plot(x2(2,:),y2(2,:));
title('semester 2 vs school quality for fixed Swedish point score of 30');

figure
plot(x2(3,:),y2(1,:));
title('semester 1 vs test marks for fixed Swedish point score of 30');

figure
plot(x2(3,:),y2(2,:));
title('semester 2 vs test marks for fixed Swedish point score of 30');

disp('Press any key to check the next question');
waitforbuttonpress

%% (c) Third question
x3(1,:)=repmat(25,1,91);
x3(2,:)=repmat(6,1,91);
x3(3,:)=linspace(1,100,91);

%simulate on net
y3=ugradnet(x3);

figure
plot(x3(3,:),y3(1,:));
title('semester 1 vs test marks for fixed Swedish point score of 25 and school quality 6');

figure
plot(x3(3,:),y3(2,:));
title('semester 2 vs test marks for fixed Swedish point score of 25 and school quality 6');