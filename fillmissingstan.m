function F = fillmissingstan(A)
%% fill missing values (must have NaNs in input, must be 2D field)
%%

[n,m] = size(A);
F = A;
L = isnan(A);

for ii=1:m
    if L(1,ii)==1
        ind = find(L(:,ii)==0,1);
        F(1:ind-1,ii) = F(ind,ii);
    end
    if L(n,ii)==1
        ind = find(flipud(L(:,ii))==0,1);
        F(n-ind+2:n,ii) = F(n-ind+1,ii);
    end
end

L = isnan(F);
if sum(sum(L))==0
    return
end

for jj=1:m
    if sum(L(:,jj))>0
        for ii=n-1:-1:1
            if L(ii,jj)==1
                F(ii,jj) = F(ii+1,jj);
            end
        end
    end
end


end

