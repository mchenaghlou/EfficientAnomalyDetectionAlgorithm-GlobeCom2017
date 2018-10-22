function [ FP, FN, TP, TN ] = ProcessResults( resultFile, dim, anomalyLabel )
%PROCESSRESULTS Summary of this function goes here
%   Detailed explanation goes here

numOfFalsePositive = 0;
numOfFalseNegative = 0;
numOfTruePositive = 0;
numOfTrueNegative = 0;

resultFile(:,dim + 2) = floor(resultFile(:,dim + 2));
resultFile(:,dim + 4) = floor(resultFile(:,dim + 4));
for i = 1:size(resultFile(:,1))
    
    row = resultFile(i,:);
    
    if(row(1,dim + 2) == anomalyLabel) % this is anomaly
        if(row(1,dim + 4) == anomalyLabel)
            numOfTruePositive = numOfTruePositive +1;
        else
            numOfFalseNegative = numOfFalseNegative +1;
        end
    elseif(row(1,dim + 2) ~= anomalyLabel) % this is normal
        if(row(1,dim + 4) == anomalyLabel)
            numOfFalsePositive = numOfFalsePositive +1;
        else
            numOfTrueNegative = numOfTrueNegative +1;
        end
    end
    
end

FP = numOfFalsePositive;
TP = numOfTruePositive;
TN = numOfTrueNegative;
FN = numOfFalseNegative;



end

