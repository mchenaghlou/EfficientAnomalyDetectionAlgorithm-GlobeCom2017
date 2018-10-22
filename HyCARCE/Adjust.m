%======================================================
% Author: Masud Moshtaghi
% Created: 2010-05-31
% Adjust correlation and center of data checks the levelset info
%=======================================================

function [matB meanD dcount] = Adjust(data,D, mahaldist1,gridcellsize)
removable=0;
s = sum(data(:,D+2));
mThreshold = chi2inv(0.9,D);
 meanD = data(:,1:D)'*data(:,D+2)/s;
 [row col] = find(mahaldist1<=mThreshold);
 data50 = data(row,:);
 s = sum(data50(:,D+2));
 % covariance calculation for 2D on weighted data
 if(D==2)
    Temp = data50(:,1:2)-repmat(meanD',size(data50,1),1);
    Temp = [Temp.*Temp Temp(:,1).*Temp(:,2)];
    Temp = Temp'*data50(:,4)/(s-1);
    matB(1,1) = Temp(1,1);
    %= zero on digonal cause the covariance matrix to be singular
    if Temp(1,1)==0
      matB(1,1) =1;
    end
    matB(2,2)=Temp(2,1);
    if Temp(2,1)==0
      matB(2,2) =1;
    end
    matB(1,2)=Temp(3,1);
    matB(2,1)=Temp(3,1);
    Temp=matB;
% The covariance matrix for D>2
 else
    Temp = cov(data50(:,1:D));
 end
 matB=inv(Temp);

 mThreshold = chi2inv(0.9,D);
 mahaldist=(data(:,1:D)-repmat(meanD',size(data,1),1))*matB.*(data(:,1:D)-repmat(meanD',size(data,1),1));
 mahaldist = sum(mahaldist,2);
 levelsets = 0:1:mThreshold*2;
 levelsets = levelsets*0;
 levelsets(1) = (0.9*s);
increasflag=0;
max = 0;
% Calculate the number of data in different levelsets
for i=1:1:mThreshold*2
    increasflag = increasflag-1;
    [row1 col] = find(mahaldist<=i/2 & mahaldist>(i-1)/2);
    levelsets(i+1)= sum(data(row1,D+2));
    if((levelsets(i+1)>max))
        max = levelsets(i+1);
        % if a levelset other than 1 has the maximum number
        if(i>1)
           newmeanD = data(row1,1:D)'*data(row1,D+2)/sum(data(row1,D+2));
           removable=1;
           meanD = newmeanD;
        end
    end
end

dcount = sum(levelsets(2:numel(levelsets)));
mThreshold = gridcellsize^2;%chi2inv(0.9,D);
%= levelset shift occurs update the boundary
if(removable>=1)
    mahaldist=(data(:,1:D)-repmat(meanD',size(data,1),1))*eye(D).*(data(:,1:D)-repmat(meanD',size(data,1),1));
    mahaldist = sum(mahaldist,2);
    [row col] = find(mahaldist<=mThreshold);
     data50 = data(row,:);
     s = sum(data50(:,D+2));
     dcount =s;
 if(D==2)
 Temp = data50(:,1:2)-repmat(meanD',size(data50,1),1);
 Temp = [Temp.*Temp Temp(:,1).*Temp(:,2)];
 Temp = Temp'*data50(:,4)/(s-1);
 matB(1,1) = Temp(1,1);
 if Temp(1,1)==0
     matB(1,1) =1;
 end
 matB(2,2)=Temp(2,1);
  if Temp(2,1)==0
     matB(2,2) =1;
 end
 matB(1,2)=Temp(3,1);
 matB(2,1)=Temp(3,1);
 Temp=matB;
 else
 Temp = cov(data50(:,1:D));
 end
 matB=inv(Temp);

end
 if (sum(sum(isinf(matB)))>0)
    matB = zeros(2,2);
     return;
end
end