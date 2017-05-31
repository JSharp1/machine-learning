function action = actionSelect(QTable, state)
% get a random number between 1 and 10 (defines the 90%:10% ratio-
% highest Q function:random action)
Greedy = randperm(10,1);

% 9/10 of the time give the correct answer
if Greedy ~= 10
    % Retrieve the maximum values from each row (state) of QTable
    % and the col (action taken)
    [maxVals, actionidx] = max(QTable, [], 2);
    % find the best action give state  
    action = actionidx(state);
end

% 1/10 of the time give a random answer 
if Greedy == 10 
    % get a random number between 1 and 4
    action = randperm(4,1);
end
end





