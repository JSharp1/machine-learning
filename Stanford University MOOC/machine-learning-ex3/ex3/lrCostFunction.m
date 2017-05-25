function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
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
%
% Hint: The computation of the cost function and gradients can be
%       efficiently vectorized. For example, consider the computation
%
%           sigmoid(X * theta)
%
%       Each row of the resulting matrix will contain the value of the
%       prediction for that example. You can make use of this to vectorize
%       the cost function and gradient computations. 
%
% Hint: When computing the gradient of the regularized cost function, 
%       there're many possible vectorized solutions, but one solution
%       looks like:
%           grad = (unregularized gradient for logistic regression)
%           temp = theta; 
%           temp(1) = 0;   % because we don't add anything for j = 0  
%           grad = grad + YOUR_CODE_HERE (using the temp variable)
%


% this code itterates round until convergence the error is close to zero


h = sigmoid(X*theta);       % hypothesis, h of x
term1 = -y' * log(h);       
term2 = (1 - y') * log(1 - h); 
term3 = term1 - term2;
J = term3 * (1/m);          % unregularizedCost function

grad = (1/m) * (X' * (h - y));


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

grad = grad(:);

end
