function [split1, split2] = split(set, colIndex, threshHold)

% split1 = values in set greater than threshHold
split1 = set( set(:,colIndex) > threshHold       ,:);

% split2 = values in set less than or equal to threshHold
split2 = set( set(:,colIndex) <= threshHold       ,:);

end
