%======================================================
% Author: Masud Moshtaghi
% Created: 2010-05-31
% Uses Kelly 1994 to merge two ellipsoids
% inputs: inverse of cov. matrix of all ellipsoids, centers, data samples in each ellipse
% and the indexes that should be merged
%=======================================================
function [ MergeMat C Samples ] = EllipseMerge( matA, centers, datasamples, mergearr)
C = centers(mergearr(1,1),:);
Samples = datasamples(mergearr(1,1),:);
t = inv(squeeze(matA(mergearr(1,1),:,:)));
MergeMat = t;
for i=2:1:size(mergearr,1)
    temp = Samples;
    Samples = Samples + datasamples(mergearr(i,1));
    C = (datasamples(mergearr(i,1))/Samples)*centers(mergearr(i,1),:)+(temp/Samples)*C;
    MergeMat=((datasamples(mergearr(i,1))-1)/(Samples-1)) * inv(squeeze(matA(mergearr(i,1),:,:)))+((temp-1)/(Samples-1))*MergeMat;
    MergeMat = MergeMat + ((datasamples(mergearr(i,1))*temp)/(Samples*(Samples-1)))*((C-centers(mergearr(i,1),:))'*(C-centers(mergearr(i,1),:)));
end
MergeMat = inv(MergeMat);
clear temp;
end

