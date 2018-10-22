function [totalPValues, totalMembers, ConsensusModel] = StatisticalInjectNewModel(incommingStream, Clusters, dim, totalPValues, totalMembers)
%INJECTNEWMODEL Summary of this function goes here
%   Detailed explanation goes here
currCluster = Clusters(length(Clusters));
modelResult = StatisticalProcessModelPercents(incommingStream, currCluster, dim);
totalMembers = modelResult.members | totalMembers;
ConsensusModel.clusterindex = totalMembers;
end

