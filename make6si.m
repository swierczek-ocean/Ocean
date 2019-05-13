clear
close all
clc
tic()


load grid6
load XY6

[XC6,YC6] = ndgrid(XC6,YC6);

fid = fopen('/data/soccom/SO6input/ICs/si_clim_woa13_sose6_104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104,12]);
fclose(fid);

% contourf(U(:,:,1,2)')
sili = zeros(384,260,52,12);

for ii=1:52
    for jj=1:12
        F = griddedInterpolant(XC,YC,U(:,:,2*ii,jj),'spline');
        sili(:,:,ii,jj) = F(XC6,YC6);
        % sili(:,:,ii,jj) = interp2(XCS,YCS,U(:,:,2*ii,jj),XC6,YC6,'makima');
    end
end

for jj=1:52
    for ii=1:10
        sili(ii,:,jj,:) = sili(11,:,jj,:);
        sili(374+ii,:,jj,:) = sili(374,:,jj,:);
        sili(:,ii,jj,:) = sili(:,11,jj,:);
        sili(:,250+ii,jj,:) = sili(:,250,jj,:);
    end
end

contourf(sili(:,:,1,12)',50)


fid = fopen('si_clim_woa13_so6_interp_6.bin','w','b');
fwrite(fid,sili,'single');
fclose(fid);




