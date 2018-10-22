function [ res ] = Entropy( arr )
%ENTROPY Summary of this function goes here
%   Detailed explanation goes here
% sum(arr);
% nonZeros = length(arr(arr~=0));

n = length(arr);
x = 0;
base = log10(n);
for i = 1:n
    p = arr(i);
    if(p ~= 0)
        x = x + (p.*(log10(p)/ base));
    end
end
x = -x;
res = x;
end

