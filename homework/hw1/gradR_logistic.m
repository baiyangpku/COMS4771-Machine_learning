function [ grad_R ] = gradR_logistic( x,y,theta )
%
% calculate the gradient of Risk function of logistic regression 
%
% Input:
%   x,y: dataset
%   theta: the vector used for logistic regression
%   
% Output:
%   grad_R: gradient 
% 


fx=1.0./(1+exp(-x*theta));

grad_R=(1.0/length(x)*sum(repmat((fx-y),1,length(theta)).*x))';


end

