function informationGain = improvement(origSet, split1, split2)
% entropy of original set
Qsi = entropy(origSet);
% entropy of split1
entropySplit1 = entropy(split1);
% ratio to original set
normaliserSplit1 = length(split1)/length(origSet);
% entropy of split2
entropySplit2 = entropy(split2);
% ratio to original set
normaliserSplit2 = length(split2)/length(origSet);
informationGain = Qsi - ((normaliserSplit1*entropySplit1)+ (normaliserSplit2*entropySplit2));
end

