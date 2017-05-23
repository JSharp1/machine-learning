% reset the workspace
clc; clear all; close all;
% program constants
xAxisStart = -4;
xAxisEnd = 6;
a = 1.6;
b = 2.5;
c = 6;

% generate 100 evenly spaced for plotting
x = linspace(xAxisStart, xAxisEnd);
% now use straight line equation with parameters 
y = (a.*x.^2)+b.*x+c;
% add some noise to sample points
% randn- to change the mean we can simply add to each element 
% to change the standard diviation we can multiply each element
yWithNoise = y + 5.*randn(1,100);
% create a figure and plot vectors
figure;
hold on;
plot(x,yWithNoise,'-b.'); title('Quadratic randn curve with fitted linear and quadratic lines');

% To use regress to find the two parameters a b, xLin is needed for linear
% regrees function
xLin = [x; ones(1,max(size(x)))];
xLinparameters = regress(yWithNoise', xLin');
% now use them in the straight line equation and plot
y = xLinparameters(1)*x+xLinparameters(2);
plot(x,y,'-r.');

% regrees function
quad = [x.*x; x; ones(1,max(size(x)));];
xQuadparameters = regress(yWithNoise', quad');
% now use them in the straight line equation and plot
y = (xQuadparameters(1).*x.^2)+xQuadparameters(2).*x+xQuadparameters(3);
plot(x,y,'-g');

