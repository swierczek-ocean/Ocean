clear
close all
clc
tic()


load grid6
load XY6

[XC6,YC6] = ndgrid(XC6,YC6);

fid = fopen('phyto_diaz_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_d = zeros(384,260,52);

for ii=1:52
    F = griddedInterpolant(XC,YC,U(:,:,2*ii),'makima');
    phyo_d(:,:,ii) = F(XC6,YC6);
    % phyo_d(:,:,ii) = interp2(XCS,YCS,U(:,:,2*ii),XC6,YC6,'makima');
end

for jj=1:52
    for ii=1:10
        phyo_d(ii,:,jj) = phyo_d(11,:,jj);
        phyo_d(374+ii,:,jj) = phyo_d(374,:,jj);
        phyo_d(:,ii,jj) = phyo_d(:,11,jj);
        phyo_d(:,250+ii,jj) = phyo_d(:,250,jj);
    end
end

contourf(phyo_d(:,:,1)',50)


fid = fopen('phyto_diaz_so6_interp_6.bin','w','b');
fwrite(fid,phyo_d,'single');
fclose(fid);


fid = fopen('phyto_lg_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_lg = zeros(384,260,52);

for ii=1:52
    F = griddedInterpolant(XC,YC,U(:,:,2*ii),'makima');
    phyo_lg(:,:,ii) = F(XC6,YC6);
    % phyo_lg(:,:,ii) = interp2(XCS,YCS,U(:,:,2*ii),XC6,YC6,'makima');
end

for jj=1:52
    for ii=1:10
        phyo_lg(ii,:,jj) = phyo_lg(11,:,jj);
        phyo_lg(374+ii,:,jj) = phyo_lg(374,:,jj);
        phyo_lg(:,ii,jj) = phyo_lg(:,11,jj);
        phyo_lg(:,250+ii,jj) = phyo_lg(:,250,jj);
    end
end

contourf(phyo_lg(:,:,1)',50)


fid = fopen('phyto_lg_so6_interp_6.bin','w','b');
fwrite(fid,phyo_lg,'single');
fclose(fid);


fid = fopen('phyto_sm_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_sm = zeros(384,260,52);

for ii=1:52
    F = griddedInterpolant(XC,YC,U(:,:,2*ii),'makima');
    phyo_sm(:,:,ii) = F(XC6,YC6);
    % phyo_sm(:,:,ii) = interp2(XCS,YCS,U(:,:,2*ii),XC6,YC6,'makima');
end

for jj=1:52
    for ii=1:10
        phyo_sm(ii,:,jj) = phyo_sm(11,:,jj);
        phyo_sm(374+ii,:,jj) = phyo_sm(374,:,jj);
        phyo_sm(:,ii,jj) = phyo_sm(:,11,jj);
        phyo_sm(:,250+ii,jj) = phyo_sm(:,250,jj);
    end
end

contourf(phyo_sm(:,:,1)',50)


fid = fopen('phyto_sm_so6_interp_6.bin','w','b');
fwrite(fid,phyo_sm,'single');
fclose(fid);

