function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
%J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

h = X*theta; % our hypothesis
err_ = h - y;   % the error of our guess
err_Sqr = err_ .^2; 
errorSqrSum = sum(err_Sqr); % the sum of squared differences
J = .5 * 1/m * errorSqrSum; 

% =========================================================================

end
