function [ toRet ] = ToPolarCoordinates( incommingStream, radiis )
%TOPOLARCOORDINATES Summary of this function goes here
%   Detailed explanation goes here
dim = size(incommingStream,2);

popSize = size(incommingStream,1);

R = zeros(1,dim-1);
toRet = zeros(popSize,dim);

for i = 1:popSize
    row = incommingStream(i, :);

    for j = 1:dim-1
        R(j) = sqrt(sumsqr(row(j:dim)));
    end
    
    for j = 1:dim
        if j == 1
            toRet(i, j) = R(j);
        elseif(j > 1 && j < dim)
            toRet(i, j) = acos(row(j-1)/ R(j-1));
            
%             phi(j-1) = acot(row(j-1)/ R(j));
%             if(toRet(i, j) < 0)
%                toRet(i, j) = 2*pi + toRet(i, j); 
%             end
        elseif(j == dim)
            if(row(j) >= 0)
                toRet(i, j) = acos(row(j-1) / R(j-1));
            else
                toRet(i, j) = 2*pi - acos(row(j-1) / R(j-1));
            end
        end
    end
end


% X1 = incommingStream(:,1) - mu(1);
% X2 = incommingStream(:,2) - mu(2);
% 
% [theta,rho] = cart2pol(X1,X2);
% rho = memberDists;
% theta = theta + pi;
%  theta = rad2deg(theta);
% 
% toRet(:,1) = rho;
% toRet(:,2) = theta;
% clf
% scatter(theta,rho,'.');

end