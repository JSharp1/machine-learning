function experiment
% init variables
numEpisodesPerTrial = 100;
trials = 500;
global trialStepCount;
for i = 1:trials
    trialStepCount(i,:) = trialFunction;
    fprintf('%d trial finished \n',i)
end
% find the mean and std of each episode
meanStepCount = mean(trialStepCount);
stdmeanStepCount=std(trialStepCount);
x = 1:size(trialStepCount,2);
figure(4)
shadedErrorBar(x,meanStepCount,stdmeanStepCount);
xlabel('Episode number');
ylabel('Number of steps');
title('Mean and standard diviation of Q- learning performance over 500 trials');
end





