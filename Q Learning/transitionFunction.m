function newState = transitionFunction(currentState, action)
    % 1 = N, 2 = E, 3 = S, 4 = W
    % Check to see which state we are in (McCallum
    % learning grid-world)
    if (currentState == 1) && (action == 1)
        newState = 4;     
    elseif (currentState == 4) && (action == 1)
        newState = 7;
    elseif (currentState == 4) && (action == 3)
        newState = 1;    
    elseif (currentState == 7) && (action == 2)
        newState = 8;
    elseif (currentState == 7) && (action == 3)
        newState = 4;    
    elseif (currentState == 8) && (action == 2)
        newState = 9;
    elseif (currentState == 8) && (action == 4)
        newState = 7;    
    elseif (currentState == 9) && (action == 3)
        newState = 5;
    elseif (currentState == 9) && (action == 2)
        newState = 10;
    elseif (currentState == 9) && (action == 4)
        newState = 8;    
    elseif (currentState == 10) && (action == 4)
        newState = 8;
    elseif (currentState == 10) && (action == 2)
        newState = 11;    
    elseif (currentState == 11) && (action == 4)
        newState = 9;
    elseif (currentState == 11) && (action == 3)
        newState = 6; 
    elseif (currentState == 6) && (action == 1)
        newState = 11;
    elseif (currentState == 6) && (action == 3)
        newState = 6;
    elseif (currentState == 3) && (action == 1)
        newState = 6;  
    elseif (currentState == 5) && (action == 3)
        newState = 2;
    elseif (currentState == 5) && (action == 1)
        newState = 9;
    else
        newState = currentState;
%       fprintf('not a valid move \n')
    end
end