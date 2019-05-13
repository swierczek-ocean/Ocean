clear
close all
clc
tic()


load grid
load XY12

[n,m] = size(XC);

[XC12,YC12] = ndgrid(XC12,YC12);
% [XC,YC] = ndgrid(XC,YC);

fid = fopen('fet_surfflux_mahowald_sose12.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,12]);
fclose(fid);

contourf(U(:,:,1)')
fesx = zeros(756,512,12);


for jj=1:12
    F = griddedInterpolant(XC,YC,U(:,:,jj),'makima');
    fesx(:,:,jj) = F(XC12,YC12);
    % fesx(:,:,jj) = interp2(XC,YC,U(:,:,jj),XC12,YC12,'makima');
end



for ii=1:15
    fesx(ii,:,:) = fesx(16,:,:);
    fesx(741+ii,:,:) = fesx(741,:,:);
    fesx(:,ii,:) = fesx(:,16,:);
    fesx(:,497+ii,:) = fesx(:,497,:);
end


contourf(fesx(:,:,1)',50)


fid = fopen('fe_surfflux_so6_interp_12.bin','w','b');
fwrite(fid,fesx,'single');
fclose(fid);




