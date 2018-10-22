%======================================================
% Author: Masud Moshtaghi
% Created: 2009-10-01
% Assigned inputs to grid cells of size CellSize and then replace them with
% ellipsoids. 
% Inputdata format (v1,v2,..,vD,1(reserved),weight,clusterlabel)
% Weight can be a natural number that give a weight to some of the
% samples and it only work for 2D data. In all other cases it should be 1
%=======================================================

function [matA centers DataSamples EVolume] = BoxGrid(InputData ,CellSize, D)

boxvolume = prod(CellSize);
inputindex=zeros(size(InputData,1),1);
set=[];
indexset=0;
indextoremove=[];
averagepoints=0;
%= find and index non-empty grid-cells
for i=1:1:size(InputData,1)
    multiplier=1;
    Res =0;
    found = 0;
    for j=1:1:D
      Res = Res+multiplier*(floor(InputData(i,j)/CellSize(j))+1);
      multiplier=multiplier*1000;
    end
    inputindex(i,1)=Res;
    for j=1:1:indexset
        if set(j,1)==Res
            set(j,2) = set(j,2)+1;
            set(j,4:3+D) = (InputData(i,1:D)*InputData(i,D+2))/set(j,2)+(set(j,4:3+D)*(set(j,2)-InputData(i,D+2)))/set(j,2);
            set(j,3)=norm(set(j,4:3+D));
            found =1;
        end
    end
    if found==0
      indexset = indexset+1;
      set = [set;[Res 1 norm(InputData(i,1:D)) InputData(i,1:D)]];
    end
    
end

%= Prune cells with low data samples
averagepoints = mean(set(:,2));
minpoint = (D*(D+3))/2; % in high dimensional data this value can be replaced by a constant
[indextoremove col] = find(set(:,2)<max(averagepoints-std(set(:,2)),minpoint));
set(indextoremove,:)=[];
DataSamples =zeros(size(set,1),1);
matA = zeros(size(set,1),D,D);
centers = zeros(size(set,1),D);
EVolume = zeros(size(set,1),1);
indextoremove=[];
%= Find elliptical boundaries over each cell
for i=1:1:size(set,1)
 [row col]= find(inputindex(:,1)==set(i,1));

 DataSamples(i,1)=sum(InputData(row,D+2));
 meanD = InputData(row,1:D)'*InputData(row,D+2)/DataSamples(i,1);
 %= finding the covariance matrix considering weight for 2D data
 if D==2 
 Temp = InputData(row,1:D)-repmat(meanD',size(row,1),1);
 Temp = [Temp.*Temp Temp(:,1).*Temp(:,2)];
 Temp = Temp'*InputData(row,D+2)/(DataSamples(i,1)-1);
 if Temp(1,1)==0
     Temp(1,1)=1;
 end
 if Temp(2,1)==0
     Temp(2,1)=1;
 end
 matA(i,1,1) = Temp(1,1);
 matA(i,2,2)=Temp(2,1);
 matA(i,1,2)=Temp(3,1);
 matA(i,2,1)=Temp(3,1);
 Temp=squeeze(matA(i,:,:));
else
    Temp = cov(InputData(row,1:D));
end
Temp=inv(Temp);
DataSamples(i,1) = 0.95*DataSamples(i,1);
vol = sqrt(det(Temp/chi2inv(0.95,D)));
vol=AlphaFunc(D)/vol;
EVolume(i,1)=vol;
centers(i,:) = meanD;
matA(i,:,:) = Temp;
end
matA(indextoremove,:,:)=[];
centers(indextoremove,:)=[];
DataSamples(indextoremove,:) =[];
EVolume(indextoremove,:) =[];
clear row ind i j indextoremove set col Temp distanceset indexset indextoremove
end