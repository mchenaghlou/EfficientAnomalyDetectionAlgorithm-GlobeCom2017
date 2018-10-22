function [toremove] = CheckRemovables(matA,centers,premovable)
N= size(matA,1);
Nr =numel(premovable);
mThreshold = chi2inv(0.99,size(matA,2));
toremove=[];
for i=1:1:Nr
    for j=1:1:N
        if(j==premovable(i))
            continue;
        end
        t = (centers(premovable(i),:)-centers(j,:))*squeeze(matA(j,:,:))*(centers(premovable(i),:)-centers(j,:))';
        if(t<mThreshold)
            toremove =[toremove;premovable(i)];
            break;
        end
    end
end

end