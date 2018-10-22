function [ res ] = MaximumDistance2D( n )
%MAXIMUMDISTANCE Summary of this function goes here
%   Detailed explanation goes here

rdo = sqrt(2);
if(n == 1)
    res = 0;
elseif(n == 2)
    res = rdo;
elseif(n == 3)
    res = 2+rdo;
elseif(n == 4)
    res = 4 + 2*rdo;
elseif(rem(n,4) == 0)
    res = (n*n)/4 + (n/4)^2*(2*rdo);
elseif(rem(n,4) == 1)
    res = MaximumDistance2D(n-1) + n/4*(2 + rdo);
elseif(rem(n,4) == 2)
    res = MaximumDistance2D(n-1) + n/4*(2 + rdo) + rdo;
elseif(rem(n,4) == 3)
    res = MaximumDistance2D(n-1) + n/4*(2 + rdo) + 2;    
end
end

