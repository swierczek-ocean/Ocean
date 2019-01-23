tic()
clc
clear
close all

NX = 1080;
NY = 315;
NZ = 52;

%% salt
% ncdisp('bsose_i121_2013to2017_monthly_Salt.nc');
time = ncread('bsose_i121_2013to2017_monthly_Salt.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_Salt.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_Salt.nc','YC');
SALT = ncread('bsose_i121_2013to2017_monthly_Salt.nc','SALT');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);

fprintf('salt grid = [%g,%g]x[%g,%g] \n salt nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


SALT = SALT(lox:hix,YY,:,:);
for ii=1:5
    SALT(ii,:,:,:) = SALT(6,:,:,:);
    SALT(187+ii,:,:,:) = SALT(187,:,:,:);
end

SALT = squeeze(SALT);

fid = fopen('SALT_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,SALT,'single');
fclose(fid);
%% end salt

%% theta
time = ncread('bsose_i121_2013to2017_monthly_Theta.nc','time');
XCT = ncread('bsose_i121_2013to2017_monthly_Theta.nc','XC');
YCT = ncread('bsose_i121_2013to2017_monthly_Theta.nc','YC');
THETA = ncread('bsose_i121_2013to2017_monthly_Theta.nc','THETA');

X = XCT;
Y = YCT;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);

fprintf('theta grid = [%g,%g]x[%g,%g] \n theta nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

THETA = THETA(lox:hix,YY,:,:);
for ii=1:5
    THETA(ii,:,:,:) = THETA(6,:,:,:);
    THETA(187+ii,:,:,:) = THETA(187,:,:,:);
end
THETA = squeeze(THETA);

fid = fopen('THETA_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,THETA,'single');
fclose(fid);
%% end theta

%% uvel
time = ncread('bsose_i121_2013to2017_monthly_Uvel.nc','time');
XCU = ncread('bsose_i121_2013to2017_monthly_Uvel.nc','XG');
YCU = ncread('bsose_i121_2013to2017_monthly_Uvel.nc','YC');
UVEL = ncread('bsose_i121_2013to2017_monthly_Uvel.nc','UVEL');

X = XCU;
Y = YCU;

lox = find(X>288.3,1);
hix = find(X>351.9,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);

fprintf('uvel grid = [%g,%g]x[%g,%g] \n uvel nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

UVEL = UVEL(lox:hix,YY,:,:);
for ii=1:5
    UVEL(ii,:,:,:) = UVEL(6,:,:,:);
    UVEL(187+ii,:,:,:) = UVEL(187,:,:,:);
end
UVEL = squeeze(UVEL);

fid = fopen('UVEL_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,UVEL,'single');
fclose(fid);
%% end uvel

%% vvel
time = ncread('bsose_i121_2013to2017_monthly_Vvel.nc','time');
XCV = ncread('bsose_i121_2013to2017_monthly_Vvel.nc','XC');
YCV = ncread('bsose_i121_2013to2017_monthly_Vvel.nc','YG');
VVEL = ncread('bsose_i121_2013to2017_monthly_Vvel.nc','VVEL');

X = XCV;
Y = YCV;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);

fprintf('vvel grid = [%g,%g]x[%g,%g] \n vvel nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

VVEL = VVEL(lox:hix,YY,:,:);
for ii=1:5
    VVEL(ii,:,:,:) = VVEL(6,:,:,:);
    VVEL(187+ii,:,:,:) = VVEL(187,:,:,:);
end
VVEL = squeeze(VVEL);

fid = fopen('VVEL_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVEL,'single');
fclose(fid);
%% end vvel

toc()