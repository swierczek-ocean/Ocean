clear
close all
clc
tic()


load grid6
load XY12

[XC12,YC12] = ndgrid(XC12,YC12);

fid = fopen('runoff_clim921rivers_DJ_so6_ms_V0.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,12]);
fclose(fid);

% contourf(U(:,:,2)')
runoff = zeros(756,512,12);

for jj=1:12
    F = griddedInterpolant(XC,YC,U(:,:,jj),'makima');
    runoff(:,:,jj) = F(XC12,YC12);
    % runoff(:,:,jj) = interp2(XC,YC,U(:,:,jj),XC12,YC12,'makima');
end

for ii=1:15
    runoff(ii,:,:) = runoff(16,:,:);
    runoff(741+ii,:,:) = runoff(741,:,:);
    runoff(:,ii,:) = runoff(:,16,:);
    runoff(:,497+ii,:) = runoff(:,497,:);
end

contourf(runoff(:,:,12)',50)


fid = fopen('runoff_clim921rivers_so6_interp_12.bin','w','b');
fwrite(fid,runoff,'single');
fclose(fid);


