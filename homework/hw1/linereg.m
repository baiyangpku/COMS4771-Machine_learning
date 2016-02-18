function [err,risk,model,errT,riskT] = linereg(xR,yR,lamda,xT,yT)
%
% Finds a linear fit to the data
%
%    function [err,risk,model,errT,riskT] = polyreg(x,y,xT,yT)
%
% xR = vector of input scalars for training
% yR = vector of output scalars for training
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% risk = regularized risk of training 
% model = vector of linear coefficients
% errT = average squared loss on testing
% riskT= regularized risk of testing
%


[rowx,colx] = size(xR);
I  =  eye(colx);
model  = (xR'*xR+lamda.*I)\(xR'*yR);

err  = (1/(2*rowx))*sum((yR-xR*model).^2);
risk  = (1/(2*rowx))*sum((yR-xR*model).^2)+lamda/2.0/rowx*(model'*model);

if (nargin==5)
    
  errT  = (1/(2*length(xT)))*sum((yT-xT*model).^2);  
  riskT  = (1/(2*length(xT)))*sum((yT-xT*model).^2)+lamda/2.0/length(xT)*(model'*model);

end



