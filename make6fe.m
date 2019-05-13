clear
close all
clc
tic()


load grid
load XY6

[n,m] = size(XC);

[XC6,YC6] = ndgrid(XC6,YC6);

fid = fopen('../input6/fet_surfflux_mahowald_sose12.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,12]);
fclose(fid);

contourf(U(:,:,1)')
fesx = zeros(384,260,12);


for jj=1:12
    F = griddedInterpolant(XC,YC,U(:,:,jj),'makima');
    fesx(:,:,jj) = F(XC6,YC6);
    % fesx(:,:,jj) = interp2(XCS,YCS,U(:,:,jj),XC6,YC6,'makima');
end



for ii=1:10
    fesx(ii,:,:) = fesx(11,:,:);
    fesx(374+ii,:,:) = fesx(374,:,:);
    fesx(:,ii,:) = fesx(:,11,:);
    fesx(:,250+ii,:) = fesx(:,250,:);
end


contourf(fesx(:,:,1)',50)


fid = fopen('fe_surfflux_so6_interp_6.bin','w','b');
fwrite(fid,fesx,'single');
fclose(fid);




