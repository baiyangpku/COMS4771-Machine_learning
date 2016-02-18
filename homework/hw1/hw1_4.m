%-------------------------
% Author: Yang Bai
% Time: Spetember, 2015
%
% Function: Implement a linear logistic regression algorithm for binary 
%            classification in Matlab using gradient descent.
%
% Dataset: X:200*3, 3 dimensions; Y: 200*1, binary number
% theta0: initial theta
% step: step size in the gradient descent algorithm
% tolerance: tolerance in the gradient descent algorithm
% fx: logistic function
% logis: output of logistic regression (binary)
% binary error: the number of wrong regression
% Risk: the empirical risk 
%---------------------------


clear all
close all
load('dataset4.mat')

%set a random theta0, not too big
theta0=[2.0001;5.00001;1.00001];
% step size and tolerance can be changed 
step=0.1;
tolerance=0.001;

%gradient descendent algorithm
[theta, iteration_num]=grad_des(theta0,step,tolerance,X,Y);



fx=1.0./(1+exp(-X*theta));

%calculate the emprical risk
f=(Y-1).*log(1-fx)-Y.*log(fx);
f(isnan(f))=0;
Risk=1.0/length(X)*sum(f)
 
%carry out regression for the fx, if fx>=0.5, output=1; output=0,others.
logis=0*Y;
logis(find(fx>=0.5))=1;  
 %the number of different elements of Y and logistic regression is the binary error
Binary_Error=nnz(Y-logis)


figure
%plot Y=1 and Y=0 in different colors
T1=zeros(100,3);
T2=zeros(100,3);
T1(find(Y==1),:)=X(find(Y==1),:);
T2(find(Y==0),:)=X(find(Y==0),:);
plot(T1(:,1),T1(:,2),'*',T2(:,1),T2(:,2),'*')
hold on

%plot the result of logistic regression 
ax=0:0.01:1.02;
ay=-theta(1)/theta(2)*ax-(theta(3))/theta(2);
plot(ax,ay,'g')

