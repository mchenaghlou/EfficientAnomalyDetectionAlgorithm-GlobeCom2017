clear all;

%%%%% Create a dataset
% rounds = [5]; %rounds = [1, 5, 10, 20];
% for j = 1: 1 %length(rounds)
%     S = DataGenerator3(2, rounds(j));
%     text = sprintf('./1.EfficientAnomalyDetection/S-%d', j);
%     save(text, 'S');
% end
load('S-1.mat')

k = 10;
% Cluster Boundary
P_Value = 0.95;

% Determines which observations belong to the cluster
maxRatio = 0.01;


densityThreshold = 0.5;



Dimension = 2;
WindowLengthArr = [800 600 500 400 300 200]';
anomalyLabel = 0;
normalLabel = 1;

for windowLengthIterator = 1:length(WindowLengthArr)
    wl = WindowLengthArr(windowLengthIterator);
    wl
    

    numOfWindows = 0;
    numOfModels = 0;
    
    tic
    [resultFile, ConsensusModel, numOfWindows, SingleClusters] = EfficientAlgorithm(S,Dimension,wl, anomalyLabel, k, P_Value, densityThreshold);
    elapsedTime = toc;
    numOfModels = size(SingleClusters, 2);
    elapsedTime
    
   
    labels = ones(1, size(resultFile, 1))';
    for i = 1:size(resultFile,1)
        if(resultFile(i,Dimension + 2)>0)
            labels(i,1) = normalLabel;
        else
            labels(i,1) = anomalyLabel;
        end
    end
    
    max(resultFile(:,Dimension + 3))
    resultFile(:,Dimension + 3) = (resultFile(:,Dimension + 3) - min(resultFile(:,Dimension + 3))) / (max(resultFile(:,Dimension + 3)) - min(resultFile(:,Dimension + 3)));
    [X,Y,T,AUC,OPTROCPT] = perfcurve(labels,resultFile(:,Dimension + 3), normalLabel);
    [ FP, FN, TP, TN] = ProcessResults(resultFile,Dimension,anomalyLabel);
    anms = [];
    for kk = 1:size(S,1)
        if(S(kk,Dimension + 1) == 0)
            anms = [anms; S(kk,:)];
        end
    end
    accuracy = (TP + TN) ./ size(S,1);
    specificity = TN ./(size(S,1) - size(anms,1));
    sensitivity = TP ./ size(anms,1);
    
    info1 = sprintf('WL: %d,',  wl);
    info2 = sprintf('numOfModels: %d,  AUC: %d,Accuracy: %d, Specificity: %d, Sensitivity, %d, TP: %d, TN: %d, FP: %d, FN: %d', numOfModels, AUC, accuracy, specificity, sensitivity, TP, TN,FP, FN);
    
    disp(info1)
    disp(info2)
    
end


