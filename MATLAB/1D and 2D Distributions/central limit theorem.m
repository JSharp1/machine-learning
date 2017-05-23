clc; clear; close all;
% Generating a n uniform probability distribution in the interval (0,1)
x = rand(10000,'distributed');
% display the size of matrix
size(x)
% average each row
m = mean(x, 2);
% create fig and give title
figure; set(gcf,'name','P2: 100000000 data points')
% subplot: first two arguments are size of grid, third is the order of the plot in the
% grid
subplot(1,2,1)
plot(m,'.'); title('plot of sample row index vs mean sample value of 10 000')
subplot(1,2,2)
histogram(m,1000); title('Histogram of sample values')
