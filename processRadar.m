function [ res ] = processRadar(window, dists, dim, nbins, P_Value)
%CALCULATEFREQUENCIES Summary of this function goes here
%   Detailed explanation goes here
% theta = window(:,1);
% mahalDist = window(:,2);
res = 1;
edges = 0:2*pi/nbins:2*pi;
entropyThreshold = 0.75;

for i = 1:dim
    if(i == 1)
        
        temp = 0:P_Value/nbins:P_Value;
        vals = chi2inv(temp, dim)';

        h  = histcounts(dists', vals);
        
        h1Sum = sum(h);
        normalizedValues  = h / h1Sum;
        ent = Entropy(normalizedValues);
        if(ent < entropyThreshold)
            res = 0;
            return;
        end
    elseif(i == dim)
        h  = histcounts(window(:,i)', edges);
        h1Sum = sum(h);
        normalizedValues  = h / h1Sum;
        ent = Entropy(normalizedValues);
        if(ent < entropyThreshold)
            res = 0;
            return;
        end 
        
    else
        edges = 0:pi/nbins:pi;
        h  = histcounts(window(:,i)', edges);
        h1Sum = sum(h);
        normalizedValues  = h / h1Sum;
        ent = Entropy(normalizedValues);
        if(ent < entropyThreshold)
            res = 0;
            return;
        end 
        
    end
end

end

