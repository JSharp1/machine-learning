function initalQTable = initQ
% create an 11x4 matrix of values with in bounds... (11 states 4 actions)
% Eventually after many iterations the q table will give us the best 
% actions to take given a state
upperBound = 0.1; lowerBound = 0.01;
% Generate initial Q table
% generate N random numbers in the interval (a,b) with the formula  
% r = a + (b-a).*rand(N,1)... from matlab rand help page
initalQTable = lowerBound + (upperBound-lowerBound).*rand(11,4);
% Plot the initial Q table
figure(1)
surf(initalQTable);
xlabel('actions');
ylabel('states');
zlabel('Q - Values');
title('Q function table initial values');
axis([1 4 1 10 0 1]);
end




