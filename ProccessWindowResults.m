function [ output_args ] = ProccessWindowResults( ConsensusModel, window,D , RecordClusters, v, Clusters, anomalyLabel)
%PROCCESSWINDOWRESULTS Summary of this function goes here
%   Detailed explanation goes here
    wl = length(window);
    ID = 1:length(window);
    result = [ID' window(:,1:D) window(:,D+3) zeros(1,wl)' ConsensusModel];



    [ FP, FN, TP, TN] = ProcessResults(result, D, anomalyLabel);
    anms = [];
    for k = 1:size(window,1)
        if(result(k,D + 2) < 1)
            anms = [anms; k window(k,:)];
        end
    end
    accuracy = (TP + TN) ./ size(window,1);
    specificity = TN ./(size(window,1) - size(anms,1));
    sensitivity = TP ./ size(anms,1);

%     numOfWindows
%     numOfModels

%     accuracy
%     specificity
%     sensitivity
%     FP
%     FN



       PlotEnsembleResults(result, D, wl, 'window', TP, TN, FP, FN, accuracy, specificity, sensitivity, 0, RecordClusters, v, Clusters, anomalyLabel);


end

