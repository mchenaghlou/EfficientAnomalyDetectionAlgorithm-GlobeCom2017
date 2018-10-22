function [ dataset ] = DataGenerator3(dim, rounddd)
%DATAGENERATOR3 Summary of this function goes here
%   Detailed explanation goes here

% state 1: gamma
% state 2: normal
% state 3: poisson
% state 4: normal
% 1 2 1 2 1 2 3 2 3 1 4 2 1 3 4

% popSizes = [800,200, 750,200,800,150, 600, 50, 400, 100, 600, 150, 350, 0, 600, 100, 350, 300, 350, 120, 450, 200, 400, 90, 600, 200, 300, 30, 450];
% popSizes = [1000,0, 1200,0,900,0, 1100, 0, 900, 0, 1100, 0, 1200, 0, 1100, 0, 950, 0, 1100, 0, 1150, 0, 900, 0, 980, 0, 1100, 0, 1150];
popSizes = [1000,300, 1200,300,900,300, 1100, 300, 900, 350, 1100, 350, 1200, 350, 1100, 300, 950, 350, 1100, 300, 1150, 320, 900];
oneRoundPopSize = sum(popSizes);
sumPopSiz = sum(popSizes);

rounds = rounddd;
numOfAnomalies = floor(rounds * sumPopSiz * 0.03);
wholePopSize = rounds*oneRoundPopSize;
states = [1,2,3,4];
components = [1,2,3,1];

% states_seq = [1, 1.2, 2 ,2.1 , 1, 1.2, 2, 2.1, 1, 1.2, 2, 2.3, 3 ,3.2, 2 , 2.3 , 3 ,3.1, 1, 1.4 , 4, 4.2 , 2 , 2.1 , 1 , 1.3, 3, 3.4, 4];
states_seq = [1, 1.2, 2 ,2.1 , 1, 1.2, 2, 2.3, 3 ,3.2, 2 ,2.4 , 4 , 4.3 , 3 ,3.1, 1, 1.4 , 4, 4.3, 3, 3.4, 4];
mixture_weights = [1, [1 , 0,0]; 2, [0.5,0.5, 0]; 3, [0.33,0.33 ,0.34]; 4, [1, 0, 0]];

Normal = sprintf('Normal');
Gamma = sprintf('Gamma');
Poisson = sprintf('Poisson');

celldata1 = cellstr(Normal);
celldata2 = cellstr(Normal);
celldata3 = cellstr(Normal);
celldata4 = cellstr(Normal);

state_distributions = [ celldata1, celldata2, celldata3, celldata4];

%parameters= [gamma ax, bx, ay, by, ; mu1X, sigma1X, mu1Y, sigma1Y,mu2X, sigma2X, mu2Y, sigma2Y; lambdaX1, lambdaY1, lambdaX2,lambdaY2, lambdaX3, lambdaY3;mu1X, sigma1X, mu1Y, sigma1Y,mu2X, sigma2X, mu2Y, sigma2Y,mu3X, sigma3X, mu3Y, sigma3Y]
% params = {[[5, 8]; [6, 9]]; 
%     [[60 , 20, 200 , 19] ; [100 , 18 , 240 , 19]];
%     [[175, 200]; [220,200]; [200 ,240]];
%     [[215 , 20, 100 , 19] ; [190 , 18 , 60 , 15];[240, 12, 50,15]] };

params = {[60 , 20, 70 , 19 ,50 , 15]; 
    [[60 , 20, 200 , 19 ,50 , 15] ; [100 , 18 , 240 , 19 , 70 , 12]];
    [[200 , 20, 260 , 19 ,50 , 15]; [230 , 20, 200 , 19 ,50 , 15]; [260 , 19, 230 , 18 ,50 , 15]];
    [[215 , 20, 100 , 19, 70, 12] ; [190 , 18 , 60 , 15, 50, 19];[240, 12, 50,15, 60,12]] };

state_start_points = [ [50, 50, 50];[50, 200, 70];[200, 200, 70];[[200,100, 50]]];

% params.s1GammaParameters = [[5, 8]; [6, 9]];
% params.s2NormalParameters = [[60 , 20, 200 , 19] ; [100 , 18 , 240 , 19]];
% params.s3PoissonParameters = [[175, 200]; [220,200] ;[200 ,240]];
% params.s4NormalParameters = [[215 , 20, 100 , 19] ; [190 , 18 , 60 , 15];[240, 12, 50,15]];
% 

% parameters = [5, 8, 6, 9, 0,0, 0, 0, 0,0,0,0 ; 60 , 20, 200 , 19 , 100 , 18 , 240 , 19, 0, 0,0,0 ; 175, 200, 220,200 ,200 ,240 , 0, 0, 0,0,0,0; 215 , 20, 100 , 19 , 190 , 18 , 60 , 15,240, 12, 50,15];
S = [];
for n = 1:rounds
    for i = 1:length(states_seq)
        isInChange = 0;
        statePop = [];
        
        currState = states_seq(i);
        currStatePopSize = popSizes(i);
        
        if(ismember(states_seq(i), states))
            currDistribution = state_distributions(states_seq(i));
            isInChange = 0;
            currComps = components(states_seq(i));
        else
            currDistribution = state_distributions(states_seq(i-1));
            isInChange = 1;
            currComps = 0;
        end
        
        if(isInChange == 1)
            if(currStatePopSize ~= 0)
                curr_states = states_seq(i);
                curr_state = floor(curr_states);
                temp = (curr_states - curr_state)*10;
                destState = int16(temp);
                current = state_start_points(curr_state,:);
                dest = state_start_points(destState,:);
                
%                 if(curr_state == 1)
%                     current = [50, 50, 50];
%                 elseif(curr_state == 2)
%                     current = [50, 200, 70];
%                 elseif(curr_state == 3)
%                     current = [200, 200, 70];
%                 elseif(curr_state == 4)
%                     current = [200,100, 50];
%                 end
%                 if(destState == 1)
%                     dest = [50, 50, 50];
%                 elseif(destState == 2)
%                     dest = [50, 200, 70];
%                 elseif(destState == 3)
%                     dest = [200, 200, 70];
%                 elseif(destState == 4)
%                     dest = [200, 100, 50];
%                 end
                
                diff = (dest - current)/currStatePopSize;
                if(strcmp(currDistribution, 'Poisson') == 1)

                    for j = 1:currStatePopSize
                        tempPop = [];
                        for k = 1:dim
                            curLamX = current(k);
                            pd = makedist('Poisson','lambda',curLamX);
                            changeX = random(pd,[1,1]);
                            tempPop = [tempPop changeX];
                        end
                        statePop = [statePop; tempPop, curr_states];
                        current = current + diff;
                        
                    end
%                     gscatter(statePop(:,1),statePop(:,2), statePop(:,3),'gr','x.+*');                    
%                     axis ([0 300 0 300])
                else

                    for j = 1:currStatePopSize
                        tempPop = [];
                        for k = 1:dim
                            currSigma = -1;
                            while currSigma <= 0
                                currSigma = normrnd(10, 3);
                            end
                            pd = makedist('Normal', 'mu', current(k), 'sigma', currSigma);
                            changeX = random(pd,[1,1]);
                            tempPop = [tempPop changeX];
                        end
                        statePop = [statePop; tempPop, curr_states];
                        current = current + diff; 
                    end
                end
            end
        elseif(isInChange == 0)
            currWeights = mixture_weights(currState,2:  size(mixture_weights,2));
            statePop = [];
            
            if(strcmp(currDistribution, 'Normal') == 1)
                population = [];
                
                stateParams =  params(currState,:);
                for j = 1:currComps
                    compPop = [];
                    currComponentPopSize = round(currWeights(j)*currStatePopSize);
                    compParams = cell2mat(stateParams);
                    compParams = compParams(j,:);
                    for k = 1:dim
                        muX = compParams(2*k - 1);
                        sigmaX = compParams(2*k);
                        
                        pd = makedist('Normal', 'mu', muX, 'sigma', sigmaX);
                        populationX = random(pd,1, currComponentPopSize)';
                        compPop = [compPop , populationX];
                    end
                                       
                    currStateVec = ones(1, length(populationX)) * currState;
                    compPop = [compPop, currStateVec'];
                    statePop = [statePop ; compPop];
                    
                end
                % mix statePop
                newIndices = randperm(size(statePop, 1));
                for j =1:size(newIndices,1)
                   tempRow = statePop(newIndices(j),:);
                   statePop(newIndices(j),:) = statePop(j,:);
                   statePop(j,:) = tempRow;
                end
                
                
                %             gscatter(statePop(:,1),statePop(:,2), statePop(:,3),'rgb','xo');
                %             plot(statePop(:,1),statePop(:,2), '.');
                %             axis ([0 300 0 300])
            elseif(strcmp(currDistribution, 'Gamma') == 1)
                population = [];
                stateParams =  params(currState,:);
                for j = 1:currComps
                    compPop = [];
                    currComponentPopSize = round(currWeights(j)*currStatePopSize);
                    compParams = cell2mat(stateParams);
                    currCompParams = compParams(j,:);
                    for k = 1:dim
                        ax = currCompParams(1, 2*k-1);
                        bx = currCompParams(1, 2*k); 
                        pd = makedist('Gamma', 'a', ax, 'b', bx);
                        populationX = random(pd,1, currComponentPopSize)';
                        compPop = [compPop , populationX];
                    end
                
                    currStateVec = ones(1, length(populationX)) * currState;
                    compPop = [compPop, currStateVec'];
                    statePop = [statePop ; compPop];
                end
                % mix statePop
                newIndices = randperm(size(statePop, 1));
                for j =1:size(newIndices,1)
                   tempRow = statePop(newIndices(j),:);
                   statePop(newIndices(j),:) = statePop(j,:);
                   statePop(j,:) = tempRow;
                end
                %             gscatter(statePop(:,1),statePop(:,2), statePop(:,3),'rgb','xo');
                %             plot(statePop(:,1),statePop(:,2), '.');
                %             axis ([0 300 0 300])
            elseif(strcmp(currDistribution, 'Poisson') == 1)
                population = [];
                stateParams =  params(currState,:);
                for j = 1:currComps
                    compPop = [];
                    currComponentPopSize = round(currWeights(j)*currStatePopSize);
                    compParams = cell2mat(stateParams);
                    compParams = compParams(j, :);
                    for k = 1:dim
                        lambda = compParams(1, k);
                        pd = makedist('Poisson', 'lambda', lambda);               
                        
                        populationX = random(pd,1, currComponentPopSize)';
                        compPop = [compPop , populationX];
                    end
                    
                    currStateVec = ones(1, length(populationX)) * currState;
                    compPop = [compPop, currStateVec'];
                    statePop = [statePop ; compPop];
                               
                end
                % mix statePop
                newIndices = randperm(size(statePop, 1));
                for j =1:size(newIndices,1)
                   tempRow = statePop(newIndices(j),:);
                   statePop(newIndices(j),:) = statePop(j,:);
                   statePop(j,:) = tempRow;
                end
                %             gscatter(statePop(:,1),statePop(:,2), statePop(:,3),'rgb','xo');
                %             plot(statePop(:,1),statePop(:,2), '.');
                %                 axis ([0 300 0 300])
            end
        end
        
        S = [S; statePop];
    end
end
% gscatter(S(:,1),S(:,2), S(:,3),'r','x.+*');
% plot(S(:,1),S(:,2), '.');
% axis ([0 300 0 300])

indices = randi(size(S,1),  numOfAnomalies,1);

anomalies =  -50 + 350 .* rand(numOfAnomalies, dim);
anomalies = [anomalies, zeros(size(anomalies(:,1)))];
% scatter(anomalies(:,1), anomalies(:,2),'g');

for i = 1:numOfAnomalies
    before = S(1:indices(i)-1,:);
    toInsert = anomalies(i,:);
    after = S(indices(i):size(S(:,1)),:);
    S = [before;toInsert;after];
end


% gscatter(S(:,1), S(:,2), S(:,3), 'rgb', 'xo.+*');
% plot(S(:,1),S(:,2), '.');
% axis ([0 300 0 300])


% S = [S, ones(size(S(:,1)))];


%     newIndices = randperm(size(S, 1));
%     for j =1:size(newIndices,1)
%        tempRow = S(newIndices(j),:);
%        S(newIndices(j),:) = S(j,:);
%        S(j,:) = tempRow;
%     end


dataset = S;

end

