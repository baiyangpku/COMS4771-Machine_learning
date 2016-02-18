function [ theta, iteration_num ] = grad_des(theta0,step,tolerance,x,y )
% 
%   gradient descend algorithm
%
% Inputs:
%   theta0: initial theta 
%   step: step size
%   tolerance: tolerance
%   x,y: dataset 
%   
% Output:
%   theta: the best model for logistic regression
%   iteration_num: number of iterations
%
%

theta1=theta0-step*gradR_logistic(x,y,theta0);
t=1;
theta_t2=theta1;
theta_t1=theta0;
while norm(theta_t2-theta_t1)>=tolerance
    theta_t1=theta_t2;
    theta_t2=theta_t1-step*gradR_logistic(x,y,theta_t1);
    t=t+1;
end
iteration_num=t
theta=theta_t2;




end

