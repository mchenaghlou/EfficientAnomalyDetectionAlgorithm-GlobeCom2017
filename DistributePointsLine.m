function [ output_args ] = DistributePointsLine( input_args )
%DISTRIBUTEPOINTSLINE Summary of this function goes here
%   Detailed explanation goes here


ns = 1:1:20;
l = 1;

for i=1:length(ns)
    n = ns(i);
    
    points = 0:(l+1)/n:l;
    dists = pdist(points');
    
    distValue(i) = sum(dists);
    
    
    distValue2(i) = n/2*n/2*l + l*rem(n,2);
    
end
x = ns;
y1 = distValue;
y2 = distValue2;

hold on
plot(x, y1,'--ro');
plot(x, y2,'--bo');

end

