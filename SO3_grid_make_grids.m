clear
close all
clc

tic()

acc_settings

load input3/grid.mat

XG = XG(:,end);
YG = YG(end,:);
XC = XC(:,end);
YC = YC(end,:);

lox = find(XG>288.6,1)-1;
hix = find(XG>351.58,1)+1;

loy = find(YG>-59.68,1)-2;
hiy = find(YG>-30.6,1)+1;


YG3 = YG(loy:hiy);
XG3 = XG(lox:hix);
YC3 = YC(loy:hiy);
XC3 = XC(lox:hix);

Bathy3 = Depth(lox:hix,loy:hiy);
[n,m] = size(Bathy3);

for ii = 1:5
   Bathy3(:,ii) = Bathy3(:,6); 
   Bathy3(:,m+1-ii) = Bathy3(:,m-5);
   Bathy3(ii,:) = Bathy3(6,:);
   Bathy3(n+1-ii,:) = Bathy3(n-5,:);
end

Bathy3(1:6,1:6) = 0;
Bathy3(1:6,m-5:m) = 0;
Bathy3(n-5:n,1:6) = 0;
Bathy3(n-5:n,m-5:m) = 0;

figure()
colormap(bone)
s = contourf(-Bathy3');
% s.EdgeColor = 'none';
Bathy3 = -Bathy3;

fid = fopen('Bathy_ArgBasin_3sp.bin','w','b');
fwrite(fid,Bathy3,'single');
fclose(fid);

hFacC3 = hFacC(lox:hix,loy:hiy,:);
hFacS3 = hFacS(lox:hix,loy:hiy,:);
hFacW3 = hFacW(lox:hix,loy:hiy,:);
% clearvars -except XC3 XG3 YG3 YC3 hFacC3 hFacS3 hFacW3
% 
% save XY3









toc()
