function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

[J, grad] = costFunction(theta, X, y);
h = sigmoid(X*theta);       % hypothesis, h of x
theta1 = theta;
theta1(1) = 0;

% The regularization parameter lambda is a control on your fitting parameters. 
% As the magnitues of the fitting parameters increase, there will be an increasing penalty on the cost function. 
% This penalty is dependent on the squares of the parameters as well as the magnitude of lambda. 
% Also, notice that the summation after lambda does not include  theta{0}^{2}

regularization  = sum(theta1 .^ 2) * (lambda / (2 * m));

J = J + regularization;

grad = (1/m) * (X' * (h - y)) + ((lambda / m) * theta1) ;



% =============================================================

end
