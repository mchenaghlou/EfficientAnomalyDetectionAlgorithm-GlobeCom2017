function [unitvol] = AlphaFunc(D)
if(rem(D,2)==0)
    unitvol=(pi.^(D/2))/(factorial(D/2));
else
    unitvol=((2^D)*pi^((D-1)/2)*(factorial((D-1)/2)))/(factorial(D));
end

end