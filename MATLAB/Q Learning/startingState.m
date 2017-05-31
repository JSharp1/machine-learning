function rndStartPos = startingState
% max random value
A = 11;
% select 1 random value from 1:A values 
rndStartPos = randperm(A,1);
% if rndStartPos == 2 recalculate
while rndStartPos == 2
%     fprintf('fail rndStartPos = %d \n', rndStartPos)
%     fprintf('recalculating \n')
    rndStartPos = randperm(A,1);
end
end
