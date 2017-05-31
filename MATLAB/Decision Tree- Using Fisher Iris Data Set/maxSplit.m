function [colOfThresh, splitVal] = maxSplit(currentDataSet);
% cycle through subset for the max information gain 
% return the coloum and threshold value

global numVars; 
infoGainPrev = -inf;

for xj = 1:numVars % for each coloum /or variable (in dataset)
    for vk = 1:length(currentDataSet)% increment the threshold Val
%         fprintf('col is %d--threshold idx is %d \n', xj, vk);
        threshVal = currentDataSet(vk,xj); % get the threshold val
        % split the data set on the threshold Val
        [split1, split2] = split(currentDataSet, xj, threshVal); 
        % find the gain in information for the split
        infoGain = improvement(currentDataSet, split1, split2);
        % check if the split gained more information than the last one
        % and save the variable/col and threshold value
        if infoGain > infoGainPrev
            colOfThresh = xj;
            splitVal = threshVal;
            infoGainPrev = infoGain;
        end
    end
end

% change the subset label in col 6 of data


end
