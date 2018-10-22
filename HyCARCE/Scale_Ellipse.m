function [ Corr_Mat ] = Scale_Ellipse( MatrixA,varargin)
% Scale MatrixA by a random number between [0.2 10]
%   To do that we do : ScaleMat'*A*ScleMat
if(nargin>1)
    N = varargin{1};
    ScaleMat = diag(1./ones(1,size(MatrixA,2))*N);
else
    ScaleMat = diag(1./(1+1.5*rand(1,size(MatrixA,2))));
end
    Corr_Mat = ScaleMat'*MatrixA*ScaleMat;
clear ScaleMat N
end