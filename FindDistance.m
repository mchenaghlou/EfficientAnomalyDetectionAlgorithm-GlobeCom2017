function [ distances ] = FindDistance( InputData ,matA, centers )
%======================================================
count=size(matA,1);
dim = size(matA,2);
for i=1:1:count
    matB = squeeze(matA(i,:,:));
%     matB = matA;
    center = centers(i,:);
%     center = centers;
    mahaldist=(InputData(:,1:dim)-repmat(center,size(InputData,1),1))*matB.*(InputData(:,1:dim)-repmat(center,size(InputData,1),1));
    mahaldist = sum(mahaldist,2);
end
distances = mahaldist;


% XmM=bsxfun(@minus,InputData ,centers);
% 
% res = XmM * matB * XmM';
% res2 = diag(res);



end