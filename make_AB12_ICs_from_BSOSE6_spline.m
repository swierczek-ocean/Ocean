
clear
close all
clc

tic()

load XY12
HC = hFacC12;
HS = hFacS12;
HW = hFacW12;

[XU,YU] = ndgrid(XG12,YC12);
[XV,YV] = ndgrid(XC12,YG12);
[XC12,YC12] = ndgrid(XC12,YC12);

%% Theta
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc';
jj = 1432;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

THETA_temp = ncread(str,'THETA',[lox,loy,1,jj],[385,263,52,1]);
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA_temp)))));

for jj=1:52
    THETA_temp_temp = THETA_temp(:,:,jj);
    THETA_temp_temp(hFacC(:,:,jj)==0) = NaN;
    THETA_temp_temp = fillmissingstan(THETA_temp_temp);
    THETA_temp(:,:,jj) = THETA_temp_temp;
end
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA_temp)))));
THETA = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,THETA_temp(:,:,ii),'spline');
    THETA(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        THETA(:,:,1) = THETA(:,:,2);
    else
        THETA(:,:,2*ii-1) = 0.5*(THETA(:,:,2*ii-2) + THETA(:,:,2*ii)); 
    end
end
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA)))));
Logic = THETA==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of THETA mistakes = %g \n',num_mistakes)

for ii=1:15
    THETA(ii,16:497,:) = THETA(16,16:497,:); 
    THETA(16:741,ii,:) = THETA(16:741,16,:);
    THETA(741+ii,16:497,:) = THETA(741,16:497,:); 
    THETA(16:741,497+ii,:) = THETA(16:741,497,:);
end
fprintf('THETA has %g NaNs \n',sum(sum(sum(isnan(THETA)))));
Logic = THETA==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of THETA mistakes = %g \n',num_mistakes)

fid = fopen('THETA_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

SALT_temp = ncread(str,'SALT',[lox,loy,1,jj],[385,263,52,1]);
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT_temp)))));

for jj=1:52
    SALT_temp_temp = SALT_temp(:,:,jj);
    SALT_temp_temp(hFacC(:,:,jj)==0) = NaN;
    SALT_temp_temp = fillmissingstan(SALT_temp_temp);
    SALT_temp(:,:,jj) = SALT_temp_temp;
end
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT_temp)))));
SALT = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,SALT_temp(:,:,ii),'spline');
    SALT(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        SALT(:,:,1) = SALT(:,:,2);
    else
        SALT(:,:,2*ii-1) = 0.5*(SALT(:,:,2*ii-2) + SALT(:,:,2*ii)); 
    end    
end
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT)))));
Logic = SALT==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of SALT mistakes = %g \n',num_mistakes)

for ii=1:15
    SALT(ii,16:497,:) = SALT(16,16:497,:); 
    SALT(16:741,ii,:) = SALT(16:741,16,:);
    SALT(741+ii,16:497,:) = SALT(741,16:497,:); 
    SALT(16:741,497+ii,:) = SALT(16:741,497,:);
end
fprintf('SALT has %g NaNs \n',sum(sum(sum(isnan(SALT)))));
Logic = SALT==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of SALT mistakes = %g \n',num_mistakes)

fid = fopen('SALT_AB12_IC_20161201.bin','w','b');
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
% lox = find(X>288.3,1)-1;
% hix = find(X>352,1)+1;
% loy = find(Y>-60.1,1)-1;
% hiy = find(Y>-30.7,1)+1;
% YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacW = hFacW(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

UVEL_temp = ncread(str,'UVEL',[lox,loy,1,jj],[385,263,52,1]);
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL_temp)))));

for jj=1:52
    UVEL_temp_temp = UVEL_temp(:,:,jj);
    UVEL_temp_temp(hFacW(:,:,jj)==0) = NaN;
    UVEL_temp_temp = fillmissingstan(UVEL_temp_temp);
    UVEL_temp(:,:,jj) = UVEL_temp_temp;
end
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL_temp)))));
UVEL = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,UVEL_temp(:,:,ii),'spline');
    UVEL(:,:,2*ii) = F(XU,YU);
    if ii==1
        UVEL(:,:,1) = UVEL(:,:,2);
    else
        UVEL(:,:,2*ii-1) = 0.5*(UVEL(:,:,2*ii-2) + UVEL(:,:,2*ii)); 
    end
end
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL)))));
Logic = UVEL==0&HW~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of UVEL mistakes = %g \n',num_mistakes)

for ii=1:15
    UVEL(ii,16:497,:) = UVEL(16,16:497,:); 
    UVEL(16:741,ii,:) = UVEL(16:741,16,:);
    UVEL(741+ii,16:497,:) = UVEL(741,16:497,:); 
    UVEL(16:741,497+ii,:) = UVEL(16:741,497,:);
end
fprintf('UVEL has %g NaNs \n',sum(sum(sum(isnan(UVEL)))));
Logic = UVEL==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of UVEL mistakes = %g \n',num_mistakes)

fid = fopen('UVEL_AB12_IC_20161201.bin','w','b');
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
% lox = find(X>288.3,1)-1;
% hix = find(X>352,1)+1;
% loy = find(Y>-60.1,1)-1;
% hiy = find(Y>-30.7,1)+1;
% YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacS = hFacS(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

VVEL_temp = ncread(str,'VVEL',[lox,loy,1,jj],[385,263,52,1]);
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL_temp)))));

for jj=1:52
    VVEL_temp_temp = VVEL_temp(:,:,jj);
    VVEL_temp_temp(hFacS(:,:,jj)==0) = NaN;
    VVEL_temp_temp = fillmissingstan(VVEL_temp_temp);
    VVEL_temp(:,:,jj) = VVEL_temp_temp;
end
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL_temp)))));
VVEL = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,VVEL_temp(:,:,ii),'spline');
    VVEL(:,:,2*ii) = F(XV,YV);
    if ii==1
        VVEL(:,:,1) = VVEL(:,:,2);
    else
        VVEL(:,:,2*ii-1) = 0.5*(VVEL(:,:,2*ii-2) + VVEL(:,:,2*ii)); 
    end
end
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL)))));
Logic = VVEL==0&HS~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of VVEL mistakes = %g \n',num_mistakes)

for ii=1:15
    VVEL(ii,16:497,:) = VVEL(16,16:497,:); 
    VVEL(16:741,ii,:) = VVEL(16:741,16,:);
    VVEL(741+ii,16:497,:) = VVEL(741,16:497,:); 
    VVEL(16:741,497+ii,:) = VVEL(16:741,497,:);
end
fprintf('VVEL has %g NaNs \n',sum(sum(sum(isnan(VVEL)))));
Logic = VVEL==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of VVEL mistakes = %g \n',num_mistakes)

fid = fopen('VVEL_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

DIC_temp = ncread(str,'TRAC01',[lox,loy,1,jj],[385,263,52,1]);
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC_temp)))));

for jj=1:52
    DIC_temp_temp = DIC_temp(:,:,jj);
    DIC_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DIC_temp_temp = fillmissingstan(DIC_temp_temp);
    DIC_temp(:,:,jj) = DIC_temp_temp;
end
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC_temp)))));
DIC = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DIC_temp(:,:,ii),'spline');
    DIC(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        DIC(:,:,1) = DIC(:,:,2);
    else
        DIC(:,:,2*ii-1) = 0.5*(DIC(:,:,2*ii-2) + DIC(:,:,2*ii)); 
    end
end
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC)))));
Logic = DIC==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of DIC mistakes = %g \n',num_mistakes)

for ii=1:15
    DIC(ii,16:497,:) = DIC(16,16:497,:); 
    DIC(16:741,ii,:) = DIC(16:741,16,:);
    DIC(741+ii,16:497,:) = DIC(741,16:497,:); 
    DIC(16:741,497+ii,:) = DIC(16:741,497,:);
end
fprintf('DIC has %g NaNs \n',sum(sum(sum(isnan(DIC)))));
Logic = DIC==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of DIC mistakes = %g \n',num_mistakes)

fid = fopen('DIC_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

Alk_temp = ncread(str,'TRAC02',[lox,loy,1,jj],[385,263,52,1]);
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk_temp)))));

for jj=1:52
    Alk_temp_temp = Alk_temp(:,:,jj);
    Alk_temp_temp(hFacC(:,:,jj)==0) = NaN;
    Alk_temp_temp = fillmissingstan(Alk_temp_temp);
    Alk_temp(:,:,jj) = Alk_temp_temp;
end
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk_temp)))));
Alk = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,Alk_temp(:,:,ii),'spline');
    Alk(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        Alk(:,:,1) = Alk(:,:,2);
    else
        Alk(:,:,2*ii-1) = 0.5*(Alk(:,:,2*ii-2) + Alk(:,:,2*ii)); 
    end
end
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk)))));
Logic = Alk==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of Alk mistakes = %g \n',num_mistakes)

for ii=1:15
    Alk(ii,16:497,:) = Alk(16,16:497,:); 
    Alk(16:741,ii,:) = Alk(16:741,16,:);
    Alk(741+ii,16:497,:) = Alk(741,16:497,:); 
    Alk(16:741,497+ii,:) = Alk(16:741,497,:);
end
fprintf('Alk has %g NaNs \n',sum(sum(sum(isnan(Alk)))));
Logic = Alk==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of Alk mistakes = %g \n',num_mistakes)

fid = fopen('Alk_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

O2_temp = ncread(str,'TRAC03',[lox,loy,1,jj],[385,263,52,1]);
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2_temp)))));

for jj=1:52
    O2_temp_temp = O2_temp(:,:,jj);
    O2_temp_temp(hFacC(:,:,jj)==0) = NaN;
    O2_temp_temp = fillmissingstan(O2_temp_temp);
    O2_temp(:,:,jj) = O2_temp_temp;
end
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2_temp)))));
O2 = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,O2_temp(:,:,ii),'spline');
    O2(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        O2(:,:,1) = O2(:,:,2);
    else
        O2(:,:,2*ii-1) = 0.5*(O2(:,:,2*ii-2) + O2(:,:,2*ii)); 
    end
end
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2)))));
Logic = O2==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of O2 mistakes = %g \n',num_mistakes)

for ii=1:15
    O2(ii,16:497,:) = O2(16,16:497,:); 
    O2(16:741,ii,:) = O2(16:741,16,:);
    O2(741+ii,16:497,:) = O2(741,16:497,:); 
    O2(16:741,497+ii,:) = O2(16:741,497,:);
end
fprintf('O2 has %g NaNs \n',sum(sum(sum(isnan(O2)))));
Logic = O2==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of O2 mistakes = %g \n',num_mistakes)

fid = fopen('O2_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

NO3_temp = ncread(str,'TRAC04',[lox,loy,1,jj],[385,263,52,1]);
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3_temp)))));

for jj=1:52
    NO3_temp_temp = NO3_temp(:,:,jj);
    NO3_temp_temp(hFacC(:,:,jj)==0) = NaN;
    NO3_temp_temp = fillmissingstan(NO3_temp_temp);
    NO3_temp(:,:,jj) = NO3_temp_temp;
end
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3_temp)))));
NO3 = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,NO3_temp(:,:,ii),'spline');
    NO3(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        NO3(:,:,1) = NO3(:,:,2);
    else
        NO3(:,:,2*ii-1) = 0.5*(NO3(:,:,2*ii-2) + NO3(:,:,2*ii)); 
    end
end
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3)))));
Logic = NO3==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of NO3 mistakes = %g \n',num_mistakes)

for ii=1:15
    NO3(ii,16:497,:) = NO3(16,16:497,:); 
    NO3(16:741,ii,:) = NO3(16:741,16,:);
    NO3(741+ii,16:497,:) = NO3(741,16:497,:); 
    NO3(16:741,497+ii,:) = NO3(16:741,497,:);
end
fprintf('NO3 has %g NaNs \n',sum(sum(sum(isnan(NO3)))));
Logic = NO3==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of NO3 mistakes = %g \n',num_mistakes)

fid = fopen('NO3_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

PO4_temp = ncread(str,'TRAC05',[lox,loy,1,jj],[385,263,52,1]);
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4_temp)))));

for jj=1:52
    PO4_temp_temp = PO4_temp(:,:,jj);
    PO4_temp_temp(hFacC(:,:,jj)==0) = NaN;
    PO4_temp_temp = fillmissingstan(PO4_temp_temp);
    PO4_temp(:,:,jj) = PO4_temp_temp;
end
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4_temp)))));
PO4 = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,PO4_temp(:,:,ii),'spline');
    PO4(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        PO4(:,:,1) = PO4(:,:,2);
    else
        PO4(:,:,2*ii-1) = 0.5*(PO4(:,:,2*ii-2) + PO4(:,:,2*ii)); 
    end
end
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4)))));
Logic = PO4==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of PO4 mistakes = %g \n',num_mistakes)

for ii=1:15
    PO4(ii,16:497,:) = PO4(16,16:497,:); 
    PO4(16:741,ii,:) = PO4(16:741,16,:);
    PO4(741+ii,16:497,:) = PO4(741,16:497,:); 
    PO4(16:741,497+ii,:) = PO4(16:741,497,:);
end
fprintf('PO4 has %g NaNs \n',sum(sum(sum(isnan(PO4)))));
Logic = PO4==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of PO4 mistakes = %g \n',num_mistakes)

fid = fopen('PO4_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

Fe_temp = ncread(str,'TRAC06',[lox,loy,1,jj],[385,263,52,1]);
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe_temp)))));

for jj=1:52
    Fe_temp_temp = Fe_temp(:,:,jj);
    Fe_temp_temp(hFacC(:,:,jj)==0) = NaN;
    Fe_temp_temp = fillmissingstan(Fe_temp_temp);
    Fe_temp(:,:,jj) = Fe_temp_temp;
end
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe_temp)))));
Fe = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,Fe_temp(:,:,ii),'spline');
    Fe(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        Fe(:,:,1) = Fe(:,:,2);
    else
        Fe(:,:,2*ii-1) = 0.5*(Fe(:,:,2*ii-2) + Fe(:,:,2*ii)); 
    end
end
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe)))));
Logic = Fe==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of Fe mistakes = %g \n',num_mistakes)

for ii=1:15
    Fe(ii,16:497,:) = Fe(16,16:497,:); 
    Fe(16:741,ii,:) = Fe(16:741,16,:);
    Fe(741+ii,16:497,:) = Fe(741,16:497,:); 
    Fe(16:741,497+ii,:) = Fe(16:741,497,:);
end
fprintf('Fe has %g NaNs \n',sum(sum(sum(isnan(Fe)))));
Logic = Fe==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of Fe mistakes = %g \n',num_mistakes)

fid = fopen('Fe_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

DON_temp = ncread(str,'TRAC07',[lox,loy,1,jj],[385,263,52,1]);
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON_temp)))));

for jj=1:52
    DON_temp_temp = DON_temp(:,:,jj);
    DON_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DON_temp_temp = fillmissingstan(DON_temp_temp);
    DON_temp(:,:,jj) = DON_temp_temp;
end
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON_temp)))));
DON = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DON_temp(:,:,ii),'spline');
    DON(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        DON(:,:,1) = DON(:,:,2);
    else
        DON(:,:,2*ii-1) = 0.5*(DON(:,:,2*ii-2) + DON(:,:,2*ii)); 
    end
end
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON)))));

Logic = DON==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of DON mistakes = %g \n',num_mistakes)

for ii=1:15
    DON(ii,16:497,:) = DON(16,16:497,:); 
    DON(16:741,ii,:) = DON(16:741,16,:);
    DON(741+ii,16:497,:) = DON(741,16:497,:); 
    DON(16:741,497+ii,:) = DON(16:741,497,:);
end
fprintf('DON has %g NaNs \n',sum(sum(sum(isnan(DON)))));

Logic = DON==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of DON mistakes = %g \n',num_mistakes)

fid = fopen('DON_AB12_IC_20161201.bin','w','b');
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
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);

DOP_temp = ncread(str,'TRAC08',[lox,loy,1,jj],[385,263,52,1]);
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP_temp)))));

for jj=1:52
    DOP_temp_temp = DOP_temp(:,:,jj);
    DOP_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DOP_temp_temp = fillmissingstan(DOP_temp_temp);
    DOP_temp(:,:,jj) = DOP_temp_temp;
end
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP_temp)))));
DOP = zeros(756,512,104);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DOP_temp(:,:,ii),'spline');
    DOP(:,:,2*ii) = F(XC12,YC12);
    if ii==1
        DOP(:,:,1) = DOP(:,:,2);
    else
        DOP(:,:,2*ii-1) = 0.5*(DOP(:,:,2*ii-2) + DOP(:,:,2*ii)); 
    end
end
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP)))));
Logic = DOP==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of DOP mistakes = %g \n',num_mistakes)

for ii=1:15
    DOP(ii,16:497,:) = DOP(16,16:497,:); 
    DOP(16:741,ii,:) = DOP(16:741,16,:);
    DOP(741+ii,16:497,:) = DOP(741,16:497,:); 
    DOP(16:741,497+ii,:) = DOP(16:741,497,:);
end
fprintf('DOP has %g NaNs \n',sum(sum(sum(isnan(DOP)))));

Logic = DOP==0&HC~=0;
num_mistakes = sum(reshape(Logic,[756*512*104,1]));
fprintf('number of DOP mistakes = %g \n',num_mistakes)

fid = fopen('DOP_AB12_IC_20161201.bin','w','b');
fwrite(fid,DOP,'single');
fclose(fid);

clear DOP*
%% DOP





toc()