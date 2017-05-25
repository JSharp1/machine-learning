function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

    h = X*theta; % our hypothesis
    err_ = (h - y);   % the error of our guess
    deltaTheta = (1/m)*alpha* (X' * err_);    % gradient
    theta = theta - deltaTheta;
    
    % ============================================================
 
    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);
    
end 

end
