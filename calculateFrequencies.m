function [ res ] = calculateFrequencies( remains, dim, denThr, wl)
%CALCULATEFREQUENCIES Summary of this function goes here
%   Detailed explanation goes here

bits = 0.1;
bins = 1 / bits;

for i = 2:dim
    h1  = histcounts(remains(:,i), bins);
    
    % clf
    % scatter(remains(:,1),remains(:,2),'.');
    % axis([0 1 0 1])
    
%     N = sum(h1);
    
    val = binocdf(h1, wl, bits);
    if(sum(val > 0.5) > 0);
        res = 1;
        return;
    end
end



% if(h1Sum > 0.25* memSize)
%     normalizedValues  = h1 / h1Sum;
%     ent = Entropy(normalizedValues);
%     if(ent < 0.8)
%         res = 1;
%         return;
%     end
% end

res = 0;


% p = 5;
% bits = 1/p;
%
% AA = [];
%
% bitsX = 0.1;
%
%
%
% AA1 = 0:1;
% AA2 = 0:bitsX:1;
%
%
% % for i = 1:dim
% %     AA = [AA; 0:bits:1];
% % end
%
% if(dim == 1)
%
%     [XX1] = ndgrid(AA);
%     counter = 1;
%
%     for i = 1:p
%         sq.a = AA(i);
%         sq.b = AA(i+1);
%         sqs(counter) = sq;
%         counter = counter +1;
%     end
%
%
% elseif(dim == 2)
%     [XX1, XX2] = ndgrid(AA1, AA2);
%     counter = 1;
%     for i = 1:size(XX1,1)-1
%         for j = 1:size(XX2,2)-1
%             sq.a = [XX1(i,j), XX2(i,j)];
%             sq.b = [XX1(i+1,j), XX2(i,j)];
%             sq.c = [XX1(i,j), XX2(i,j+1)];
%             sq.d = [XX1(i+1,j), XX2(i,j+1)];
%             sqs(counter) = sq;
%             counter = counter +1;
%         end
%     end
% elseif(dim == 3)
%     [XX1, XX2, XX3] = ndgrid(AA(1,:), AA(2,:), AA(3,:));
%     counter = 1;
%     for i = 1:size(XX1,1)-1
%         for j = 1:size(XX2,1)-1
%             for k = 1:size(XX3,1)-1
%                 sq.a = [XX1(i,j,k), XX2(i,j,k),XX3(i,j,k)];
%                 sq.b = [XX1(i+1,j), XX2(i,j,k),XX3(i,j,k)];
%                 sq.c = [XX1(i,j,k), XX2(i,j+1,k),XX3(i,j,k)];
%                 sq.d = [XX1(i+1,j,k), XX2(i,j+1,k),XX3(i,j,k)];
%
%                 sq.e = [XX1(i,j,k+1), XX2(i,j,k+1),XX3(i,j,k+1)];
%                 sq.f = [XX1(i+1,j,k+1), XX2(i,j,k+1),XX3(i,j,k+1)];
%                 sq.g = [XX1(i,j,k+1), XX2(i,j+1,k+1),XX3(i,j,k+1)];
%                 sq.h = [XX1(i+1,j,k+1), XX2(i,j+1,k+1),XX3(i,j,k+1)];
%
%
%                 sqs(counter) = sq;
%                 counter = counter +1;
%             end
%         end
%
%     end
%
%     % [X1,X2] = ndgrid(-2:.2:2, -2:.2:2);
%
%     %
%     % for i = 1:p
%     %     for j = 1:p
%     %         sq.a = [A(i),B(j)];
%     %         sq.b = [A(i+1),B(j)];
%     %         sq.c = [A(i),B(j+1)];
%     %         sq.d = [A(i+1),B(j+1)];
%     %         sqs(counter) = sq;
%     %         counter = counter +1;
%     %     end
%     % end
%
% end
%
% for i = 1:counter - 1
%     sq = sqs(i);
%     feq = 0;
%     for j = 1:size(window,1)
%         point = window(j,:);
%         if(dim == 1)
%             if(sq.a(1) <= point(1) && point(1) <= sq.b(1))
%                 feq = feq + 1;
%             end
%         elseif(dim == 2)
%             if(sq.a(1) <= point(1) && point(1) <= sq.b(1))
%                 if(sq.a(2) <= point(2) && point(2) <= sq.c(2))
%                     feq = feq + 1;
%                 end
%             end
%         elseif(dim == 3)
%             if(sq.a(1) <= point(1) && point(1) <= sq.b(1))
%                 if(sq.a(2) <= point(2) && point(2) <= sq.c(2))
%                     if(sq.a(3) <= point(3) && point(3) <= sq.e(3))
%                         feq = feq + 1;
%                     end
%                 end
%             end
%
%         end
%
%     end
%     sqs(i).freq = feq;
%     feqArr(i) = feq;
% end
% feqArr1 = feqArr';
%
% feqArr1 = feqArr1(feqArr1~=0);
% %     ar = size(feqArr1, 1)*bits;
%
% % relativeProbabilities = binocdf(feqArr1, size(others,1), bits^dim);
% relativeProbabilities = binocdf(feqArr1, wl, bitsX);
%
% %     feqArr1 = feqArr1 * p;
%
%
%
%
%
%
% % clf
% % scatter(others(:,1),others(:,2),'.');
% % axis([0 1 0 1])
%
%
% t = sum(relativeProbabilities > denThr);
% % t = sum(feqArr1 >  (bits^dim) * size(others,1));
% if( t > 0)
%     res = 1;
% else
%     res = 0;
% end
end

