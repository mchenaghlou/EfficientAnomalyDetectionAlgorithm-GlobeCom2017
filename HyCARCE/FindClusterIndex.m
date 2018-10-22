%======================================================
% Author: Masud Moshtaghi
% Created: 2009-10-07
% Find a cluster index for the input data, with elliptical clusters 
% reshaper the boundary of each cluster
%=======================================================
function [ClusterIndex newMatA newCenters] = FindClusterIndex(InputData ,matA, centers)

count=size(matA,1);
dim = size(matA,2);
newMatA = zeros(count,dim,dim);
newCenters = zeros(count,dim);
sigmaboundary= chi2inv(0.95,dim);%sqrt(dim*4*100/9);%chi2inv(0.99,dim);
ClusterIndex = zeros(size(InputData,1),1);
for i=1:1:count
    matB = squeeze(matA(i,:,:));
    center = centers(i,:);
    mahaldist=(InputData(:,1:dim)-repmat(center,size(InputData,1),1))*matB.*(InputData(:,1:dim)-repmat(center,size(InputData,1),1));
    mahaldist = sum(mahaldist,2);
    [row col] = find(mahaldist<=sigmaboundary);
    for j=1:1:numel(row)
        if ClusterIndex(row(j),1)==0
            ClusterIndex(row(j),1)=i;
        else
           if norm(InputData(row(j),1:dim)-centers(ClusterIndex(row(j),1),:)) > norm(InputData(row(j),1:dim)-centers(i,:))
               ClusterIndex(row(j),1)=i;
           end   
            
        end
    end
end
indextoremove=[];
for i=1:1:count
    [row col]= find(ClusterIndex(:,1)==i);
    samples = sum(InputData(row,dim+2));
    if samples < (dim*(dim+3))/2
        indextoremove = [indextoremove;i];
        continue;
    end
    newCenters(i,:) = InputData(row,1:dim)'*InputData(row,dim+2)/samples;
    if dim==2 
    Temp = InputData(row,1:dim)-repmat(newCenters(i,:),size(row,1),1);
    Temp = [Temp.*Temp Temp(:,1).*Temp(:,2)];
    Temp = Temp'*InputData(row,dim+2)/(samples-1);
    if Temp(1,1)==0
         Temp(1,1)=1;
    end
    if Temp(2,1)==0
       Temp(2,1)=1;
    end
    newMatA(i,1,1) = Temp(1,1);
    newMatA(i,2,2)=Temp(2,1);
    newMatA(i,1,2)=Temp(3,1);
    newMatA(i,2,1)=Temp(3,1);
    Temp=squeeze(newMatA(i,:,:));
    else
      Temp = cov(InputData(row,1:dim));
    end
    Temp = cov(InputData(row,1:dim));
    Temp=inv(Temp);
    newMatA(i,:,:) = Temp;
end
newMatA(indextoremove,:,:)=[];
newCenters(indextoremove,:)=[];
clear count sigmaboundary center matB
end