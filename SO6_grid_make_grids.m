clear
close all
clc

tic()

acc_settings

load input6/grid.mat

XG = XG(:,end);
YG = YG(end,:);
XC = XC(:,end);
YC = YC(end,:);

lox = find(XG>288.6,1)-2;
hix = find(XG>351.58,1)+3;

loy = find(YG>-59.68,1)-1;
hiy = find(YG>-30.6,1)+2;


YG6 = YG(loy:hiy);
XG6 = XG(lox:hix);
YC6 = YC(loy:hiy);
XC6 = XC(lox:hix);

Bathy6 = Depth(lox:hix,loy:hiy);
[n,m] = size(Bathy6);

for ii = 1:10
   Bathy6(:,ii) = Bathy6(:,11); 
   Bathy6(:,m+1-ii) = Bathy6(:,m-10);
   Bathy6(ii,:) = Bathy6(11,:);
   Bathy6(n+1-ii,:) = Bathy6(n-10,:);
end

Bathy6(1:11,1:11) = 0;
Bathy6(1:11,m-10:m) = 0;
Bathy6(n-10:n,1:11) = 0;
Bathy6(n-10:n,m-10:m) = 0;

figure()
colormap(bone)
s = contourf(-Bathy6');
% s.EdgeColor = 'none';
Bathy6 = -Bathy6;

fid = fopen('Bathy_ArgBasin_6sp.bin','w','b');
fwrite(fid,Bathy6,'single');
fclose(fid);

hFacC6 = hFacC(lox:hix,loy:hiy,:);
hFacS6 = hFacS(lox:hix,loy:hiy,:);
hFacW6 = hFacW(lox:hix,loy:hiy,:);
% clearvars -except XC6 XG6 YG6 YC6 hFacC6 hFacS6 hFacW6
% 
% save XY6









toc()

