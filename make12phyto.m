clear
close all
clc
tic()


load grid6
load XY12

[XC12,YC12] = ndgrid(XC12,YC12);

fid = fopen('phyto_diaz_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_d = zeros(756,512,104);

for ii=1:104
    F = griddedInterpolant(XC,YC,U(:,:,ii),'makima');
    phyo_d(:,:,ii) = F(XC12,YC12);
    % phyo_d(:,:,ii) = interp2(XC,YC,U(:,:,ii),XC12,YC12,'makima');
end

for jj=1:104
    for ii=1:15
        phyo_d(ii,:,jj) = phyo_d(16,:,jj);
        phyo_d(741+ii,:,jj) = phyo_d(741,:,jj);
        phyo_d(:,ii,jj) = phyo_d(:,16,jj);
        phyo_d(:,497+ii,jj) = phyo_d(:,497,jj);
    end
end

contourf(phyo_d(:,:,1)',50)


fid = fopen('phyto_diaz_so6_interp_12.bin','w','b');
fwrite(fid,phyo_d,'single');
fclose(fid);


fid = fopen('phyto_lg_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_lg = zeros(756,512,104);

for ii=1:104
    F = griddedInterpolant(XC,YC,U(:,:,ii),'makima');
    phyo_lg(:,:,ii) = F(XC12,YC12);    
    % F = griddedInterpolant(XC,YC,U(:,:,ii),'linear');
    % phyo_lg(:,:,ii) = interp2(XCS,YCS,U(:,:,ii),XC12,YC12,'makima');
end

for jj=1:104
    for ii=1:15
        phyo_lg(ii,:,jj) = phyo_lg(16,:,jj);
        phyo_lg(741+ii,:,jj) = phyo_lg(741,:,jj);
        phyo_lg(:,ii,jj) = phyo_lg(:,16,jj);
        phyo_lg(:,497+ii,jj) = phyo_lg(:,497,jj);
    end
end

contourf(phyo_lg(:,:,1)',50)


fid = fopen('phyto_lg_so6_interp_12.bin','w','b');
fwrite(fid,phyo_lg,'single');
fclose(fid);


fid = fopen('phyto_sm_SO6k104.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[2160,630,104]);
fclose(fid);

contourf(U(:,:,1)')
phyo_sm = zeros(756,512,104);

for ii=1:104
    F = griddedInterpolant(XC,YC,U(:,:,ii),'makima');
    phyo_sm(:,:,ii) = F(XC12,YC12);    
    % F = griddedInterpolant(XC,YC,U(:,:,ii),'linear');
    % phyo_sm(:,:,ii) = interp2(XCS,YCS,U(:,:,ii),XC12,YC12,'makima');
end

for jj=1:104
    for ii=1:15
        phyo_sm(ii,:,jj) = phyo_sm(16,:,jj);
        phyo_sm(741+ii,:,jj) = phyo_sm(741,:,jj);
        phyo_sm(:,ii,jj) = phyo_sm(:,16,jj);
        phyo_sm(:,497+ii,jj) = phyo_sm(:,497,jj);
    end
end

contourf(phyo_sm(:,:,1)',50)


fid = fopen('phyto_sm_so6_interp_12.bin','w','b');
fwrite(fid,phyo_sm,'single');
fclose(fid);

