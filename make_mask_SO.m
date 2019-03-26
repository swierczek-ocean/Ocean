


fid = fopen('SOSE_12_bathy3.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[4320,1260]);
fclose(fid);

% contourf(U')

load grid


XC12 = XC(:,end);
YC12 = YC(end,:);
RC12 = squeeze(RC);




mask12 = hFacC(:,:,1)';
Depth = Depth';

clearvars -except mask12 XC12 YC12 RC12 Depth

save mask12
