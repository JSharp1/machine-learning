function reward = rewardFunction(state, action)
%  check to see if we are at goal
    if (state == 5) && (action == 3)
        reward = 10;
    else 
        reward = 0;
    end
end





