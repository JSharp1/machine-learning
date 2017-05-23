clc; clear all; close all;
% the randn function by default has a standard diviation=1 and mean=0 
stdDev = 1;
mean = 0;
% here to change the mean we can simply add to the data points
% to change the stdDev the data points are multiplied by a coefficient 
data = stdDev .* randn(2,10000) + mean;
% print the size of the data
size(data)
% split the data into 2 vectors
x = data(1,:)
y = data(2,:)
% label axis and plot against each other
xlabel('vector 1') % x-axis label
ylabel('vector 2') % y-axis label
plot(x,y,'.'); title('two normaly distrubuted arrays plotted against each other');
