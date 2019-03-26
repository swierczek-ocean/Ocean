
clear
close all
clc

tic()

%% Uvel
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Uvel.nc';
sd = 1432;
nd = 10;


UVEL = ncread(str,'UVEL',[1,1,1,sd],[2160,588,1,nd]);

%% Uvel


%% Vvel
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Vvel.nc';
sd = 1432;
nd = 10;


VVEL = ncread(str,'VVEL',[1,1,1,sd],[2160,588,1,nd]);
SPEED = sqrt(UVEL.^2+VVEL.^2);

SPEED(SPEED==0)=NaN;

fid = fopen('SPEED_bsose_10.bin','w','b');
fwrite(fid,SPEED,'single');
fclose(fid);

fprintf('finished SPEED \n')
clear 
%% Vvel

str = '/data/SOSE/SOSE/SO6/SETUP/grid.nc';

XC6 = ncread(str,'XC');
YC6 = ncread(str,'YC');
XC6 = XC6(:,end);
YC6 = YC6(end,:);
save XY

toc()