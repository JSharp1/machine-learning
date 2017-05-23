% reset the workspace etc
clc; clear; close all;
% set amount of data points
trainingSamples = 1000;
testingSamples = 100000;
% get training and testing data
[trainingData, trainingTarget] = GenerateGaussianData(trainingSamples);
[testingData, testingTarget] = GenerateGaussianData(testingSamples); 
% plot the training data and classes
figure;
hold on;
plot(trainingData(1,1:1000),trainingData(2,1:1000),'.b');
plot(trainingData(1,1001:2000),trainingData(2,1001:2000),'.r');
title('Input training data')
xlabel('X-value'); ylabel('Y-value');
legend('Class a','Class b');

% part 2 
% seperate the training data into classes
training_dataClass_a = trainingData(:,1:1000)';
training_dataClass_b = trainingData(:,1001:2000)';

% compute the means of x and y for training data, class a and b
mu(1,:) = sum(training_dataClass_a)./trainingSamples; 
mu(2,:) = sum(training_dataClass_b)./trainingSamples; 
mean_a = mu(1,:);
mean_b = mu(2,:);

% find the standard div of x and y for training data, class a and b
stdDiv_a = (training_dataClass_a - repmat(mean_a,trainingSamples,1));
stdDiv_a = stdDiv_a.^2;
stdDiv_a = sqrt(1/trainingSamples*(sum(stdDiv_a)));

stdDiv_b = (training_dataClass_b - repmat(mean_b,trainingSamples,1));
stdDiv_b = stdDiv_b.^2;
stdDiv_b = sqrt(1/trainingSamples*(sum(stdDiv_b)));

% Part 3
% now use parameters found from training data in gaussian functions
% this will return a vectors of values that correspond to the 
% gaussian distributions of class a and b 
testingData = testingData';
Px_Given_a = ( 1/ sqrt(2*pi) * stdDiv_a(1) ) * exp( -(  testingData(:,1) - repmat(mean_a(1),2*testingSamples,1) ) .^2  / (2*stdDiv_a(1)^2) );
Py_Given_a = ( 1/ sqrt(2*pi) * stdDiv_a(2) ) * exp( -(  testingData(:,2) - repmat(mean_a(2),2*testingSamples,1) ) .^2  / (2*stdDiv_a(2)^2) );
Pxy_Given_a = Px_Given_a .* Py_Given_a;

Px_Given_b = ( 1/ sqrt(2*pi) * stdDiv_b(1) ) * exp( -(  testingData(:,1) - repmat(mean_b(1),2*testingSamples,1) ) .^2  / (2*stdDiv_b(1)^2) );
Py_Given_b = ( 1/ sqrt(2*pi) * stdDiv_b(2) ) * exp( -(  testingData(:,2) - repmat(mean_b(2),2*testingSamples,1) ) .^2  / (2*stdDiv_b(2)^2) );
Pxy_Given_b = Px_Given_b .* Py_Given_b;

% now find the LIKLEYHOOD that an x y value came from class a or b
Pa_Given_xy = Pxy_Given_a .* .5 ./(Px_Given_a .* .5 + Py_Given_b .* .5); 
Pb_Given_xy = Pxy_Given_b .* .5 ./(Px_Given_a .* .5 + Py_Given_b .* .5); 
% simplify variable names
a = Pa_Given_xy;
b = Pb_Given_xy;

% for each element in a and b check the probability that it came from class a or b 
% get the index of testingData for class a or b
a_idx = find ( a > b); 
b_idx = find ( b >= a);
% using the index get the values
a_est_data = testingData(a_idx,:);
b_est_data = testingData(b_idx,:);

% plot the class vectors
figure;
hold on;
plot(a_est_data(:,1),a_est_data(:,2),'.b');
plot(b_est_data(:,1),b_est_data(:,2),'.r');
title('Input test data')
xlabel('X-value'); ylabel('Y-value');
legend('Class a','Class b');
