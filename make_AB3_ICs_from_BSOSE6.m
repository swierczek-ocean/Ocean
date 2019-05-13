
clear
close all
clc

tic()

load XY3
HC = hFacC3;
HS = hFacS3;
HW = hFacW3;

[XU,YU] = ndgrid(XG3,YC3);
[XV,YV] = ndgrid(XC3,YG3);
[XC3,YC3] = ndgrid(XC3,YC3);

%% Theta
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc';
jj = 1432;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

THETA_temp = ncread(str,'THETA',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA_temp)))));

for jj=1:52
    THETA_temp_temp = THETA_temp(:,:,jj);
    THETA_temp_temp(hFacC(:,:,jj)==0) = NaN;
    THETA_temp_temp = fillmissingstan(THETA_temp_temp);
    THETA_temp(:,:,jj) = THETA_temp_temp;
end
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA_temp)))));
THETA = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,THETA_temp(:,:,ii),'linear');
    THETA(:,:,ii) = F(XC3,YC3);
end
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA)))));
Logic = THETA==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of THETA mistakes = %g \n',num_mistakes)

for ii=1:5
    THETA(ii,6:127,:) = THETA(6,6:127,:); 
    THETA(6:187,ii,:) = THETA(6:187,6,:);
    THETA(187+ii,6:127,:) = THETA(187,6:127,:); 
    THETA(6:187,127+ii,:) = THETA(6:187,127,:);
end
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA)))));
Logic = THETA==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of THETA mistakes = %g \n',num_mistakes)

fid = fopen('THETA_AB3_IC_20161201.bin','w','b');
fwrite(fid,THETA,'single');
fclose(fid);

clear THETA*
%% Theta

%% Salt
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Salt.nc';
jj = 1432;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

SALT_temp = ncread(str,'SALT',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT_temp)))));

for jj=1:52
    SALT_temp_temp = SALT_temp(:,:,jj);
    SALT_temp_temp(hFacC(:,:,jj)==0) = NaN;
    SALT_temp_temp = fillmissingstan(SALT_temp_temp);
    SALT_temp(:,:,jj) = SALT_temp_temp;
end
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT_temp)))));
SALT = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,SALT_temp(:,:,ii),'linear');
    SALT(:,:,ii) = F(XC3,YC3);    
end
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT)))));
Logic = SALT==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of SALT mistakes = %g \n',num_mistakes)

for ii=1:5
    SALT(ii,6:127,:) = SALT(6,6:127,:); 
    SALT(6:187,ii,:) = SALT(6:187,6,:);
    SALT(187+ii,6:127,:) = SALT(187,6:127,:); 
    SALT(6:187,127+ii,:) = SALT(6:187,127,:);
end
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT)))));
Logic = SALT==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of SALT mistakes = %g \n',num_mistakes)

fid = fopen('SALT_AB3_IC_20161201.bin','w','b');
fwrite(fid,SALT,'single');
fclose(fid);

clear SALT*
%% Salt

%% Uvel
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Uvel.nc';
jj = 1432;

XCS = ncread(str,'XG');
YCS = ncread(str,'YC');
hFacW = ncread(str,'hFacW');
% X = XCS;
% Y = YCS;
% lox = find(X>288.3,1)-5;
% hix = find(X>352,1)+5;
% loy = find(Y>-60.1,1)-5;
% hiy = find(Y>-30.7,1)+5;
% YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacW = hFacW(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

UVEL_temp = ncread(str,'UVEL',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL_temp)))));

for jj=1:52
    UVEL_temp_temp = UVEL_temp(:,:,jj);
    UVEL_temp_temp(hFacW(:,:,jj)==0) = NaN;
    UVEL_temp_temp = fillmissingstan(UVEL_temp_temp);
    UVEL_temp(:,:,jj) = UVEL_temp_temp;
end
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL_temp)))));
UVEL = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,UVEL_temp(:,:,ii),'linear');
    UVEL(:,:,ii) = F(XU,YU);
end
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL)))));
Logic = UVEL==0&HW~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of UVEL mistakes = %g \n',num_mistakes)

for ii=1:5
    UVEL(ii,6:127,:) = UVEL(6,6:127,:); 
    UVEL(6:187,ii,:) = UVEL(6:187,6,:);
    UVEL(187+ii,6:127,:) = UVEL(187,6:127,:); 
    UVEL(6:187,127+ii,:) = UVEL(6:187,127,:);
end
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL)))));
Logic = UVEL==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of UVEL mistakes = %g \n',num_mistakes)

fid = fopen('UVEL_AB3_IC_20161201.bin','w','b');
fwrite(fid,UVEL,'single');
fclose(fid);

clear UVEL*
%% Uvel


%% Vvel
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Vvel.nc';
jj = 1432;

XCS = ncread(str,'XC');
YCS = ncread(str,'YG');
hFacS = ncread(str,'hFacS');
% X = XCS;
% Y = YCS;
% lox = find(X>288.3,1)-5;
% hix = find(X>352,1)+5;
% loy = find(Y>-60.1,1)-5;
% hiy = find(Y>-30.7,1)+5;
% YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacS = hFacS(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

VVEL_temp = ncread(str,'VVEL',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL_temp)))));

for jj=1:52
    VVEL_temp_temp = VVEL_temp(:,:,jj);
    VVEL_temp_temp(hFacS(:,:,jj)==0) = NaN;
    VVEL_temp_temp = fillmissingstan(VVEL_temp_temp);
    VVEL_temp(:,:,jj) = VVEL_temp_temp;
end
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL_temp)))));
VVEL = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,VVEL_temp(:,:,ii),'linear');
    VVEL(:,:,ii) = F(XV,YV);
end
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL)))));
Logic = VVEL==0&HS~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of VVEL mistakes = %g \n',num_mistakes)

for ii=1:5
    VVEL(ii,6:127,:) = VVEL(6,6:127,:); 
    VVEL(6:187,ii,:) = VVEL(6:187,6,:);
    VVEL(187+ii,6:127,:) = VVEL(187,6:127,:); 
    VVEL(6:187,127+ii,:) = VVEL(6:187,127,:);
end
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL)))));
Logic = VVEL==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of VVEL mistakes = %g \n',num_mistakes)

fid = fopen('VVEL_AB3_IC_20161201.bin','w','b');
fwrite(fid,VVEL,'single');
fclose(fid);

clear VVEL*
%% Vvel


%% DIC
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_DIC.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

DIC_temp = ncread(str,'TRAC01',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC_temp)))));

for jj=1:52
    DIC_temp_temp = DIC_temp(:,:,jj);
    DIC_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DIC_temp_temp = fillmissingstan(DIC_temp_temp);
    DIC_temp(:,:,jj) = DIC_temp_temp;
end
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC_temp)))));
DIC = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DIC_temp(:,:,ii),'linear');
    DIC(:,:,ii) = F(XC3,YC3);
end
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC)))));
Logic = DIC==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DIC mistakes = %g \n',num_mistakes)

for ii=1:5
    DIC(ii,6:127,:) = DIC(6,6:127,:); 
    DIC(6:187,ii,:) = DIC(6:187,6,:);
    DIC(187+ii,6:127,:) = DIC(187,6:127,:); 
    DIC(6:187,127+ii,:) = DIC(6:187,127,:);
end
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC)))));
Logic = DIC==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DIC mistakes = %g \n',num_mistakes)

fid = fopen('DIC_AB3_IC_20161201.bin','w','b');
fwrite(fid,DIC,'single');
fclose(fid);

clear DIC*
%% DIC


%% Alk
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_Alk.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

Alk_temp = ncread(str,'TRAC02',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk_temp)))));

for jj=1:52
    Alk_temp_temp = Alk_temp(:,:,jj);
    Alk_temp_temp(hFacC(:,:,jj)==0) = NaN;
    Alk_temp_temp = fillmissingstan(Alk_temp_temp);
    Alk_temp(:,:,jj) = Alk_temp_temp;
end
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk_temp)))));
Alk = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,Alk_temp(:,:,ii),'linear');
    Alk(:,:,ii) = F(XC3,YC3);
end
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk)))));
Logic = Alk==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of Alk mistakes = %g \n',num_mistakes)

for ii=1:5
    Alk(ii,6:127,:) = Alk(6,6:127,:); 
    Alk(6:187,ii,:) = Alk(6:187,6,:);
    Alk(187+ii,6:127,:) = Alk(187,6:127,:); 
    Alk(6:187,127+ii,:) = Alk(6:187,127,:);
end
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk)))));
Logic = Alk==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of Alk mistakes = %g \n',num_mistakes)

fid = fopen('Alk_AB3_IC_20161201.bin','w','b');
fwrite(fid,Alk,'single');
fclose(fid);

clear Alk*
%% Alk


%% O2
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_O2.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

O2_temp = ncread(str,'TRAC03',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2_temp)))));

for jj=1:52
    O2_temp_temp = O2_temp(:,:,jj);
    O2_temp_temp(hFacC(:,:,jj)==0) = NaN;
    O2_temp_temp = fillmissingstan(O2_temp_temp);
    O2_temp(:,:,jj) = O2_temp_temp;
end
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2_temp)))));
O2 = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,O2_temp(:,:,ii),'linear');
    O2(:,:,ii) = F(XC3,YC3);
end
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2)))));
Logic = O2==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of O2 mistakes = %g \n',num_mistakes)

for ii=1:5
    O2(ii,6:127,:) = O2(6,6:127,:); 
    O2(6:187,ii,:) = O2(6:187,6,:);
    O2(187+ii,6:127,:) = O2(187,6:127,:); 
    O2(6:187,127+ii,:) = O2(6:187,127,:);
end
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2)))));
Logic = O2==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of O2 mistakes = %g \n',num_mistakes)

fid = fopen('O2_AB3_IC_20161201.bin','w','b');
fwrite(fid,O2,'single');
fclose(fid);

clear O2*
%% O2


%% NO3
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_NO3.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

NO3_temp = ncread(str,'TRAC04',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3_temp)))));

for jj=1:52
    NO3_temp_temp = NO3_temp(:,:,jj);
    NO3_temp_temp(hFacC(:,:,jj)==0) = NaN;
    NO3_temp_temp = fillmissingstan(NO3_temp_temp);
    NO3_temp(:,:,jj) = NO3_temp_temp;
end
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3_temp)))));
NO3 = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,NO3_temp(:,:,ii),'linear');
    NO3(:,:,ii) = F(XC3,YC3);
end
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3)))));
Logic = NO3==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of NO3 mistakes = %g \n',num_mistakes)

for ii=1:5
    NO3(ii,6:127,:) = NO3(6,6:127,:); 
    NO3(6:187,ii,:) = NO3(6:187,6,:);
    NO3(187+ii,6:127,:) = NO3(187,6:127,:); 
    NO3(6:187,127+ii,:) = NO3(6:187,127,:);
end
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3)))));
Logic = NO3==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of NO3 mistakes = %g \n',num_mistakes)

fid = fopen('NO3_AB3_IC_20161201.bin','w','b');
fwrite(fid,NO3,'single');
fclose(fid);

clear NO3*
%% NO3

%% PO4
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_PO4.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

PO4_temp = ncread(str,'TRAC05',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4_temp)))));

for jj=1:52
    PO4_temp_temp = PO4_temp(:,:,jj);
    PO4_temp_temp(hFacC(:,:,jj)==0) = NaN;
    PO4_temp_temp = fillmissingstan(PO4_temp_temp);
    PO4_temp(:,:,jj) = PO4_temp_temp;
end
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4_temp)))));
PO4 = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,PO4_temp(:,:,ii),'linear');
    PO4(:,:,ii) = F(XC3,YC3);
end
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4)))));
Logic = PO4==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of PO4 mistakes = %g \n',num_mistakes)

for ii=1:5
    PO4(ii,6:127,:) = PO4(6,6:127,:); 
    PO4(6:187,ii,:) = PO4(6:187,6,:);
    PO4(187+ii,6:127,:) = PO4(187,6:127,:); 
    PO4(6:187,127+ii,:) = PO4(6:187,127,:);
end
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4)))));
Logic = PO4==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of PO4 mistakes = %g \n',num_mistakes)

fid = fopen('PO4_AB3_IC_20161201.bin','w','b');
fwrite(fid,PO4,'single');
fclose(fid);

clear PO4*
%% PO4


%% Fe
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_Fe.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

Fe_temp = ncread(str,'TRAC06',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe_temp)))));

for jj=1:52
    Fe_temp_temp = Fe_temp(:,:,jj);
    Fe_temp_temp(hFacC(:,:,jj)==0) = NaN;
    Fe_temp_temp = fillmissingstan(Fe_temp_temp);
    Fe_temp(:,:,jj) = Fe_temp_temp;
end
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe_temp)))));
Fe = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,Fe_temp(:,:,ii),'linear');
    Fe(:,:,ii) = F(XC3,YC3);
end
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe)))));
Logic = Fe==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of Fe mistakes = %g \n',num_mistakes)

for ii=1:5
    Fe(ii,6:127,:) = Fe(6,6:127,:); 
    Fe(6:187,ii,:) = Fe(6:187,6,:);
    Fe(187+ii,6:127,:) = Fe(187,6:127,:); 
    Fe(6:187,127+ii,:) = Fe(6:187,127,:);
end
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe)))));
Logic = Fe==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of Fe mistakes = %g \n',num_mistakes)

fid = fopen('Fe_AB3_IC_20161201.bin','w','b');
fwrite(fid,Fe,'single');
fclose(fid);

clear Fe*
%% Fe


%% DON
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_DON.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

DON_temp = ncread(str,'TRAC07',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON_temp)))));

for jj=1:52
    DON_temp_temp = DON_temp(:,:,jj);
    DON_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DON_temp_temp = fillmissingstan(DON_temp_temp);
    DON_temp(:,:,jj) = DON_temp_temp;
end
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON_temp)))));
DON = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DON_temp(:,:,ii),'linear');
    DON(:,:,ii) = F(XC3,YC3);
end
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON)))));

Logic = DON==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DON mistakes = %g \n',num_mistakes)

for ii=1:5
    DON(ii,6:127,:) = DON(6,6:127,:); 
    DON(6:187,ii,:) = DON(6:187,6,:);
    DON(187+ii,6:127,:) = DON(187,6:127,:); 
    DON(6:187,127+ii,:) = DON(6:187,127,:);
end
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON)))));

Logic = DON==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DON mistakes = %g \n',num_mistakes)

fid = fopen('DON_AB3_IC_20161201.bin','w','b');
fwrite(fid,DON,'single');
fclose(fid);

clear DON*
%% DON


%% DOP
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_DOP.nc';
jj = 287;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-5;
hix = find(X>352,1)+5;
loy = find(Y>-60.1,1)-5;
hiy = find(Y>-30.7,1)+5;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

DOP_temp = ncread(str,'TRAC08',[lox,loy,1,jj],[nn,mm,52,1]);
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP_temp)))));

for jj=1:52
    DOP_temp_temp = DOP_temp(:,:,jj);
    DOP_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DOP_temp_temp = fillmissingstan(DOP_temp_temp);
    DOP_temp(:,:,jj) = DOP_temp_temp;
end
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP_temp)))));
DOP = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DOP_temp(:,:,ii),'linear');
    DOP(:,:,ii) = F(XC3,YC3);
end
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP)))));
Logic = DOP==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DOP mistakes = %g \n',num_mistakes)

for ii=1:5
    DOP(ii,6:127,:) = DOP(6,6:127,:); 
    DOP(6:187,ii,:) = DOP(6:187,6,:);
    DOP(187+ii,6:127,:) = DOP(187,6:127,:); 
    DOP(6:187,127+ii,:) = DOP(6:187,127,:);
end
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP)))));

Logic = DOP==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DOP mistakes = %g \n',num_mistakes)

fid = fopen('DOP_AB3_IC_20161201.bin','w','b');
fwrite(fid,DOP,'single');
fclose(fid);

clear DOP*
%% DOP





toc()