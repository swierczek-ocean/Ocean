clear
close all
clc
tic()


load grid6
load XY3

[XC3,YC3] = ndgrid(XC3,YC3);

fid = fopen('runoff_clim921rivers_DJ_so6_ms_V0.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,12]);
fclose(fid);

% contourf(U(:,:,2)')
runoff = zeros(192,132,12);

for jj=1:12
    F = griddedInterpolant(XC,YC,U(:,:,jj),'makima');
    runoff(:,:,jj) = F(XC3,YC3);
    % runoff(:,:,jj) = interp2(XCS,YCS,U(:,:,jj),XC3,YC3,'makima');
end

for ii=1:5
    runoff(ii,:,:) = runoff(6,:,:);
    runoff(187+ii,:,:) = runoff(187,:,:);
    runoff(:,ii,:) = runoff(:,6,:);
    runoff(:,127+ii,:) = runoff(:,127,:);
end

contourf(runoff(:,:,12)',50)


fid = fopen('runoff_clim921rivers_so6_interp_3.bin','w','b');
fwrite(fid,runoff,'single');
fclose(fid);


