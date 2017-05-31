function [splittingRules, majorityLabel, subset] = learnDecisionTree(subset)

prevSplittingRules = [0,0,0];
splittingRules = [];
majorityLabel = [];

for j = 1:inf
    % find the best value and feature to split on
    [colOfThresh, splitVal] = maxSplit(subset);
    if isequal([colOfThresh, splitVal], prevSplittingRules)
        break; 
    end
    
    %split the data set using the best parameters
    % split two is always the smaller set 
    [split1, split2] = split(subset, colOfThresh, splitVal);
    
    if length(split1) < length(split2) % split1 the best split..
        subset = split2;
        x = majorityClass(split1)
        majorityLabel{end+1} =  x;

    elseif length(split2) < length(split1) % split2 the best split..
        subset = split1;
        x = majorityClass(split2)
        majorityLabel{end+1} =  x;
    end
    
    fprintf('found split %d \n', j);

    % save the best split parameters and split number
    splittingRules = [splittingRules; colOfThresh,splitVal,j];
    prevSplittingRules = [colOfThresh,splitVal];
end


fprintf('Finished \n');
fprintf('colIdx, value, split, label \n');


finalRules = [num2cell(splittingRules),majorityLabel']


