clear
close all
clc
tic()


load grid6
load XY3

[XC3,YC3] = ndgrid(XC3,YC3);

fid = fopen('phyto_diaz_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_d = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XC,YC,U(:,:,2*ii),'makima');
    phyo_d(:,:,ii) = F(XC3,YC3);
    % phyo_d(:,:,ii) = interp2(XCS,YCS,U(:,:,2*ii),XC3,YC3,'makima');
end

for jj=1:52
    for ii=1:5
        phyo_d(ii,:,jj) = phyo_d(6,:,jj);
        phyo_d(187+ii,:,jj) = phyo_d(187,:,jj);
        phyo_d(:,ii,jj) = phyo_d(:,6,jj);
        phyo_d(:,127+ii,jj) = phyo_d(:,127,jj);
    end
end

contourf(phyo_d(:,:,1)',50)


fid = fopen('phyto_diaz_so6_interp_3.bin','w','b');
fwrite(fid,phyo_d,'single');
fclose(fid);


fid = fopen('phyto_lg_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_lg = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XC,YC,U(:,:,2*ii),'makima');
    phyo_lg(:,:,ii) = F(XC3,YC3);
    % phyo_lg(:,:,ii) = interp2(XCS,YCS,U(:,:,2*ii),XC3,YC3,'makima');
end

for jj=1:52
    for ii=1:5
        phyo_lg(ii,:,jj) = phyo_lg(6,:,jj);
        phyo_lg(187+ii,:,jj) = phyo_lg(187,:,jj);
        phyo_lg(:,ii,jj) = phyo_lg(:,6,jj);
        phyo_lg(:,127+ii,jj) = phyo_lg(:,127,jj);
    end
end

contourf(phyo_lg(:,:,1)',50)


fid = fopen('phyto_lg_so6_interp_3.bin','w','b');
fwrite(fid,phyo_lg,'single');
fclose(fid);


fid = fopen('phyto_sm_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_sm = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XC,YC,U(:,:,2*ii),'makima');
    phyo_sm(:,:,ii) = F(XC3,YC3);
    % phyo_sm(:,:,ii) = interp2(XCS,YCS,U(:,:,2*ii),XC3,YC3,'makima');
end

for jj=1:52
    for ii=1:5
        phyo_sm(ii,:,jj) = phyo_sm(6,:,jj);
        phyo_sm(187+ii,:,jj) = phyo_sm(187,:,jj);
        phyo_sm(:,ii,jj) = phyo_sm(:,6,jj);
        phyo_sm(:,127+ii,jj) = phyo_sm(:,127,jj);
    end
end

contourf(phyo_sm(:,:,1)',50)


fid = fopen('phyto_sm_so6_interp_3.bin','w','b');
fwrite(fid,phyo_sm,'single');
fclose(fid);

