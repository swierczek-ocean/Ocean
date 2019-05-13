clear
close all
clc
tic()


load grid6
load XY12

[XC12,YC12] = ndgrid(XC12,YC12);

fid = fopen('/data/soccom/SO6input/ICs/si_clim_woa13_sose6_104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104,12]);
fclose(fid);

% contourf(U(:,:,1,2)')
sili = zeros(756,512,104,12);

for ii=1:104
    for jj=1:12
        F = griddedInterpolant(XC,YC,U(:,:,ii,jj),'spline');
        sili(:,:,ii,jj) = F(XC12,YC12);
        % sili(:,:,ii,jj) = interp2(XCS,YCS,U(:,:,ii,jj),XC12,YC12,'makima');
    end
end

for jj=1:104
    for ii=1:15
        sili(ii,:,jj,:) = sili(16,:,jj,:);
        sili(741+ii,:,jj,:) = sili(741,:,jj,:);
        sili(:,ii,jj,:) = sili(:,16,jj,:);
        sili(:,497+ii,jj,:) = sili(:,497,jj,:);
    end
end

contourf(sili(:,:,1,12)',50)


fid = fopen('si_clim_woa13_so6_interp_12.bin','w','b');
fwrite(fid,sili,'single');
fclose(fid);




