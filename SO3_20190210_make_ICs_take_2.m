
clear
close all
clc

tic()

%% Theta
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Theta.nc';
jj = 1446;

% ncdisp(str);

XC = ncread(str,'XC');
YC = ncread(str,'YC');

lox = find(XC>289.99,1);
hix = find(XC>350,1);
loy = find(YC>-59.3,1);
hiy = find(YC>-32,1);
XC = XC(lox:hix);
YC = YC(loy:hiy);

THETA = ncread(str,'THETA',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('THETA_init_restr_20161216.bin','w','b');
fwrite(fid,THETA,'single');
fclose(fid);

clear THETA

%% Theta

%% Salt

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Salt.nc';
jj = 1446;

SALT = ncread(str,'SALT',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('SALT_init_restr_20161216.bin','w','b');
fwrite(fid,SALT,'single');
fclose(fid);

clear SALT

%% Salt

%% Uvel

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Uvel.nc';
jj = 1446;

UVEL = ncread(str,'UVEL',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('UVEL_init_restr_20161216.bin','w','b');
fwrite(fid,UVEL,'single');
fclose(fid);

clear UVEL

%% Uvel

%% Vvel

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Vvel.nc';
jj = 1446;

VVEL = ncread(str,'VVEL',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('VVEL_init_restr_20161216.bin','w','b');
fwrite(fid,VVEL,'single');
fclose(fid);

clear VVEL

%% Vvel

%% DIC

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_DIC.nc';
jj = 290;

DIC = ncread(str,'TRAC01',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('DIC_init_restr_20161216.bin','w','b');
fwrite(fid,DIC,'single');
fclose(fid);

clear DIC

%% DIC

%% Alk

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Alk.nc';
jj = 290;

Alk = ncread(str,'TRAC02',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('Alk_init_restr_20161216.bin','w','b');
fwrite(fid,Alk,'single');
fclose(fid);

clear Alk

%% Alk

%% O2

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_O2.nc';
jj = 290;

O2 = ncread(str,'TRAC03',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('O2_init_restr_20161216.bin','w','b');
fwrite(fid,O2,'single');
fclose(fid);

clear O2

%% O2

%% NO3

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_NO3.nc';
jj = 290;

NO3 = ncread(str,'TRAC04',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('NO3_init_restr_20161216.bin','w','b');
fwrite(fid,NO3,'single');
fclose(fid);

clear NO3

%% NO3

%% PO4

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_PO4.nc';
jj = 290;

PO4 = ncread(str,'TRAC05',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('PO4_init_restr_20161216.bin','w','b');
fwrite(fid,PO4,'single');
fclose(fid);

clear PO4

%% PO4

%% Fe

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Fe.nc';
jj = 290;

Fe = ncread(str,'TRAC06',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('Fe_init_restr_20161216.bin','w','b');
fwrite(fid,Fe,'single');
fclose(fid);

clear Fe

%% Fe

%% DON

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_DON.nc';
jj = 290;

DON = ncread(str,'TRAC07',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('DON_init_restr_20161216.bin','w','b');
fwrite(fid,DON,'single');
fclose(fid);

clear DON

%% DON


%% DOP

str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_DOP.nc';
jj = 290;

DOP = ncread(str,'TRAC08',[lox,loy,1,jj],[361,243,52,1]);

fid = fopen('DOP_init_restr_20161216.bin','w','b');
fwrite(fid,DOP,'single');
fclose(fid);

clear DOP

%% DOP





