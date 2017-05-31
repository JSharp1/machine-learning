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
% testSet = subset(1:90,:);
% entropyRet = entropy(testSet)
% [colOfThresh, splitVal] = maxSplit(si);
% [split1, split2] = split(si, 3, 1.9);
% informationGain = improvement(si, split1, split2)

% split the dataSet until no more splits
[splittingRules, majorityLabel, subset] = learnDecisionTree(subset);

