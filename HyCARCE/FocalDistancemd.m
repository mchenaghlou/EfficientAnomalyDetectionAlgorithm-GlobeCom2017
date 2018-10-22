function [ Distance ] = FocalDistancemd( MatrixA,CenterA, MatrixB, CenterB)
N = size(MatrixA,2);
Dis=0;
for i=1:1:N-1
MatFociA=FindFocimd(MatrixA,CenterA,i);
MatFociB=FindFocimd(MatrixB,CenterB,i);
Dis = Dis + FociDistancemd(MatFociA,MatFociB);
end
Dis = Dis/(N-1);
%========= This part does not do anything
%==== and is for further research
[U1 D1 V1] = svd(MatrixA);
[U2 D2 V2] = svd(MatrixB);
t1 = sum(D1,1);
t2 = sum(D2,1);
MA = sqrt(1./t1);
MB = sqrt(1./t2);
%Dis = Dis+norm(MA-MB);

Distance = Dis;
end