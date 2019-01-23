close all
clear
clc
tic()
ACC_Colors
ncdisp('grid.nc');

XC = ncread('grid.nc','XC');
YC = ncread('grid.nc','YC');

Xg = XC(:,1);
Yg = YC(1,:);

Yg(1)
Yg(end)

Bath = ncread('grid.nc','Depth');
Bath = -Bath';

cc = 9;
lw = 2.2;

lox = find(Xg>288.3,1);
hix = find(Xg>352,1);
loy = find(Yg>-60.1,1);
hiy = find(Yg>-30.7,1);

loxx = find(Xg>289.99,1);
hixx = find(Xg>350,1);
loyy = find(Yg>-59.3,1);
hiyy = find(Yg>-32.1,1);

Bath = Bath(loy-1:hiy,lox:hix);
Xg = Xg(lox:hix);
Yg = Yg(loy-1:hiy);

fprintf('bathymetry box = [%g,%g]x[%g,%g] \n',Xg(1),Xg(end),Yg(1),Yg(end));


%% salt
time = ncread('bsose_i121_2013to2017_monthly_Salt.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_Salt.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_Salt.nc','YC');
SALT = ncread('bsose_i121_2013to2017_monthly_Salt.nc','SALT');

X = XCS;
Y = YCS;
YCS(1)

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);

fprintf('salt grid = [%g,%g]x[%g,%g] \n salt nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

X = X(lox:hix);
Y = Y(loy:hiy);