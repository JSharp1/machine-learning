clear; clc; format short;
load fisheriris;
% global variables
global numVars; numVars = 4;
global numCat; numCat = 3;% number of categories 
global labelCol; labelCol = 5; % the col with the species

% create copy of dataset
subset = meas;
% append species as number 
subset(1:50, 5) = 1; % Setosa
subset(51:100, 5) = 2; % Versicolour 
subset(101:150, 5) = 3; % Virginica
testData = subset(1:4,:);
% get label vectors
labelTemp = testData(:,labelCol);

% create a histogram with n label bins 
h = histogram(labelTemp,numCat); % lengthdata
histVector = h.Values;

% if present remove zeros from hist vector messing up entrophy equation
histVector(histVector==0) = [];

% do entropy equation
s = sum(histVector);
c = histVector;
pc = c./s;
entropyRet = -(pc).*log2(pc);
entropyRet = sum(entropyRet);