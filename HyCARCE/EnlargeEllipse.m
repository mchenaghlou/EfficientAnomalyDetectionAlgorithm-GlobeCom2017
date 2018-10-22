%======================================================
% Author: Masud Moshtaghi
% Created: 2009-08-24
% Enlarge the ellipsoid compute the percentage of increase in its coverage
%=======================================================

function [matB C dcount vol removable] = EnlargeEllipse(matA,center,prevdcount,data,EStep,AvgSize,CurSize,gridcellsize)
removable=0;
dim=size(matA,1);
mThreshold = chi2inv(0.95,dim);
EStep = EStep/(1+(((dim+1)*AvgSize)/(((mThreshold))*CurSize)));

matB = Scale_Ellipse(matA,EStep);
mahaldist=(data(:,1:dim)-repmat(center,size(data,1),1))*matB.*(data(:,1:dim)-repmat(center,size(data,1),1));
mahaldist = sum(mahaldist,2);

[row col] = find(mahaldist<=mThreshold);
[matB C dcount]= Adjust(data(row,:),dim, mahaldist(row,1),gridcellsize);

vol = sqrt(det(matB/mThreshold));
vol=AlphaFunc(dim)/vol;

if(prevdcount>60)
    if((dcount-prevdcount)<= ((5/95)*prevdcount))
        removable =1;
    end
else
    if (((dcount-prevdcount)/prevdcount) < 0.01)
         removable =1;
    end
end

end