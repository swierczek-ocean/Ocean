
clear
close all
clc

tic()

XC = rdmds('XC');
YC = rdmds('YC');
XG = rdmds('XG');
YG = rdmds('YG');
HC = rdmds('hFacC');
XC = XC(:,end);
YC = YC(end,:);
XG = XG(:,end);
YG = YG(end,:);

lox3 = find(XC>288.3,1);
hix3 = find(XC>352,1);
loy3 = find(YC>-60.1,1)-1;
hiy3 = find(YC>-30.7,1);
YY3 = find(YC>-32.1,1);

[XC3,YC3] = ndgrid(XC,YC);
[XU,YU] = ndgrid(XG,YC);
[XV,YV] = ndgrid(XC,YG);

vl = 27;

HC = HC(6:187,6:127,vl);

%% Theta
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc';
sd = 1432;
nd = 395;

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

THETA_temp = ncread(str,'THETA',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    THETA_temp_temp = THETA_temp(:,:,jj);
    THETA_temp_temp(hFacC(:,:,vl)==0) = NaN;
    THETA_temp_temp = fillmissingstan(THETA_temp_temp);
    THETA_temp(:,:,jj) = THETA_temp_temp;
end
THETA = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,THETA_temp(:,:,ii),'linear');
    THETA(:,:,ii) = F(XC3,YC3);
end

THETA = THETA(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           THETA(ii,jj,:) = 9999999; 
        end
    end
end

fid = fopen(['THETA_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,THETA,'single');
fclose(fid);
fprintf('finished THETA \n')

clear THETA*
%% Theta

%% Salt
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Salt.nc';
sd = 1432;
nd = 395;

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

SALT_temp = ncread(str,'SALT',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    SALT_temp_temp = SALT_temp(:,:,jj);
    SALT_temp_temp(hFacC(:,:,vl)==0) = NaN;
    SALT_temp_temp = fillmissingstan(SALT_temp_temp);
    SALT_temp(:,:,jj) = SALT_temp_temp;
end
SALT = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,SALT_temp(:,:,ii),'linear');
    SALT(:,:,ii) = F(XC3,YC3);
end

SALT = SALT(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           SALT(ii,jj,:) = 9999999; 
        end
    end
end

fid = fopen(['SALT_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,SALT,'single');
fclose(fid);

fprintf('finished SALT \n')
clear SALT*
%% Salt

%% Uvel
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Uvel.nc';
sd = 1432;
nd = 395;

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

UVEL_temp = ncread(str,'UVEL',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    UVEL_temp_temp = UVEL_temp(:,:,jj);
    UVEL_temp_temp(hFacW(:,:,vl)==0) = NaN;
    UVEL_temp_temp = fillmissingstan(UVEL_temp_temp);
    UVEL_temp(:,:,jj) = UVEL_temp_temp;
end
UVEL = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,UVEL_temp(:,:,ii),'linear');
    UVEL(:,:,ii) = F(XU,YU);
end

UVEL = UVEL(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           UVEL(ii,jj,:) = 9999999; 
        end
    end
end

fid = fopen(['UVEL_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,UVEL,'single');
fclose(fid);

fprintf('finished UVEL \n')
clear UVEL*
%% Uvel


%% Vvel
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Vvel.nc';
sd = 1432;
nd = 395;

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

VVEL_temp = ncread(str,'VVEL',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    VVEL_temp_temp = VVEL_temp(:,:,jj);
    VVEL_temp_temp(hFacS(:,:,vl)==0) = NaN;
    VVEL_temp_temp = fillmissingstan(VVEL_temp_temp);
    VVEL_temp(:,:,jj) = VVEL_temp_temp;
end
VVEL = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,VVEL_temp(:,:,ii),'linear');
    VVEL(:,:,ii) = F(XV,YV);
end

VVEL = VVEL(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           VVEL(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['VVEL_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,VVEL,'single');
fclose(fid);

fprintf('finished VVEL \n')
clear VVEL*
%% Vvel


%% DIC
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_DIC.nc';
sd = 287;
nd = 79;

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

DIC_temp = ncread(str,'TRAC01',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    DIC_temp_temp = DIC_temp(:,:,jj);
    DIC_temp_temp(hFacC(:,:,vl)==0) = NaN;
    DIC_temp_temp = fillmissingstan(DIC_temp_temp);
    DIC_temp(:,:,jj) = DIC_temp_temp;
end
DIC = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,DIC_temp(:,:,ii),'linear');
    DIC(:,:,ii) = F(XC3,YC3);
end

DIC = DIC(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           DIC(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['DIC_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,DIC,'single');
fclose(fid);

fprintf('finished DIC \n')
clear DIC*
%% DIC


%% Alk
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_Alk.nc';
sd = 287;
nd = 79;

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

Alk_temp = ncread(str,'TRAC02',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    Alk_temp_temp = Alk_temp(:,:,jj);
    Alk_temp_temp(hFacC(:,:,vl)==0) = NaN;
    Alk_temp_temp = fillmissingstan(Alk_temp_temp);
    Alk_temp(:,:,jj) = Alk_temp_temp;
end
Alk = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,Alk_temp(:,:,ii),'linear');
    Alk(:,:,ii) = F(XC3,YC3);
end

Alk = Alk(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           Alk(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['Alk_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,Alk,'single');
fclose(fid);

fprintf('finished Alk \n')
clear Alk*
%% Alk


%% O2
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_O2.nc';
sd = 287;
nd = 79;

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

O2_temp = ncread(str,'TRAC03',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    O2_temp_temp = O2_temp(:,:,jj);
    O2_temp_temp(hFacC(:,:,vl)==0) = NaN;
    O2_temp_temp = fillmissingstan(O2_temp_temp);
    O2_temp(:,:,jj) = O2_temp_temp;
end
O2 = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,O2_temp(:,:,ii),'linear');
    O2(:,:,ii) = F(XC3,YC3);
end

O2 = O2(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           O2(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['O2_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,O2,'single');
fclose(fid);

fprintf('finished O2 \n')
clear O2*
%% O2


%% NO3
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_NO3.nc';
sd = 287;
nd = 79;

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

NO3_temp = ncread(str,'TRAC04',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    NO3_temp_temp = NO3_temp(:,:,jj);
    NO3_temp_temp(hFacC(:,:,vl)==0) = NaN;
    NO3_temp_temp = fillmissingstan(NO3_temp_temp);
    NO3_temp(:,:,jj) = NO3_temp_temp;
end
NO3 = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,NO3_temp(:,:,ii),'linear');
    NO3(:,:,ii) = F(XC3,YC3);
end

NO3 = NO3(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           NO3(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['NO3_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,NO3,'single');
fclose(fid);

fprintf('finished NO3 \n')
clear NO3*
%% NO3

%% PO4
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_PO4.nc';
sd = 287;
nd = 79;

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

PO4_temp = ncread(str,'TRAC05',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    PO4_temp_temp = PO4_temp(:,:,jj);
    PO4_temp_temp(hFacC(:,:,vl)==0) = NaN;
    PO4_temp_temp = fillmissingstan(PO4_temp_temp);
    PO4_temp(:,:,jj) = PO4_temp_temp;
end
PO4 = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,PO4_temp(:,:,ii),'linear');
    PO4(:,:,ii) = F(XC3,YC3);
end

PO4 = PO4(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           PO4(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['PO4_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,PO4,'single');
fclose(fid);

fprintf('finished PO4 \n')
clear PO4*
%% PO4


%% Fe
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_Fe.nc';
sd = 287;
nd = 79;

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

Fe_temp = ncread(str,'TRAC06',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    Fe_temp_temp = Fe_temp(:,:,jj);
    Fe_temp_temp(hFacC(:,:,vl)==0) = NaN;
    Fe_temp_temp = fillmissingstan(Fe_temp_temp);
    Fe_temp(:,:,jj) = Fe_temp_temp;
end
Fe = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,Fe_temp(:,:,ii),'linear');
    Fe(:,:,ii) = F(XC3,YC3);
end

Fe = Fe(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           Fe(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['Fe_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,Fe,'single');
fclose(fid);

fprintf('finished Fe \n')
clear Fe*
%% Fe


%% DON
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_DON.nc';
sd = 287;
nd = 79;

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

DON_temp = ncread(str,'TRAC07',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    DON_temp_temp = DON_temp(:,:,jj);
    DON_temp_temp(hFacC(:,:,vl)==0) = NaN;
    DON_temp_temp = fillmissingstan(DON_temp_temp);
    DON_temp(:,:,jj) = DON_temp_temp;
end
DON = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,DON_temp(:,:,ii),'linear');
    DON(:,:,ii) = F(XC3,YC3);
end

DON = DON(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           DON(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['DON_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,DON,'single');
fclose(fid);

fprintf('finished DON \n')
clear DON*
%% DON


%% DOP
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_5day_DOP.nc';
sd = 287;
nd = 79;

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

DOP_temp = ncread(str,'TRAC08',[lox,loy,vl,sd],[385,263,1,nd]);

for jj=1:nd
    DOP_temp_temp = DOP_temp(:,:,jj);
    DOP_temp_temp(hFacC(:,:,vl)==0) = NaN;
    DOP_temp_temp = fillmissingstan(DOP_temp_temp);
    DOP_temp(:,:,jj) = DOP_temp_temp;
end
DOP = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,DOP_temp(:,:,ii),'linear');
    DOP(:,:,ii) = F(XC3,YC3);
end

DOP = DOP(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           DOP(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen(['DOP_bsose_ts_vl_',num2str(vl),'.bin'],'w','b');
fwrite(fid,DOP,'single');
fclose(fid);

fprintf('finished DOP \n')
clear DOP*
%% DOP





toc()