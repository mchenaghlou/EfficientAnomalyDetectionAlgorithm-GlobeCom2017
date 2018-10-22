%======================================================
% Author: Masud Moshtaghi
% Modified: 2009-05-28
% Take covariance matrix and mean and find two focis of ellipse on 3\sigma
% of it
%=======================================================
function [Focis] = FindFocimd(MatA,C, itr)
N = size(MatA,2);
[U D V]=svd(MatA);

a = 1/sqrt(D(itr,itr));
b = 1/sqrt(D(itr+1,itr+1));
aM = D(itr,itr);
am = D(itr+1,itr+1);
Foci1 =V(:,itr+1)*sqrt(abs((a/2)^2-(b/2)^2))+C';
Foci2 =-V(:,itr+1)*sqrt(abs((a/2)^2-(b/2)^2))+C';
Focis1 =[Foci1';Foci2'];

Foci1 =V(:,itr+1)*0.5*sqrt((aM-am)/(aM*am))+C';
Foci2 =-V(:,itr+1)*0.5*sqrt((aM-am)/(aM*am))+C';

Focis =[Foci1';Foci2'];
clear N T T1 t D V U a b aM am
end