clc; clear; close all;
% initialise vars 
dataSetSize = 5000; interations = 0;
k1CentroidPrev = [randn; randn]; k2CentroidPrev = [randn; randn]; k1Centroid = [randn; randn]; k2Centroid = [randn; randn];

% Generate data set one and two
dataSet1 = randn(2,dataSetSize); dataSet1(1,:) = -4 + dataSet1(1,:) .* .75; dataSet1(2,:) = -1 + dataSet1(2,:) .* .75;
dataSet2 = randn(2,dataSetSize); dataSet2(1,:) = 3 + dataSet2(1,:) .* 2; dataSet2(2,:) = 4 + dataSet2(2,:) .* 2;

% Merge data into one set, for seperating into clusters later
trainData = [dataSet1, dataSet2];
trainData = trainData(:,randperm(size(trainData,2))); % shuffle data

% initial unsorted plot and randomly initiated centroids
figure; hold on
plot(trainData(1,:), trainData(2,:),'b.'); 
plot(k1CentroidPrev(1),k1CentroidPrev(2),'or',k2CentroidPrev(1),k2CentroidPrev(2),'or');
title('raw data'); legend('raw data'); pause(1)

% K MEANS ALGORITHM LOOP
while (sum(k1Centroid) ~= sum(k1CentroidPrev)) && (sum(k2Centroid) ~= sum(k2CentroidPrev))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % sort data into clusters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    % update vars
    k1CentroidPrev = k1Centroid;
    k2CentroidPrev = k2Centroid;

    % compute distance to centroids for each dataPoint
    tempVector = [repmat(k1CentroidPrev,1,length(trainData)); repmat(k2CentroidPrev,1,length(trainData))];
    distToCentroid1 = sqrt(sum(trainData - tempVector(1:2,:)) .^ 2); distToCentroid2 = sqrt(sum(trainData - tempVector(3:4,:)) .^ 2);

    % sort the data into clusters
    compareDist = distToCentroid1 <= distToCentroid2;
    cluster1 = trainData .* [compareDist; compareDist]; cluster2 = trainData .* ~[compareDist; compareDist];
    
    % plot sorted data
    figure; hold on
    interations = interations + 1;
    plot(cluster1(1,:),cluster1(2,:),'.y',cluster2(1,:),cluster2(2,:),'.k');
    title(['Iteration ',num2str(interations)]); legend('Cluster1','Cluster2');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % recompute centroid
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % clean data (remove zeros) and reshape
    cluster1 = nonzeros(cluster1'); cluster1 = reshape(cluster1, 2, length(cluster1)/2);
    cluster2 = nonzeros(cluster2'); cluster2 = reshape(cluster2, 2, length(cluster2)/2);

    % take average of clusters to find new centroid coords
    centroidX = sum(cluster1(1,:))/length(cluster1); centroidY = sum(cluster1(2,:))/length(cluster1); k1Centroid = [centroidX; centroidY];
    centroidX = sum(cluster2(1,:))/length(cluster2); centroidY = sum(cluster2(2,:))/length(cluster2); k2Centroid = [centroidX; centroidY];

    % plot prev and updated centroids
    plot(k1CentroidPrev(1),k1CentroidPrev(2),'or',k2CentroidPrev(1),k2CentroidPrev(2),'or'); 
    pause(1)
    plot(k1Centroid(1),k1Centroid(2),'og',k2Centroid(1),k2Centroid(2),'og');
    pause(.5)
    
end
fprintf('interations %i \n', interations)
fprintf('fin \n')

% Here the cluster one centroid (yellow) isn’t exactly where you would expect it to be, 
% this is due to the outliers having a disproportional effect on the centroids. 
% One method to get round this would be to remove all data past 3 standard deviations 
% of each cluster and maybe ‘throw it away’ this would improve the cluster centroid.
