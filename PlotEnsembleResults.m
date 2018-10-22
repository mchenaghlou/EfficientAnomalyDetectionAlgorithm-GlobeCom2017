function PlotEnsembleResults( results , D, wl, testCase, TP, TN, FP, FN, accuracy, specificity, sensitivity, WriteIntoFiles,RecordVideo, v, Clusters, anomalyLabel)
%PLOTENSEMBLERESULTS Summary of this function goes here
%   Detailed explanation goes here




TPArray = [];
TNArray = [];
FPArray = [];
FNArray = [];

% 0 is anomaly (Positive)
% 1 is normal (Negative)
for i = 1:size(results,1)
    if(results(i,D + 2) == anomalyLabel) % column 4 is real
        if(results(i,D + 4) == anomalyLabel) % column 6 is what algorithm says
            %             numOfTruePositive = numOfTruePositive +1;
            TPArray = [TPArray; results(i,:)];
        else
            %             numOfFalseClear = numOfFalseClear +1;
            FNArray = [FNArray ; results(i,:)];
        end
        
    elseif(results(i,D + 2) ~= anomalyLabel) % this is normal
        if(results(i,D + 4) == anomalyLabel)
            %             numOfFalseAlarms = numOfFalseAlarms +1;
            FPArray = [FPArray; results(i,:)];
        else
            %             numOfTrueNegative = numOfTrueNegative +1;
            TNArray = [TNArray; results(i,:)];
        end
        %         normal = [normal; results(i,:)];
    end
end


if(strcmp(testCase, 'window') == 1)
    
    clf
else
%     figure1 = figure;
%     plot([1,1], [2,2],'c.');
%     clf
end


hold on
for k = 1:length(Clusters)
    currCluster = Clusters(k);
    sigmaInv = squeeze(currCluster.matA(1,:,:));
    Ellipse_Plot( sigmaInv, currCluster.center(1,:) ,k ,[0,0,0]);
    drawnow
    axis([0 1 0 1]);
end


if D == 1
    hold on
    if(size(TPArray,1) > 0)
        scatter(TPArray(:,2), zeros(size(TPArray,1),1),'g+');
    end
    if(size(TNArray,1) > 0)
        scatter(TNArray(:,2),zeros(size(TNArray,1),1), 'g.');
    end
    if(size(FPArray,1) > 0)
        scatter(FPArray(:,2),zeros(size(FPArray,1),1),'r+');
    end
    if(size(FNArray,1) > 0)
        scatter(FNArray(:,2),zeros(size(FNArray,1),1),'r.');
    end
elseif D == 2
    hold on
    
    if(size(TPArray,1) > 0)
        plot(TPArray(:,2), TPArray(:,3),'g+');
    end
    if(size(TNArray,1) > 0)
        plot(TNArray(:,2), TNArray(:,3),'g.');
    end
    if(size(FPArray,1) > 0)
        plot(FPArray(:,2), FPArray(:,3),'r+');
    end
    if(size(FNArray,1) > 0)
        plot(FNArray(:,2), FNArray(:,3),'r.');
    end
elseif D == 3
    if(size(TPArray,1) > 0)
        scatter3(TPArray(:,2), TPArray(:,3), TPArray(:,4),'g+');
    end
    if(size(TNArray,1) > 0)
        scatter3(TNArray(:,2), TNArray(:,3), TNArray(:,4),'g.');
    end
    if(size(FPArray,1) > 0)
        scatter3(FPArray(:,2), FPArray(:,3), FPArray(:,4),'r+');
    end
    if(size(FNArray,1) > 0)
        scatter3(FNArray(:,2), FNArray(:,3), FNArray(:,4),'r.');
    end
    
end


TP = size (TPArray, 1);
TN = size (TNArray ,1);
FP = size (FPArray ,1);
FN = size (FNArray ,1);

dim = [.2 .5 .3 .3];
str = sprintf('WL = %d, Threshodl = %s',wl );
line1 = sprintf('Accuracy = %d', accuracy );
line2 = sprintf('Specificity = %d', specificity );
line3 = sprintf('sensitivity = %d', sensitivity );

line4 = sprintf('TP = %d', TP);
line5 = sprintf('TN = %d', TN);
line6 = sprintf('FP = %d', FP);
line7 = sprintf('FN = %d', FN);

wholeLine = [str char(10) line1 char(10) line2 char(10) line3 char(10) line4 char(10) line5 char(10) line6 char(10) line7];
annotation('textbox',dim,'String',wholeLine,'FitBoxToText','on','Tag' , 'resultsAnnot');
drawnow

if(strcmp(testCase, 'window') == 1)
    
    if(RecordVideo == 1)
        %VideoMaking
        
        
        fr = getframe(gcf);
        writeVideo(v,fr);
        dim = [.2 .5 .3 .3];
    end
    
end

if(WriteIntoFiles == 1)
%     s = sprintf('C:\\Users\\mchenaghlou\\Dropbox\\PhD\\MatlabProjects\\EnsembleModel\\EnsembleSwitching\\TestVariateWindow\\ResultsFigures\\%d\\WL=%d\\Threshold = %s', testCase, wl, thrStr);
%     cd(s);
%     saveas(gcf, 'FinalResult.fig');
%     cd('C:\\Users\\mchenaghlou\\Dropbox\\PhD\\MatlabProjects\\EnsembleModel\\EnsembleSwitching');
end
axis([0 1 0 1 0 1]);
end

