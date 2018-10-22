function [ PP] = StatisticalProcessModelPercents( incommingStream, currCluster, dim)
%STATISTICALPROCESSNEWMODEL: This functions determines how many
%observations of current window belongs to the currCluster. No
%sophisticated calculations go here.
%   Detailed explanation goes here

incStreamForPosterior = incommingStream(:,1:dim);
pages = size(currCluster.matA);
numOfComponents = pages(length(1));
for jj = 1:numOfComponents
    mu = currCluster.center(jj,:);
    sigmaInv = currCluster.matA(jj,:,:);
    P = mvnpdf(incStreamForPosterior, mu,  inv(squeeze(sigmaInv(1,:,:))));
    PP = P';
end

% incStreamForPosterior = incommingStream(:,1:dim);
% mu = currCluster.center(1,:);
% sigmaInv = currCluster.matA(1,:,:);
% P = mvnpdf(incStreamForPosterior, mu,  inv(squeeze(sigmaInv(1,:,:))));
% PP = P';
end