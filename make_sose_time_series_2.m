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
HC = HC(6:187,6:127,1);

%% pCO2
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_pCO2.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

pCO2_temp = ncread(str,'BLGPCO2',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    pCO2_temp_temp = pCO2_temp(:,:,jj);
    pCO2_temp_temp(hFacC(:,:,1)==0) = NaN;
    pCO2_temp_temp = fillmissingstan(pCO2_temp_temp);
    pCO2_temp(:,:,jj) = pCO2_temp_temp;
end
pCO2 = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,pCO2_temp(:,:,ii),'linear');
    pCO2(:,:,ii) = F(XC3,YC3);
end

pCO2 = pCO2(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           pCO2(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('pCO2_bsose_ts.bin','w','b');
fwrite(fid,pCO2,'single');
fclose(fid);

fprintf('finished pCO2 \n')
clear pCO2*
%% pCO2

%% MLD
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_MLD.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

MLD_temp = ncread(str,'BLGMLD',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    MLD_temp_temp = MLD_temp(:,:,jj);
    MLD_temp_temp(hFacC(:,:,1)==0) = NaN;
    MLD_temp_temp = fillmissingstan(MLD_temp_temp);
    MLD_temp(:,:,jj) = MLD_temp_temp;
end
MLD = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,MLD_temp(:,:,ii),'linear');
    MLD(:,:,ii) = F(XC3,YC3);
end

MLD = MLD(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           MLD(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('MLD_bsose_ts.bin','w','b');
fwrite(fid,MLD,'single');
fclose(fid);

fprintf('finished MLD \n')
clear MLD*
%% MLD

%% SSH
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_SSH.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

SSH_temp = ncread(str,'ETAN',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    SSH_temp_temp = SSH_temp(:,:,jj);
    SSH_temp_temp(hFacC(:,:,1)==0) = NaN;
    SSH_temp_temp = fillmissingstan(SSH_temp_temp);
    SSH_temp(:,:,jj) = SSH_temp_temp;
end
SSH = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,SSH_temp(:,:,ii),'linear');
    SSH(:,:,ii) = F(XC3,YC3);
end

SSH = SSH(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           SSH(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('SSH_bsose_ts.bin','w','b');
fwrite(fid,SSH,'single');
fclose(fid);

fprintf('finished SSH \n')
clear SSH*
%% SSH

%% surfCO2flx
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_surfCO2flx.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

surfCO2flx_temp = ncread(str,'BLGCFLX',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    surfCO2flx_temp_temp = surfCO2flx_temp(:,:,jj);
    surfCO2flx_temp_temp(hFacC(:,:,1)==0) = NaN;
    surfCO2flx_temp_temp = fillmissingstan(surfCO2flx_temp_temp);
    surfCO2flx_temp(:,:,jj) = surfCO2flx_temp_temp;
end
surfCO2flx = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,surfCO2flx_temp(:,:,ii),'linear');
    surfCO2flx(:,:,ii) = F(XC3,YC3);
end

surfCO2flx = surfCO2flx(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           surfCO2flx(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('surfCO2flx_bsose_ts.bin','w','b');
fwrite(fid,surfCO2flx,'single');
fclose(fid);

fprintf('finished surfCO2flx \n')
clear surfCO2flx*
%% surfCO2flx

%% surfO2flx
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_surfO2flx.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

surfO2flx_temp = ncread(str,'BLGOFLX',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    surfO2flx_temp_temp = surfO2flx_temp(:,:,jj);
    surfO2flx_temp_temp(hFacC(:,:,1)==0) = NaN;
    surfO2flx_temp_temp = fillmissingstan(surfO2flx_temp_temp);
    surfO2flx_temp(:,:,jj) = surfO2flx_temp_temp;
end
surfO2flx = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,surfO2flx_temp(:,:,ii),'linear');
    surfO2flx(:,:,ii) = F(XC3,YC3);
end

surfO2flx = surfO2flx(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           surfO2flx(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('surfO2flx_bsose_ts.bin','w','b');
fwrite(fid,surfO2flx,'single');
fclose(fid);

fprintf('finished surfO2flx \n')
clear surfO2flx*
%% surfO2flx


%% surfSflx
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_surfSflx.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

surfSflx_temp = ncread(str,'SFLUX',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    surfSflx_temp_temp = surfSflx_temp(:,:,jj);
    surfSflx_temp_temp(hFacC(:,:,1)==0) = NaN;
    surfSflx_temp_temp = fillmissingstan(surfSflx_temp_temp);
    surfSflx_temp(:,:,jj) = surfSflx_temp_temp;
end
surfSflx = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,surfSflx_temp(:,:,ii),'linear');
    surfSflx(:,:,ii) = F(XC3,YC3);
end

surfSflx = surfSflx(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           surfSflx(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('surfSflx_bsose_ts.bin','w','b');
fwrite(fid,surfSflx,'single');
fclose(fid);

fprintf('finished surfSflx \n')
clear surfSflx*
%% surfSflx

%% surfTflx
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_surfTflx.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

surfTflx_temp = ncread(str,'TFLUX',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    surfTflx_temp_temp = surfTflx_temp(:,:,jj);
    surfTflx_temp_temp(hFacC(:,:,1)==0) = NaN;
    surfTflx_temp_temp = fillmissingstan(surfTflx_temp_temp);
    surfTflx_temp(:,:,jj) = surfTflx_temp_temp;
end
surfTflx = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,surfTflx_temp(:,:,ii),'linear');
    surfTflx(:,:,ii) = F(XC3,YC3);
end

surfTflx = surfTflx(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           surfTflx(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('surfTflx_bsose_ts.bin','w','b');
fwrite(fid,surfTflx,'single');
fclose(fid);

fprintf('finished surfTflx \n')
clear surfTflx*
%% surfTflx

%% BottomPres
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_BottomPres.nc';
sd = 1432;
nd = 395;

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread('/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc','hFacC');
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

BottomPres_temp = ncread(str,'PHIBOT',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    BottomPres_temp_temp = BottomPres_temp(:,:,jj);
    BottomPres_temp_temp(hFacC(:,:,1)==0) = NaN;
    BottomPres_temp_temp = fillmissingstan(BottomPres_temp_temp);
    BottomPres_temp(:,:,jj) = BottomPres_temp_temp;
end
BottomPres = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,BottomPres_temp(:,:,ii),'linear');
    BottomPres(:,:,ii) = F(XC3,YC3);
end

BottomPres = BottomPres(6:187,6:127,:);

for ii=1:182
    for jj=1:122
        if HC(ii,jj)==0
           BottomPres(ii,jj,:) = 9999999; 
        end
    end
end


fid = fopen('BottomPres_bsose_ts.bin','w','b');
fwrite(fid,BottomPres,'single');
fclose(fid);

fprintf('finished BottomPres \n')
clear BottomPres*
%% BottomPres



