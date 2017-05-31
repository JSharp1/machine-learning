function QTable = QLearningUpdate(QTable, currentState, action, newState, rewardValue)
    % Temporal Discount Rate
    gamma = 0.9;
    % Learning Rate
    alpha = 0.2;

    % Q-Learning update rule- updates one cell
    QTable(currentState,action) = QTable(currentState,action) + ...
    alpha.*(rewardValue + gamma.*QTable(newState,action) - ...
    QTable(currentState,action))
end

