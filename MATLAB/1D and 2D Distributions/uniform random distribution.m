clc; clear; close all;
% Generating a 1*n uniform probability distribution
x = rand(1,10000);
% display the size and scatter graph of data
size(x)
% create fig and give title
figure
set(gcf,'numbertitle','off','name','rand(1, 10 000)')
% subplot: first two arguments are size of grid, third is the order of the plot in the
% grid
subplot(1,2,1)
% a plot with dots
plot(x,'.'); title('Uniformly distributed random data plot')
% display new plot on existing figure
subplot(1,2,2)
% create histogram using 
histogram(x,1000); title('Histogram of uniformly distributed random data plot')
% show the size of each bin and the bin widths
[N,edges] = histcounts(x)
