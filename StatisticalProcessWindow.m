function [totalDistances, totalMembers, SingleClusters] = StatisticalProcessWindow( incommingStream, SingleClusters, dim, anomalyLabel, k, P_Value, densityThreshold)
%PROBABILISTICALLYBELONG Summary of this function goes here
%   Detailed explanation goes here

% k = 10;
% % Cluster Boundary
% P_Value = 0.95;

% Determines which observations belong to the cluster
maxRatio = 1-P_Value;


% densityThreshold = 0.5;

wl = size(incommingStream, 1);
pIncommingStream = incommingStream(:,1:dim);

numOfModels = length(SingleClusters);
totalMembers = zeros(1, wl);
totalDistances = zeros(1, wl);


for i = 1:numOfModels
    currCluster = SingleClusters(i);
    mu = currCluster.center(1,:);
    sigmaInv = currCluster.matA(1,:,:);
    


    
    dists = FindDistance(pIncommingStream, currCluster.matA(1,:,:), currCluster.center(1,:,:));
    
    mems = (dists <= chi2inv(P_Value, dim));
    clusterCount = sum(mems);
    
    mems = 2.*mems;
    mems=bsxfun(@minus,mems ,1);
    
    v = currCluster.volume;
    
    cumProb = binocdf(clusterCount, wl, v);
    
%     mems2 = zeros(clusterCount, dim);
    
    m = repmat(mems,1, dim);
    
%     for j = 1:dim-1
%         mems2 = [mems2, mems];
%     end
    
    memberData = m .* incommingStream(:,1:dim);
    memberDists = mems .* dists;
    
    [badrows,c]=find(memberData<0);
    memberData = memberData(setdiff(1:size(memberData,1),badrows),:);
    [badrows,c]=find(memberDists<0);
    memberDists = memberDists(setdiff(1:size(memberDists,1),badrows),:);
    
    if(cumProb > densityThreshold )
%         scatter3(memberData(:,1),memberData(:,2), memberData(:,3),'.');
%         axis([0 1 0 1 0 1])
        [normalMemberData ]= ToNormalStandard(memberData, mu, inv(squeeze(sigmaInv)));
        
        [normalPolar] = ToPolarCoordinates(normalMemberData);
        
%         clf
%         scatter3(normalPolar(:,3),normalPolar(:,2), normalPolar(:,1),'.');
%         drawnow
        res = processRadar(normalPolar, memberDists, dim, k, P_Value);
        
        if(res == 1)
            PP = StatisticalProcessModelPercents(incommingStream, currCluster, dim);
            members = (PP >= maxRatio*max(PP));
            totalMembers = totalMembers | members;
            totalDistances = max(totalDistances, PP);
        end
    else
        milad = 1;
    end
end

ttt = totalMembers';
ttt = ~(ttt > 0);
ttt = repmat(ttt,1, dim);
others = ttt.*pIncommingStream ;
others( ~any(others,2), : ) = [];
doClustering = calculateFrequencies(others, dim, densityThreshold, wl);
% doClustering = 1;
if(doClustering == 0)
    milad = 1;
end
if( doClustering == 1)
    SingleClustersIterator = numOfModels + 1;
    [Clusters.matA, Clusters.center, Clusters.clusterindex, Clusters.dCountHistory] = HyCARCE(incommingStream,dim,0.1);
    
    pages = size(Clusters.matA);
    numOfComponents = pages(length(1));
    
    
    for ii = 1:numOfComponents
        
        SingleClusters(SingleClustersIterator).matA = Clusters.matA(ii,:,:);
        SingleClusters(SingleClustersIterator).center = Clusters.center(ii,:);
        SingleClusters(SingleClustersIterator).clusterindex = Clusters.clusterindex(:,1);
        SingleClusters(SingleClustersIterator).volume = ComputeNClusterVolume(SingleClusters(SingleClustersIterator), dim);
        
        currCluster = SingleClusters(SingleClustersIterator);
        mu = currCluster.center(1,:);
        sigmaInv = currCluster.matA(1,:,:);
        dists = FindDistance(pIncommingStream, sigmaInv, mu);
        mems = (dists <= chi2inv(P_Value,dim));
        clusterCount = sum(mems);
        
        
        v = SingleClusters(SingleClustersIterator).volume;
        cumProb = binocdf(clusterCount, wl, v);
        
        
        if(cumProb > densityThreshold)
            PP = StatisticalProcessModelPercents(incommingStream, currCluster, dim);
            members = (PP >= maxRatio*max(PP));
            totalMembers = totalMembers | members;
            totalDistances = max(totalDistances, PP);
            
        else
            SingleClusters(SingleClustersIterator) = [];
            SingleClustersIterator = SingleClustersIterator - 1;
        end
        
        SingleClustersIterator = SingleClustersIterator + 1;
    end
else
    milad = 1;
end
totalMembers = totalMembers > 0;
end