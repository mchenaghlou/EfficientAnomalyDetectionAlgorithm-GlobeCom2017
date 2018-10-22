function [data] = MinMaxNormalize(data)

dataMin = min(data);
dataMax = max(data);
for i = 1 : size(data,1)
    for j = 1 : size(data,2)
        data(i,j) = (data(i,j)-dataMin(j))/(dataMax(j)-dataMin(j));
    end
end

end