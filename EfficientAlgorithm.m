
% Summary of this function goes here
%   Detailed explanation goes here
% Author: Milad Chenaghlou
% Created: 2015-10-1
% Efficient Anomaly Detection
% Input----------
% Inputdata format X: (v1,v2,..,vD,clusterlabel)-> 0 (outlier)
% D is dimension
% WindowL is window length
% Output----------
% (ID,v1,v2,..,vD,clusterlabel,fuzzyindex,clusterindex)
% ConsensusModel is a struct, has two elements
% 1) clusterindex: 0/1 output for each data point-> 0 (outlier)
% 2) fuzzyindex: fuzzy probability of outlierness-> 0 (normal)
%Clusters.center: This is the mean of the modelled cluster
%Clusters.matA: This is the variance of the modelled cluster
%=======================================================
% 7th column of resultFile is the weight of it.
function [resultFile, ConsensusModel, numOfWindows, SingleClusters] = EfficientAlgorithm( X, D, WindowL, anomalyLabel, k, P_Value, densityThreshold)

% Prepare dataset for HyCARCE clustering
% HyCARCE Inputdata format: (v1,v2,..,vD,1(reserved),weight,clusterlabel)
dataset = [X(:,1:D) ones(size(X,1),2) X(:,D+1)];
datasetNotNormal = dataset;
dataset(:,1:D) = MinMaxNormalize(dataset(:,1:D));
if(anomalyLabel == 0)
    ConsensusModel.clusterindex = ones(length(dataset),1); % because one corresponds to normal data
    ConsensusModel.fuzzyindex = zeros(length(dataset),1); % because zero is the probability of being outlier. We assume all data are normal for initilization
else 
    ConsensusModel.clusterindex = zeros(length(dataset),1);
    ConsensusModel.fuzzyindex = ones(length(dataset),1); 
end
Clusters = [];
Clusters.occurrences = [];
%% Sliding over data set
parts = round(size(dataset,1)/WindowL);
pastStream = [];



SingleClusters = [];
for i = 1 : parts
    beginIncomming = length(pastStream)+1;
    if i == parts
        endIncomming = length(dataset);
    else
        endIncomming = length(pastStream)+WindowL;
    end
    incommingStream = dataset(beginIncomming:endIncomming , :);

    [totalDistances, totalMembers, SingleClusters] = StatisticalProcessWindow(incommingStream, SingleClusters, D, anomalyLabel, k, P_Value, densityThreshold);
    
    % This is a very important line.
    ConsensusModelWindow.clusterindex = totalMembers;
    
    for iTemp = length(pastStream) + 1 : length(pastStream) + length(incommingStream)
        ConsensusModel.fuzzyindex(iTemp) = totalDistances(iTemp - length(pastStream));
        if ConsensusModelWindow.clusterindex(iTemp - length(pastStream)) == anomalyLabel
            ConsensusModel.clusterindex(iTemp)= anomalyLabel;
        end
    end
    
%     ProccessWindowResults(ConsensusModel.clusterindex(length(pastStream) + 1: length(pastStream) +length(incommingStream)), incommingStream, D, RecordClusters, 1, SingleClusters, anomalyLabel);
    pastStream = [pastStream ; incommingStream];
end
%% Prepare output



numOfWindows = parts;

ID = 1:length(dataset);
resultFile = [ID' datasetNotNormal(:,1:D) dataset(:,D+3) ConsensusModel.fuzzyindex ConsensusModel.clusterindex];


end

