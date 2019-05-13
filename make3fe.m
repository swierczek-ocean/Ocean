clear
close all
clc
tic()


load grid
load XY3

[n,m] = size(XC);

[XC3,YC3] = ndgrid(XC3,YC3);

fid = fopen('fet_surfflux_mahowald_sose12.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,12]);
fclose(fid);

contourf(U(:,:,1)')
fesx = zeros(192,132,12);


for jj=1:12
    F = griddedInterpolant(XC,YC,U(:,:,jj),'makima');
    fesx(:,:,jj) = F(XC3,YC3);
    % fesx(:,:,jj) = interp2(XCS,YCS,U(:,:,jj),XC3,YC3,'makima');
end



for ii=1:5
    fesx(ii,:,:) = fesx(6,:,:);
    fesx(187+ii,:,:) = fesx(187,:,:);
    fesx(:,ii,:) = fesx(:,6,:);
    fesx(:,127+ii,:) = fesx(:,127,:);
end


contourf(fesx(:,:,1)',50)


fid = fopen('fe_surfflux_so6_interp_3.bin','w','b');
fwrite(fid,fesx,'single');
fclose(fid);




