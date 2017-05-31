
tempVector = subset(60:150,:);

% function majorityLabel = majorityClass(dataSet)
global numCat;
global labelCol; % the col with the species

% get label vectors
% labelTemp = dataSet(:,labelCol);
labelTemp = tempVector(:,labelCol);

% create a histogram with n label bins 
h = histogram(labelTemp,numCat); % lengthdata
histVector = h.Values;

[~, idx] = max(histVector);

if idx == 1
    majorityLabel = 'setosa';
elseif idx == 2
    majorityLabel = 'versicolor';
elseif idx == 3
    majorityLabel = 'virginica';
end
% end


tempVector = subset(80:120,:);
