%-------------------------
% Author: Yang Bai
% Time: Spetember, 2015
%
% Function: Implement Cross-validation for Polynomial Fitting
%
% Dataset: X:500*1 ; Y: 500*1
% D: the degree of the polynomial
% step: step size in the gradient descent algorithm
% err: empirical risk of training data
% risk: regularized risk of training data
% errT: empirical risk of testing data
% riskT: regularized risk of testing data
% BestLamda: the lamda which minimize the errT
%---------------------------

close all
clear all
load('problem1.mat', 'x')
load('problem1.mat', 'y')

%set the range of polynomial degree
D=30;
err=zeros(1,D);
errT=zeros(1,D);
model=zeros(D,D);

%divide the data into two parts, traing and testing
x1=x(1:250);
x2=x(251:end);
y1=y(1:250);
y2=y(251:end);


%calculate the average squared loss of different D
for n=1:D
[err(n),model(1:n,n),errT(n)] = polyreg(x1,y1,n,x2,y2);
end

%plot the loss function 
figure
polyn=1:D;
plot(polyn,err,'r',polyn,errT);

%find the best D and save the best model
BestD=find(errT==min(errT))
BestModel=model(:,BestD);
save('Ques1BestModel.mat','BestModel')

