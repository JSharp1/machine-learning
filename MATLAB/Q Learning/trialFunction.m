% plot steps taken to reach goal by runing algorithm
% 100 times and updating q table
function trialStepCount = trialFunction
    % Init Q table 
    QTable = initQ;
    % Save number of steps to vector
    trialStepCount = [];
    for i = 1:100
        currentState = startingState;
        stepCount = 0;
        reward = 0;
        % loop untill the goal has been reached
        while(reward ~= 10)
            % get an action 9/10 time will be greedy algo
            % 1/10 will be random step
            action = actionSelect(QTable,currentState);
            % find the reward for the action
            reward = rewardFunction(currentState, action);
            % get the new state
            newState = transitionFunction(currentState, action);
            % update Qtable based on parameters
            QTable = QLearningUpdate(QTable, currentState, action, newState, reward);
            % update the current state and step count for next iteration 
            currentState = newState;
            stepCount = stepCount + 1;
        end
        % save the amount of steps for plot 
        trialStepCount(end+1) = stepCount;
    end

    % Plot the results to show how the q learning algo improves with each
    % iteration 
    figure(2)
    plot(trialStepCount); 
    xlabel('Episode number');
    ylabel('Number of steps');
    title('Q-Learninig performance improvement');

    figure(3)
    surf(QTable); 
    xlabel('actions');
    ylabel('states');
    zlabel('Q - Values');
    title('Q function table values after 1 episode 100 trials');
    axis([1 4 1 10 0 1]);
end