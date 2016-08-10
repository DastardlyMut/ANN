% risk_matsim.m
% Author: Sean Devonport
% Script that simulates and plots trends in the data.
%%
clc; clear; close all
load risk_matrain.mat
%%

%age vary
xc1(1,:)=linspace(0,1,91);
%BMI/BP fixed at 0.5
xc1(2,:)=repmat(0.5,1,91);
%Genetic fixed at 0.5
xc1(3,:)=repmat(0.5,1,91);
% Fitness fixed 0.5
xc1(4,:)=repmat(0.5,1,91);

yc1=risk_fcn(xc1);

figure
plot(xc1(1,:),yc1(1,:))
xlabel('age');
ylabel('risk');
title('age vs risk')

%age fixed at 0.5
xc2(1,:)=repmat(0.5,1,91);
%BMI/BP vary
xc2(2,:)=linspace(0,1,91);
%Genetic fixed at 0.5
xc2(3,:)=repmat(0.5,1,91);
% Fitness fixed 0.5
xc2(4,:)=repmat(0.5,1,91);

yc2=risk_fcn(xc2);

figure
plot(xc2(2,:),yc2(1,:))
xlabel('BMI/BP');
ylabel('risk');
title('BMI/BP vs risk');

%age fixed at 0.5
xc3(1,:)=repmat(0.5,1,91);
%BMI/BP fixed at 0.5
xc3(2,:)=repmat(0.5,1,91);
%Genetic vary
xc3(3,:)=linspace(0,1,91);
% Fitness fixed 0.5
xc3(4,:)=repmat(0.5,1,91);

yc3=risk_fcn(xc3);

figure
plot(xc3(3,:),yc3(1,:))
xlabel('genetic');
ylabel('risk');
title('genetic vs risk');

%age fixed at 0.5
xc4(1,:)=repmat(0.5,1,91);
%BMI/BP fixed at 0.5
xc4(2,:)=repmat(0.5,1,91);
%Genetic fixed at 0.5
xc4(3,:)=repmat(0.5,1,91);
% Fitness vary
xc4(4,:)=linspace(0,1,91);

yc4=risk_fcn(xc4);

figure
plot(xc4(4,:),yc4(1,:))
xlabel('fitness');
ylabel('risk');
title('fitness vs risk');
