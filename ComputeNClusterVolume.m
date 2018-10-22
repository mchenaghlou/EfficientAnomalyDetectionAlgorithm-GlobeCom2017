function [ volume ] = ComputeNClusterVolume( currCluster, dim )
%COMPUTENCLUSTERVOLUME Summary of this function goes here
%   Detailed explanation goes here

sigmaInv = squeeze(currCluster.matA(1,:,:));
matB = squeeze(sigmaInv);
sigmaboundary= chi2inv(0.99,dim);
charMat = matB/sigmaboundary;

alpha = AlphaFunc(dim);
volume = alpha / sqrt(det(charMat));


% eigenVector = eig(charMat)';
% primAxes = sqrt(ones(1,dim)./eigenVector);
% volume = ((pi^(dim/2)) / gamma(dim/2+1)) * prod(primAxes);



end

