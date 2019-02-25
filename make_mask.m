


fid = fopen('SOSE_12_bathy3.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[4320,1260]);
fclose(fid);

% contourf(U')

load grid

XC3 = rdmds('XC');
YC3 = rdmds('YC');
RC3 = rdmds('RC');
RC3 = squeeze(RC3);

XC3 = XC3(:,end);
YC3 = YC3(end,:);
XC = XC(:,end);
YC = YC(end,:);
% lox = find(XC3>289.99,1);
% hix = find(XC3>350,1);
% loy = find(YC3>-59.3,1);
% hiy = find(YC3>-32,1);
XC3 = XC3(6:187);
YC3 = YC3(6:127);

lox = find(XC>XC3(1),1);
hix = find(XC>XC3(end),1);
loy = find(YC>YC3(1),1);
hiy = find(YC>YC3(end),1);

% XC(lox)
% XC3(1)
% 
% XC(hix)
% XC3(end)
% 
% YC(loy)
% YC3(1)
% 
% YC(hiy)
% YC3(end)

XCm = XC(lox:hix);
YCm = YC(loy:hiy);


mask = hFacC(lox:hix,loy:hiy,2:2:104);

clearvars -except mask XCm YCm

save mask
