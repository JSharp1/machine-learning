function entropyRet = entropy(dataSet)

global numCat;  % how many categories are in dataset
global labelCol;

% get label vectors
labelTemp = dataSet(:,labelCol);

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

end
