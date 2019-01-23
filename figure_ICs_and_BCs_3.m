tic()
clc
clear
close all

NX = 1080;
NY = 315;
NZ = 52;

%% salt
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


SALTN = SALT(lox:hix,YY,:,:);
SALTS = SALT(lox:hix,loy+5,:,:);
SALTE = SALT(hix-5,loy:hiy,:,:);
SALTW = SALT(loy+5,loy:hiy,:,:);
for ii=1:5
    SALTN(ii,:,:,:) = SALTN(6,:,:,:);
    SALTN(187+ii,:,:,:) = SALTN(187,:,:,:);
    SALTS(ii,:,:,:) = SALTS(6,:,:,:);
    SALTS(187+ii,:,:,:) = SALTS(187,:,:,:);    
    SALTE(:,ii,:,:) = SALTE(:,6,:,:);
    SALTE(:,127+ii,:,:) = SALTE(:,127,:,:);
    SALTW(:,ii,:,:) = SALTW(:,6,:,:);
    SALTW(:,127+ii,:,:) = SALTW(:,127,:,:);
end

SALTN = squeeze(SALTN);
SALTS = squeeze(SALTS);
SALTE = squeeze(SALTE);
SALTW = squeeze(SALTW);

fid = fopen('SALT_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,SALTN,'single');
fclose(fid);

fid = fopen('SALT_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,SALTS,'single');
fclose(fid);

fid = fopen('SALT_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,SALTE,'single');
fclose(fid);

fid = fopen('SALT_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,SALTW,'single');
fclose(fid);

clear SALT*
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

VVELN = THETA(lox:hix,YY,:,:);
VVELS = THETA(lox:hix,loy+5,:,:);
VVELE = THETA(hix-5,loy:hiy,:,:);
VVELW = THETA(loy+5,loy:hiy,:,:);
for ii=1:5
    VVELN(ii,:,:,:) = VVELN(6,:,:,:);
    VVELN(187+ii,:,:,:) = VVELN(187,:,:,:);
    VVELS(ii,:,:,:) = VVELS(6,:,:,:);
    VVELS(187+ii,:,:,:) = VVELS(187,:,:,:);    
    VVELE(:,ii,:,:) = VVELE(:,6,:,:);
    VVELE(:,127+ii,:,:) = VVELE(:,127,:,:);
    VVELW(:,ii,:,:) = VVELW(:,6,:,:);
    VVELW(:,127+ii,:,:) = VVELW(:,127,:,:);
end

VVELN = squeeze(VVELN);
VVELS = squeeze(VVELS);
VVELE = squeeze(VVELE);
VVELW = squeeze(VVELW);

fid = fopen('THETA_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELN,'single');
fclose(fid);

fid = fopen('THETA_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELS,'single');
fclose(fid);

fid = fopen('THETA_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELE,'single');
fclose(fid);

fid = fopen('THETA_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELW,'single');
fclose(fid);

clear THETA
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

UVELN = UVEL(lox:hix,YY,:,:);
UVELS = UVEL(lox:hix,loy+5,:,:);
UVELE = UVEL(hix-5,loy:hiy,:,:);
UVELW = UVEL(loy+5,loy:hiy,:,:);
for ii=1:5
    UVELN(ii,:,:,:) = UVELN(6,:,:,:);
    UVELN(187+ii,:,:,:) = UVELN(187,:,:,:);
    UVELS(ii,:,:,:) = UVELS(6,:,:,:);
    UVELS(187+ii,:,:,:) = UVELS(187,:,:,:);    
    UVELE(:,ii,:,:) = UVELE(:,6,:,:);
    UVELE(:,127+ii,:,:) = UVELE(:,127,:,:);
    UVELW(:,ii,:,:) = UVELW(:,6,:,:);
    UVELW(:,127+ii,:,:) = UVELW(:,127,:,:);
end

UVELN = squeeze(UVELN);
UVELS = squeeze(UVELS);
UVELE = squeeze(UVELE);
UVELW = squeeze(UVELW);

fid = fopen('UVEL_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,UVELN,'single');
fclose(fid);

fid = fopen('UVEL_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,UVELS,'single');
fclose(fid);

fid = fopen('UVEL_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,UVELE,'single');
fclose(fid);

fid = fopen('UVEL_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,UVELW,'single');
fclose(fid);

clear UVEL
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

VVELN = VVEL(lox:hix,YY,:,:);
VVELS = VVEL(lox:hix,loy+5,:,:);
VVELE = VVEL(hix-5,loy:hiy,:,:);
VVELW = VVEL(loy+5,loy:hiy,:,:);
for ii=1:5
    VVELN(ii,:,:,:) = VVELN(6,:,:,:);
    VVELN(187+ii,:,:,:) = VVELN(187,:,:,:);
    VVELS(ii,:,:,:) = VVELS(6,:,:,:);
    VVELS(187+ii,:,:,:) = VVELS(187,:,:,:);    
    VVELE(:,ii,:,:) = VVELE(:,6,:,:);
    VVELE(:,127+ii,:,:) = VVELE(:,127,:,:);
    VVELW(:,ii,:,:) = VVELW(:,6,:,:);
    VVELW(:,127+ii,:,:) = VVELW(:,127,:,:);
end

VVELN = squeeze(VVELN);
VVELS = squeeze(VVELS);
VVELE = squeeze(VVELE);
VVELW = squeeze(VVELW);

fid = fopen('VVEL_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELN,'single');
fclose(fid);

fid = fopen('VVEL_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELS,'single');
fclose(fid);

fid = fopen('VVEL_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELE,'single');
fclose(fid);

fid = fopen('VVEL_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,VVELW,'single');
fclose(fid);

clear VVEL
%% end vvel

toc()