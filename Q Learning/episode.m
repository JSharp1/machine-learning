function episode
% init parameters
QTable = initQ;
currentState = startingState;
Counter = 0;
reward = 0;
% loop untill the goal has been reached
while(reward ~= 10)
    % choose an action
    action = actionSelection(QTable,currentState);
    % get the reward based on action taken
    reward = rewardFunction(currentState, action);
    % move to the new state
    newState = transitionFunction(currentState, action);
    % update the Q table using the Q-learning algorithm
    QTable = QLearningUpdate(QTable, currentState, action, newState, reward);
    % update and increment counter
    currentState = newState;
    Counter = Counter + 1;
end
% Output the number of steps taken
display(sprintf('Number of steps required to reach the goal were %d \n', Counter));
end




