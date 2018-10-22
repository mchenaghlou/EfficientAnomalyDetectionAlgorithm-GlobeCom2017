function [ ww ] = ToNormalStandard( window, mu, sigma )
%TONORMALSTANDARD Summary of this function goes here
%   Detailed explanation goes here

toMu=bsxfun(@minus,window ,mu);
T = cholcov(sigma);
ww = (T\toMu')';

end

