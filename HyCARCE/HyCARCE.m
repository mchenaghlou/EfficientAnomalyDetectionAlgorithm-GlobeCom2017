%======================================================
% Author: Masud Moshtaghi
% Created: 2009-08-21
% HyCARCE 
% Inputdata format (v1,v2,..,vD,1(reserved),weight,clusterlabel)
% Weight can be a natural number that gives a weight to some of the
% samples and it only work for 2D data. In all other cases it should be 1
% dCountHistory is the number of data at the elliptical boundaries after
% each update
%=======================================================
function [matA centers clusterindex dCountHistory] = HyCARCE(inpData,D,gridcellsize)
%% Initial Boxes

InitBox=ones(1,D)*gridcellsize;
EStep = 0.97;
%============== Grid Initialization =================
[matA centers datacount EllipseVols] = BoxGrid(inpData,InitBox,D);
%===================================================

NoOfBox = size(centers,1);
stopFlag=1;
stoppedellipses = ones(size(centers,1),1);
Step=1;
dCountHistory=datacount;
Status=ones(size(centers,1),1)./10;
 while(stopFlag>0)
   stopFlag =0;
   AvgSize = mean(EllipseVols.*stoppedellipses);
   AvgCount = mean(datacount);
   i=1;
   whilecount=0;
   while i<=NoOfBox
    %% Enlargement
    whilecount = whilecount+1;
    if ( stoppedellipses(i,1)==1)
        [NewElli C dcount vol removable] = EnlargeEllipse(squeeze(matA(i,:,:)),centers(i,:),datacount(i,1),inpData,EStep,AvgSize,EllipseVols(i,1),gridcellsize);
        if(removable==1)
           stoppedellipses(i,1)=0; 
        else
           matA(i,:,:) = NewElli;
           datacount(i,1) = dcount;
           centers(i,:)=C;
           EllipseVols(i,1)=vol;
           stopFlag =1;
        end
     
   end
     i = i+1;
   end
   Step=Step+1;
   dCountHistory = [dCountHistory datacount];
 end
%% Prune Ellipses
   %====== Remove unecessary ellipsoids
   i=1;
   NoOfBox = size(centers,1);
 while i<NoOfBox
      j=i+1;
   while j<=NoOfBox
       p = norm(centers(i,:)-centers(j,:));
       if p<sqrt(D*((gridcellsize^2)/4)) 
           if(datacount(j,1)>datacount(i,1))
             matA(i,:,:)=matA(j,:,:);
             centers(i,:)=centers(j,:);
             datacount(i,:)=datacount(j,:); 
           end
           matA(j,:,:)=[];
           centers(j,:)=[];
           datacount(j,:)=[];
           NoOfBox = NoOfBox-1;
           j=j-1;
       end
       j=j+1;
   end
   i = i+1;
 end
[clusterindex matA centers]=FindClusterIndex(inpData,matA,centers);
clear i temp margin Limites D Step NoOfBox Newbox thresholdmove p thresholdenlarge EStep inpData
end