tic()

load('SST.mat')

SST_avg = mean(SST,3);
SST_std = std(SST,3);
SST_avg = SST_avg';
SST_std = SST_std';

[m,n] = size(SST_avg);

for ii=1:m
    for jj=1:n
        if (SST_avg(ii,jj)==0)
            SST_avg(ii,jj) = NaN;
            SST_std(ii,jj) = NaN;
        end
    end
end


save SST_avg.mat
save SST_std.mat

toc()
