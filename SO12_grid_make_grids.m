clear
close all
clc

tic()

acc_settings

load grid.mat

XG = XG(:,end);
YG = YG(end,:);
XC = XC(:,end);
YC = YC(end,:);

lox = find(XG>288.6,1);
hix = find(XG>351.58,1);

loy = find(YG>-59.69,1);
hiy = find(YG>-30.67,1);


YG12 = YG(loy:hiy);
XG12 = XG(lox:hix);
YC12 = YC(loy:hiy);
XC12 = XC(lox:hix);

Bathy12 = Depth(lox:hix,loy:hiy);
[n,m] = size(Bathy12);

for ii = 1:15
   Bathy12(:,ii) = Bathy12(:,16); 
   Bathy12(:,m+1-ii) = Bathy12(:,m-15);
   Bathy12(ii,:) = Bathy12(16,:);
   Bathy12(n+1-ii,:) = Bathy12(n-15,:);
end

Bathy12(1:16,1:16) = 0;
Bathy12(1:16,m-15:m) = 0;
Bathy12(n-15:n,1:16) = 0;
Bathy12(n-15:n,m-15:m) = 0;

figure()
colormap(bone)
s = contourf(-Bathy12');
% s.EdgeColor = 'none';
Bathy12 = -Bathy12;

fid = fopen('Bathy_ArgBasin_12sp.bin','w','b');
fwrite(fid,Bathy12,'single');
fclose(fid);

hFacC12 = hFacC(lox:hix,loy:hiy,:);
hFacS12 = hFacS(lox:hix,loy:hiy,:);
hFacW12 = hFacW(lox:hix,loy:hiy,:);
clearvars -except XC12 XG12 YG12 YC12 hFacC12 hFacS12 hFacW12

save XY12









toc()

