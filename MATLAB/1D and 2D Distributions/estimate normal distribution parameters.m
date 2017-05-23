clc; clear all; close all;
n = 10000;
% create a random distribution with n samples
randnDist = randn(n,1);
% test: check size and range of vector
size(randnDist); min(randnDist); max(randnDist);
% sort the random distrubution of data points using a histogram with 100 bins 
% hist returns randnDistBins 
[randnDistBins, xMid] = hist(randnDist,100);
% normalise the data vector
rescaledRandDist = randnDistBins / n;
% test: the sum of data should equal 1 same as the area under a gaussian
rescaledSum = sum(rescaledRandDist); 

% plot a normal PDF by using the mean and variance of the randnDist
MEAN = mean(randnDist);
stdDiv = std(randnDist); % the standard diviation is the sqrt(variance)
normPDF = normpdf(xMid, MEAN, stdDiv);
% normalise the data vector
rescaled2 = normPDF / sum(normPDF);
% test: the sum of data should equal 1 same as the area under a gaussian
rescaledSum2 = sum(rescaled2); 

% plot 
figure
hold on
title('Histogram of random normal dist, with a gaussian plotted from its mean and std deviation  ');
xlabel('100 bins of 10000 datapoints scaled so that the area under the curve is 1');
ylabel('Value');
plot(xMid, rescaled2) % Gaussian dist
plot(xMid, rescaledRandDist,'.'); % hist of random normal dist  

