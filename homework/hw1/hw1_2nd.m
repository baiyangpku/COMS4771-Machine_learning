%-------------------------
% Author: Yang Bai
% Time: Spetember, 2015
%
% Function: Implement a regularized risk minimization
%
% Dataset: X:400*100 ; Y: 400*1
% lamda:  range :0~1000
% step: step size in the gradient descent algorithm
% err: empirical risk of training data
% risk: regularized risk of training data
% errT: empirical risk of testing data
% riskT: regularized risk of testing data
% BestLamda: the lamda which minimize the errT
%---------------------------

clear all
close all

load('problem2.mat')

%divide the data into two parts, training and testing
x1=x(1:280,:);
x2=x(281:end,:);
y1=y(1:280);
y2=y(281:end);

% set the range of lamda, 0~1000
lamda=1000;

err=zeros(1,lamda);
risk=zeros(1,lamda);
errT=zeros(1,lamda);
riskT=zeros(1,lamda);
model=zeros(100,lamda);

% calculating the empirical risk and regularized risk of different lamda
for n=0:(lamda-1)
 [err(n+1),risk(n+1),model(:,n+1),errT(n+1),riskT(n+1)]=linereg(x1,y1,n,x2,y2);
end

% plot the empirical risks of training and testing data as functions of lamda
figure
xlamda=1:lamda;
plot(xlamda,err,'r',xlamda,errT,'g');
title 'empirical risk of training and testing data'

% find the minimum of testing error and the lamda
BestLamda=find(errT==min(errT))

