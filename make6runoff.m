clear
close all
clc
tic()


load grid6
load XY6

[XC6,YC6] = ndgrid(XC6,YC6);

fid = fopen('runoff_clim921rivers_DJ_so6_ms_V0.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,12]);
fclose(fid);

% contourf(U(:,:,2)')
runoff = zeros(384,260,12);

for jj=1:12
    F = griddedInterpolant(XC,YC,U(:,:,jj),'makima');
    runoff(:,:,jj) = F(XC6,YC6);
    % runoff(:,:,jj) = interp2(XCS,YCS,U(:,:,jj),XC6,YC6,'makima');
end

for ii=1:10
    runoff(ii,:,:) = runoff(11,:,:);
    runoff(374+ii,:,:) = runoff(374,:,:);
    runoff(:,ii,:) = runoff(:,11,:);
    runoff(:,250+ii,:) = runoff(:,250,:);
end

contourf(runoff(:,:,12)',50)


fid = fopen('runoff_clim921rivers_so6_interp_6.bin','w','b');
fwrite(fid,runoff,'single');
fclose(fid);


