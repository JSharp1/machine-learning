% reset the workspace
clc; clear all; close all;
% program constants
xAxisStart = -4;
xAxisEnd = 6;
m = 1.6;
c = 6;
% generate 100 evenly spaced 
x = linspace(xAxisStart, xAxisEnd);
% now use straight line equation with parameters 
y = m*x+c;
% add some noise to sample points
yWithNoise = y + randn(1,100);
% create a figure and plot vectors
figure;
hold on;
plot(x,yWithNoise,'-b.'); title('Graph of y = mx+c (against 100 evenly spaced points) with added noise');
Y = yWithNoise;
X=x;
%// Get total number of points
n = numel(X);

% // Define relevant quantities
sumxi = sum(X);
sumyi = sum(Y);
sumxiyi = sum(X.*Y);
sumxi2 = sum(X.^2);
sumyi2 = sum(Y.^2);

%// Determine slope and intercept
m = (sumxi * sumyi - n*sumxiyi) / (sumxi^2 - n*sumxi2);
c2 = (sumxiyi * sumxi - sumyi * sumxi2) / (sumxi^2 - n*sumxi2);

%// Display them
disp([m c2])
y = m*x+c2;
plot(x,y,'-r.');
