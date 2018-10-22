function [Dis] = FociDistancemd(Focis1,Focis2)
% Distances(1) = min(norm(Focis1(1,:)-Focis2(1,:)),norm(Focis1(1,:)-Focis2(2,:)));
% Distances(2) = min(norm(Focis1(2,:)-Focis2(2,:)),norm(Focis1(2,:)-Focis2(1,:)));
% Dis = min(Distances);
 
%=============    Distance to Line ===============
FociLine1 =Focis1(2,:)-Focis1(1,:);
FociLine2 =Focis2(2,:)-Focis2(1,:);
%==== 1
Dl1=Focis2(1,:)-Focis1(1,:);
Dl2=Focis2(2,:)-Focis1(1,:);

r = Dl1*FociLine1';
% if the two Foci of the first ellipse fall on each other
if(norm(FociLine1)==0)
  D1=norm(Focis1(1,:)-Focis2(1,:)); 
  D2=norm(Focis1(1,:)-Focis2(2,:));
else

r = r/(norm(FociLine1)^2);
D1=-1;
if(r<0 || r>1)
    D1 = min(norm(Dl1),norm(Focis2(1,:)-Focis1(2,:)));
else
    P = Focis1(1,:)+r*(Focis1(2,:)-Focis1(1,:));
    %A = [(Focis1(2,:)-Focis1(1,:));(Focis1(1,:)-Focis2(1,:))];
    %D1 = abs(det(A))/norm(Focis1(2,:)-Focis1(1,:));
    D1 = norm(P-Focis2(1,:));
end

r = Dl2*FociLine1';
r = r/(norm(FociLine1)^2);
D2=-1;
if(r<0 || r>1)
    D2 = min(norm(Dl2),norm(Focis2(2,:)-Focis1(2,:)));
else
    P = Focis1(1,:)+r*(Focis1(2,:)-Focis1(1,:));
    D2 = norm(P-Focis2(2,:)); 
%     A = [(Focis1(2,:)-Focis1(1,:));(Focis1(1,:)-Focis2(2,:))];
%     D2 = abs(det(A))/norm(Focis1(2,:)-Focis1(1,:));
end
end
%==== 2
Dl1=Focis1(1,:)-Focis2(1,:);
Dl2=Focis1(2,:)-Focis2(1,:);

r = Dl1*FociLine2';
if(norm(FociLine2)==0)
  D3=norm(Focis2(1,:)-Focis1(1,:)); 
  D4=norm(Focis2(1,:)-Focis1(2,:));

else
r = r/(norm(FociLine2)^2);
D3=-1;
if(r<0 || r>1)
    D3 = min(norm(Dl1),norm(Focis1(1,:)-Focis2(2,:)));
else
      P = Focis2(1,:)+r*(Focis2(2,:)-Focis2(1,:));
      D3 = norm(P-Focis1(1,:));
%     A = [(Focis2(2,:)-Focis2(1,:));(Focis2(1,:)-Focis1(1,:))];
%     D3 = abs(det(A))/norm(Focis2(2,:)-Focis2(1,:));
end
r = Dl2*FociLine2';
r = r/(norm(FociLine2)^2);
D4=-1;
if(r<0 || r>1)
    D4 = min(norm(Dl2),norm(Focis1(2,:)-Focis2(2,:)));
else
      P = Focis2(1,:)+r*(Focis2(2,:)-Focis2(1,:));
      D4 = norm(P-Focis1(2,:));
%     A = [(Focis2(2,:)-Focis2(1,:));(Focis2(1,:)-Focis1(2,:))];
%     D4 = abs(det(A))/norm(Focis2(2,:)-Focis2(1,:));
end
end

temp = mean([mean([D1 D2]) mean([D3 D4])]);
% if(Focis1(2,1)==Focis1(1,1) && Focis1(2,2)==Focis1(1,2))
%     temp = min(norm(Focis1(1,:)-Focis2(1,:)),norm(Focis1(1,:)-Focis2(2,:)));
%     temp = (temp+mean([D1 D2]))/2;
% end
% if(Focis2(2,1)==Focis2(1,1) && Focis2(2,2)==Focis2(1,2))
%     temp = min(norm(Focis2(1,:)-Focis1(1,:)),norm(Focis2(1,:)-Focis1(2,:)));
%     temp = (temp+mean([D1 D2]))/2;
% end
Dis=temp;
% A = [(Focis1(2,:)-Focis1(1,:));(Focis1(1,:)-Focis2(1,:))];
% A1 = [(Focis1(2,:)-Focis1(1,:));(Focis1(1,:)-Focis2(2,:))];
% Dis = max(abs(det(A))/norm(Focis1(2,:)-Focis1(1,:)),abs(det(A1))/norm(Focis1(2,:)-Focis1(1,:)));
% Dis = abs(det(A))/norm(Focis1(2,:)-Focis1(1,:))+abs(det(A1))/norm(Focis1(2,:)-Focis1(1,:));
% Dis = Dis /2;

clear A A1 D1 D3 D4 Dl1 D2 Dl2 r FociLine1 FociLine2 temp P;
end