function [ volume ] = UnionVolume( SingleClusters, dim )
%UNIONVOLUME This method finds the sum of the areas, volumes of ellipses.
%   Detailed explanation goes here

pr = 50;
numOfPoints = (pr+1)^dim;


bit = 1/pr;
X1 = 0:bit:1;
if (dim == 2)
    ss =  cartprod(X1, X1);
elseif(dim == 3)
    ss =  cartprod(X1, X1, X1);
end

totalMembers = zeros(1, length(ss));
ss = [ss, ones(numOfPoints,1), ones(numOfPoints,1)];
for i = 1:length(SingleClusters)
    currCluster = SingleClusters(i);
    tempCurrentCompMembers = FindClusterIndex(ss, currCluster.matA, currCluster.center)';
    tempCurrentCompMembers = tempCurrentCompMembers > 0;
    totalMembers = totalMembers | tempCurrentCompMembers;
%     sigmaInv = squeeze(currCluster.matA);
% %         clf
%         hold on
%         Ellipse_Plot( sigmaInv, currCluster.center ,i ,[0,0,0]);
%         drawnow
%         axis([0 1 0 1 0 1]);
    
    
end

volume = sum(totalMembers)/(numOfPoints);
if(volume == 0)
    volume = 0.000000001;
end
end

