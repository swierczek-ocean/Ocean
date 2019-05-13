tic()
clc
clear
close all


load XY3

HC = hFacC3;
HS = hFacS3;
HW = hFacW3;

[XU,YU] = ndgrid(XG3,YC3);
[XV,YV] = ndgrid(XC3,YG3);
[XC3,YC3] = ndgrid(XC3,YC3);

%% DIC
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_DIC.nc';

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



DIC_temp = ncread(str,'TRAC01',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        DIC_temp_temp = DIC_temp(:,:,jj,ii);
        DIC_temp_temp(hFacC(:,:,jj)==0) = NaN;
        DIC_temp_temp = fillmissingstan(DIC_temp_temp);
        DIC_temp(:,:,jj,ii) = DIC_temp_temp;
    end
end
DIC = zeros(192,132,52,61);

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,DIC_temp(:,:,ii,jj),'linear');
        DIC(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = DIC(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of DIC mistakes = %g \n',num_mistakes)

fprintf('DIC grid = [%g,%g]x[%g,%g] \n DIC nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


DICN = DIC(:,127,:,:);
DICS = DIC(:,6,:,:);
DICE = DIC(187,:,:,:);
DICW = DIC(6,:,:,:);
for ii=1:5
    DICN(ii,:,:,:) = DICN(6,:,:,:);
    DICN(187+ii,:,:,:) = DICN(187,:,:,:);
    DICS(ii,:,:,:) = DICS(6,:,:,:);
    DICS(187+ii,:,:,:) = DICS(187,:,:,:);
    DICE(:,ii,:,:) = DICE(:,6,:,:);
    DICE(:,127+ii,:,:) = DICE(:,127,:,:);
    DICW(:,ii,:,:) = DICW(:,6,:,:);
    DICW(:,127+ii,:,:) = DICW(:,127,:,:);
end

DICN = squeeze(DICN);
DICS = squeeze(DICS);
DICE = squeeze(DICE);
DICW = squeeze(DICW);

DICN(:,:,61) = DICN(:,:,60);
DICS(:,:,61) = DICS(:,:,60);
DICE(:,:,61) = DICE(:,:,60);
DICW(:,:,61) = DICW(:,:,60);

fprintf('DICN has %g NaNs \n',sum(sum(sum(isnan(DICN)))));
fprintf('DICS has %g NaNs \n',sum(sum(sum(isnan(DICS)))));
fprintf('DICE has %g NaNs \n',sum(sum(sum(isnan(DICE)))));
fprintf('DICW has %g NaNs \n',sum(sum(sum(isnan(DICW)))));

fid = fopen('DIC_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DICN,'single');
fclose(fid);

fid = fopen('DIC_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DICS,'single');
fclose(fid);

fid = fopen('DIC_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DICE,'single');
fclose(fid);

fid = fopen('DIC_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DICW,'single');
fclose(fid);

clear DIC*
%% end DIC


%% ALK
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Alk.nc';

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



ALK_temp = ncread(str,'TRAC02',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        ALK_temp_temp = ALK_temp(:,:,jj,ii);
        ALK_temp_temp(hFacC(:,:,jj)==0) = NaN;
        ALK_temp_temp = fillmissingstan(ALK_temp_temp);
        ALK_temp(:,:,jj,ii) = ALK_temp_temp;
    end
end
ALK = zeros(192,132,52,61);

fprintf('ALK grid = [%g,%g]x[%g,%g] \n ALK nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,ALK_temp(:,:,ii,jj),'linear');
        ALK(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = ALK(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of ALK mistakes = %g \n',num_mistakes)

ALKN = ALK(:,127,:,:);
ALKS = ALK(:,6,:,:);
ALKE = ALK(187,:,:,:);
ALKW = ALK(6,:,:,:);
for ii=1:5
    ALKN(ii,:,:,:) = ALKN(6,:,:,:);
    ALKN(187+ii,:,:,:) = ALKN(187,:,:,:);
    ALKS(ii,:,:,:) = ALKS(6,:,:,:);
    ALKS(187+ii,:,:,:) = ALKS(187,:,:,:);
    ALKE(:,ii,:,:) = ALKE(:,6,:,:);
    ALKE(:,127+ii,:,:) = ALKE(:,127,:,:);
    ALKW(:,ii,:,:) = ALKW(:,6,:,:);
    ALKW(:,127+ii,:,:) = ALKW(:,127,:,:);
end

ALKN = squeeze(ALKN);
ALKS = squeeze(ALKS);
ALKE = squeeze(ALKE);
ALKW = squeeze(ALKW);
ALKN(:,:,61) = ALKN(:,:,60);
ALKS(:,:,61) = ALKS(:,:,60);
ALKE(:,:,61) = ALKE(:,:,60);
ALKW(:,:,61) = ALKW(:,:,60);

fprintf('ALKN has %g NaNs \n',sum(sum(sum(isnan(ALKN)))));
fprintf('ALKS has %g NaNs \n',sum(sum(sum(isnan(ALKS)))));
fprintf('ALKE has %g NaNs \n',sum(sum(sum(isnan(ALKE)))));
fprintf('ALKW has %g NaNs \n',sum(sum(sum(isnan(ALKW)))));

fid = fopen('ALK_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,ALKN,'single');
fclose(fid);

fid = fopen('ALK_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,ALKS,'single');
fclose(fid);

fid = fopen('ALK_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,ALKE,'single');
fclose(fid);

fid = fopen('ALK_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,ALKW,'single');
fclose(fid);

clear ALK*
%% end ALK

%% O2
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_O2.nc';

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



O2_temp = ncread(str,'TRAC03',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        O2_temp_temp = O2_temp(:,:,jj,ii);
        O2_temp_temp(hFacC(:,:,jj)==0) = NaN;
        O2_temp_temp = fillmissingstan(O2_temp_temp);
        O2_temp(:,:,jj,ii) = O2_temp_temp;
    end
end
O2 = zeros(192,132,52,61);

fprintf('O2 grid = [%g,%g]x[%g,%g] \n O2 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,O2_temp(:,:,ii,jj),'linear');
        O2(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = O2(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of O2 mistakes = %g \n',num_mistakes)

O2N = O2(:,127,:,:);
O2S = O2(:,6,:,:);
O2E = O2(187,:,:,:);
O2W = O2(6,:,:,:);
for ii=1:5
    O2N(ii,:,:,:) = O2N(6,:,:,:);
    O2N(187+ii,:,:,:) = O2N(187,:,:,:);
    O2S(ii,:,:,:) = O2S(6,:,:,:);
    O2S(187+ii,:,:,:) = O2S(187,:,:,:);
    O2E(:,ii,:,:) = O2E(:,6,:,:);
    O2E(:,127+ii,:,:) = O2E(:,127,:,:);
    O2W(:,ii,:,:) = O2W(:,6,:,:);
    O2W(:,127+ii,:,:) = O2W(:,127,:,:);
end

O2N = squeeze(O2N);
O2S = squeeze(O2S);
O2E = squeeze(O2E);
O2W = squeeze(O2W);
O2N(:,:,61) = O2N(:,:,60);
O2S(:,:,61) = O2S(:,:,60);
O2E(:,:,61) = O2E(:,:,60);
O2W(:,:,61) = O2W(:,:,60);

fprintf('O2N has %g NaNs \n',sum(sum(sum(isnan(O2N)))));
fprintf('O2S has %g NaNs \n',sum(sum(sum(isnan(O2S)))));
fprintf('O2E has %g NaNs \n',sum(sum(sum(isnan(O2E)))));
fprintf('O2W has %g NaNs \n',sum(sum(sum(isnan(O2W)))));

fid = fopen('O2_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,O2N,'single');
fclose(fid);

fid = fopen('O2_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,O2S,'single');
fclose(fid);

fid = fopen('O2_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,O2E,'single');
fclose(fid);

fid = fopen('O2_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,O2W,'single');
fclose(fid);

clear O2*
%% end O2

%% NO3
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_NO3.nc';

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



NO3_temp = ncread(str,'TRAC04',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        NO3_temp_temp = NO3_temp(:,:,jj,ii);
        NO3_temp_temp(hFacC(:,:,jj)==0) = NaN;
        NO3_temp_temp = fillmissingstan(NO3_temp_temp);
        NO3_temp(:,:,jj,ii) = NO3_temp_temp;
    end
end
NO3 = zeros(192,132,52,61);

fprintf('NO3 grid = [%g,%g]x[%g,%g] \n NO3 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,NO3_temp(:,:,ii,jj),'linear');
        NO3(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = NO3(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of NO3 mistakes = %g \n',num_mistakes)

NO3N = NO3(:,127,:,:);
NO3S = NO3(:,6,:,:);
NO3E = NO3(187,:,:,:);
NO3W = NO3(6,:,:,:);
for ii=1:5
    NO3N(ii,:,:,:) = NO3N(6,:,:,:);
    NO3N(187+ii,:,:,:) = NO3N(187,:,:,:);
    NO3S(ii,:,:,:) = NO3S(6,:,:,:);
    NO3S(187+ii,:,:,:) = NO3S(187,:,:,:);
    NO3E(:,ii,:,:) = NO3E(:,6,:,:);
    NO3E(:,127+ii,:,:) = NO3E(:,127,:,:);
    NO3W(:,ii,:,:) = NO3W(:,6,:,:);
    NO3W(:,127+ii,:,:) = NO3W(:,127,:,:);
end

NO3N = squeeze(NO3N);
NO3S = squeeze(NO3S);
NO3E = squeeze(NO3E);
NO3W = squeeze(NO3W);
NO3N(:,:,61) = NO3N(:,:,60);
NO3S(:,:,61) = NO3S(:,:,60);
NO3E(:,:,61) = NO3E(:,:,60);
NO3W(:,:,61) = NO3W(:,:,60);

fprintf('NO3N has %g NaNs \n',sum(sum(sum(isnan(NO3N)))));
fprintf('NO3S has %g NaNs \n',sum(sum(sum(isnan(NO3S)))));
fprintf('NO3E has %g NaNs \n',sum(sum(sum(isnan(NO3E)))));
fprintf('NO3W has %g NaNs \n',sum(sum(sum(isnan(NO3W)))));

fid = fopen('NO3_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,NO3N,'single');
fclose(fid);

fid = fopen('NO3_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,NO3S,'single');
fclose(fid);

fid = fopen('NO3_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,NO3E,'single');
fclose(fid);

fid = fopen('NO3_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,NO3W,'single');
fclose(fid);

clear NO3*
%% end NO3

%% PO4
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_PO4.nc';

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



PO4_temp = ncread(str,'TRAC05',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        PO4_temp_temp = PO4_temp(:,:,jj,ii);
        PO4_temp_temp(hFacC(:,:,jj)==0) = NaN;
        PO4_temp_temp = fillmissingstan(PO4_temp_temp);
        PO4_temp(:,:,jj,ii) = PO4_temp_temp;
    end
end
PO4 = zeros(192,132,52,61);

fprintf('PO4 grid = [%g,%g]x[%g,%g] \n PO4 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,PO4_temp(:,:,ii,jj),'linear');
        PO4(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = PO4(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of PO4 mistakes = %g \n',num_mistakes)

PO4N = PO4(:,127,:,:);
PO4S = PO4(:,6,:,:);
PO4E = PO4(187,:,:,:);
PO4W = PO4(6,:,:,:);
for ii=1:5
    PO4N(ii,:,:,:) = PO4N(6,:,:,:);
    PO4N(187+ii,:,:,:) = PO4N(187,:,:,:);
    PO4S(ii,:,:,:) = PO4S(6,:,:,:);
    PO4S(187+ii,:,:,:) = PO4S(187,:,:,:);
    PO4E(:,ii,:,:) = PO4E(:,6,:,:);
    PO4E(:,127+ii,:,:) = PO4E(:,127,:,:);
    PO4W(:,ii,:,:) = PO4W(:,6,:,:);
    PO4W(:,127+ii,:,:) = PO4W(:,127,:,:);
end

PO4N = squeeze(PO4N);
PO4S = squeeze(PO4S);
PO4E = squeeze(PO4E);
PO4W = squeeze(PO4W);
PO4N(:,:,61) = PO4N(:,:,60);
PO4S(:,:,61) = PO4S(:,:,60);
PO4E(:,:,61) = PO4E(:,:,60);
PO4W(:,:,61) = PO4W(:,:,60);

fprintf('PO4N has %g NaNs \n',sum(sum(sum(isnan(PO4N)))));
fprintf('PO4S has %g NaNs \n',sum(sum(sum(isnan(PO4S)))));
fprintf('PO4E has %g NaNs \n',sum(sum(sum(isnan(PO4E)))));
fprintf('PO4W has %g NaNs \n',sum(sum(sum(isnan(PO4W)))));

fid = fopen('PO4_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,PO4N,'single');
fclose(fid);

fid = fopen('PO4_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,PO4S,'single');
fclose(fid);

fid = fopen('PO4_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,PO4E,'single');
fclose(fid);

fid = fopen('PO4_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,PO4W,'single');
fclose(fid);

clear PO4*
%% end PO4

%% FE
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Fe.nc';

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



FE_temp = ncread(str,'TRAC06',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        FE_temp_temp = FE_temp(:,:,jj,ii);
        FE_temp_temp(hFacC(:,:,jj)==0) = NaN;
        FE_temp_temp = fillmissingstan(FE_temp_temp);
        FE_temp(:,:,jj,ii) = FE_temp_temp;
    end
end
FE = zeros(192,132,52,61);

fprintf('FE grid = [%g,%g]x[%g,%g] \n FE nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,FE_temp(:,:,ii,jj),'linear');
        FE(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = FE(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of FE mistakes = %g \n',num_mistakes)

FEN = FE(:,127,:,:);
FES = FE(:,6,:,:);
FEE = FE(187,:,:,:);
FEW = FE(6,:,:,:);
for ii=1:5
    FEN(ii,:,:,:) = FEN(6,:,:,:);
    FEN(187+ii,:,:,:) = FEN(187,:,:,:);
    FES(ii,:,:,:) = FES(6,:,:,:);
    FES(187+ii,:,:,:) = FES(187,:,:,:);
    FEE(:,ii,:,:) = FEE(:,6,:,:);
    FEE(:,127+ii,:,:) = FEE(:,127,:,:);
    FEW(:,ii,:,:) = FEW(:,6,:,:);
    FEW(:,127+ii,:,:) = FEW(:,127,:,:);
end

FEN = squeeze(FEN);
FES = squeeze(FES);
FEE = squeeze(FEE);
FEW = squeeze(FEW);
FEN(:,:,61) = FEN(:,:,60);
FES(:,:,61) = FES(:,:,60);
FEE(:,:,61) = FEE(:,:,60);
FEW(:,:,61) = FEW(:,:,60);

fprintf('FEN has %g NaNs \n',sum(sum(sum(isnan(FEN)))));
fprintf('FES has %g NaNs \n',sum(sum(sum(isnan(FES)))));
fprintf('FEE has %g NaNs \n',sum(sum(sum(isnan(FEE)))));
fprintf('FEW has %g NaNs \n',sum(sum(sum(isnan(FEW)))));

fid = fopen('FE_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,FEN,'single');
fclose(fid);

fid = fopen('FE_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,FES,'single');
fclose(fid);

fid = fopen('FE_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,FEE,'single');
fclose(fid);

fid = fopen('FE_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,FEW,'single');
fclose(fid);

clear FE*
%% end FE

%% DON
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_DON.nc';

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



DON_temp = ncread(str,'TRAC07',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        DON_temp_temp = DON_temp(:,:,jj,ii);
        DON_temp_temp(hFacC(:,:,jj)==0) = NaN;
        DON_temp_temp = fillmissingstan(DON_temp_temp);
        DON_temp(:,:,jj,ii) = DON_temp_temp;
    end
end
DON = zeros(192,132,52,61);

fprintf('DON grid = [%g,%g]x[%g,%g] \n DON nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,DON_temp(:,:,ii,jj),'linear');
        DON(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = DON(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of DON mistakes = %g \n',num_mistakes)

DONN = DON(:,127,:,:);
DONS = DON(:,6,:,:);
DONE = DON(187,:,:,:);
DONW = DON(6,:,:,:);
for ii=1:5
    DONN(ii,:,:,:) = DONN(6,:,:,:);
    DONN(187+ii,:,:,:) = DONN(187,:,:,:);
    DONS(ii,:,:,:) = DONS(6,:,:,:);
    DONS(187+ii,:,:,:) = DONS(187,:,:,:);
    DONE(:,ii,:,:) = DONE(:,6,:,:);
    DONE(:,127+ii,:,:) = DONE(:,127,:,:);
    DONW(:,ii,:,:) = DONW(:,6,:,:);
    DONW(:,127+ii,:,:) = DONW(:,127,:,:);
end

DONN = squeeze(DONN);
DONS = squeeze(DONS);
DONE = squeeze(DONE);
DONW = squeeze(DONW);
DONN(:,:,61) = DONN(:,:,60);
DONS(:,:,61) = DONS(:,:,60);
DONE(:,:,61) = DONE(:,:,60);
DONW(:,:,61) = DONW(:,:,60);

fprintf('DONN has %g NaNs \n',sum(sum(sum(isnan(DONN)))));
fprintf('DONS has %g NaNs \n',sum(sum(sum(isnan(DONS)))));
fprintf('DONE has %g NaNs \n',sum(sum(sum(isnan(DONE)))));
fprintf('DONW has %g NaNs \n',sum(sum(sum(isnan(DONW)))));

fid = fopen('DON_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DONN,'single');
fclose(fid);

fid = fopen('DON_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DONS,'single');
fclose(fid);

fid = fopen('DON_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DONE,'single');
fclose(fid);

fid = fopen('DON_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DONW,'single');
fclose(fid);

clear DON*
%% end DON

%% DOP
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_DOP.nc';

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



DOP_temp = ncread(str,'TRAC08',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        DOP_temp_temp = DOP_temp(:,:,jj,ii);
        DOP_temp_temp(hFacC(:,:,jj)==0) = NaN;
        DOP_temp_temp = fillmissingstan(DOP_temp_temp);
        DOP_temp(:,:,jj,ii) = DOP_temp_temp;
    end
end
DOP = zeros(192,132,52,61);

fprintf('DOP grid = [%g,%g]x[%g,%g] \n DOP nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,DOP_temp(:,:,ii,jj),'linear');
        DOP(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = DOP(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of DOP mistakes = %g \n',num_mistakes)

DOPN = DOP(:,127,:,:);
DOPS = DOP(:,6,:,:);
DOPE = DOP(187,:,:,:);
DOPW = DOP(6,:,:,:);
for ii=1:5
    DOPN(ii,:,:,:) = DOPN(6,:,:,:);
    DOPN(187+ii,:,:,:) = DOPN(187,:,:,:);
    DOPS(ii,:,:,:) = DOPS(6,:,:,:);
    DOPS(187+ii,:,:,:) = DOPS(187,:,:,:);
    DOPE(:,ii,:,:) = DOPE(:,6,:,:);
    DOPE(:,127+ii,:,:) = DOPE(:,127,:,:);
    DOPW(:,ii,:,:) = DOPW(:,6,:,:);
    DOPW(:,127+ii,:,:) = DOPW(:,127,:,:);
end

DOPN = squeeze(DOPN);
DOPS = squeeze(DOPS);
DOPE = squeeze(DOPE);
DOPW = squeeze(DOPW);
DOPN(:,:,61) = DOPN(:,:,60);
DOPS(:,:,61) = DOPS(:,:,60);
DOPE(:,:,61) = DOPE(:,:,60);
DOPW(:,:,61) = DOPW(:,:,60);

fprintf('DOPN has %g NaNs \n',sum(sum(sum(isnan(DOPN)))));
fprintf('DOPS has %g NaNs \n',sum(sum(sum(isnan(DOPS)))));
fprintf('DOPE has %g NaNs \n',sum(sum(sum(isnan(DOPE)))));
fprintf('DOPW has %g NaNs \n',sum(sum(sum(isnan(DOPW)))));

fid = fopen('DOP_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DOPN,'single');
fclose(fid);

fid = fopen('DOP_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DOPS,'single');
fclose(fid);

fid = fopen('DOP_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DOPE,'single');
fclose(fid);

fid = fopen('DOP_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,DOPW,'single');
fclose(fid);

clear DOP*
%% end DOP

%% THETA
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Theta.nc';

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



THETA_temp = ncread(str,'THETA',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        THETA_temp_temp = THETA_temp(:,:,jj,ii);
        THETA_temp_temp(hFacC(:,:,jj)==0) = NaN;
        THETA_temp_temp = fillmissingstan(THETA_temp_temp);
        THETA_temp(:,:,jj,ii) = THETA_temp_temp;
    end
end
THETA = zeros(192,132,52,61);

fprintf('THETA grid = [%g,%g]x[%g,%g] \n DOP nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,THETA_temp(:,:,ii,jj),'linear');
        THETA(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = THETA(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of THETA mistakes = %g \n',num_mistakes)

THETAN = THETA(:,127,:,:);
THETAS = THETA(:,6,:,:);
THETAE = THETA(187,:,:,:);
THETAW = THETA(6,:,:,:);
for ii=1:5
    THETAN(ii,:,:,:) = THETAN(6,:,:,:);
    THETAN(187+ii,:,:,:) = THETAN(187,:,:,:);
    THETAS(ii,:,:,:) = THETAS(6,:,:,:);
    THETAS(187+ii,:,:,:) = THETAS(187,:,:,:);
    THETAE(:,ii,:,:) = THETAE(:,6,:,:);
    THETAE(:,127+ii,:,:) = THETAE(:,127,:,:);
    THETAW(:,ii,:,:) = THETAW(:,6,:,:);
    THETAW(:,127+ii,:,:) = THETAW(:,127,:,:);
end

THETAN = squeeze(THETAN);
THETAS = squeeze(THETAS);
THETAE = squeeze(THETAE);
THETAW = squeeze(THETAW);
THETAN(:,:,61) = THETAN(:,:,60);
THETAS(:,:,61) = THETAS(:,:,60);
THETAE(:,:,61) = THETAE(:,:,60);
THETAW(:,:,61) = THETAW(:,:,60);

fprintf('THETAN has %g NaNs \n',sum(sum(sum(isnan(THETAN)))));
fprintf('THETAS has %g NaNs \n',sum(sum(sum(isnan(THETAS)))));
fprintf('THETAE has %g NaNs \n',sum(sum(sum(isnan(THETAE)))));
fprintf('THETAW has %g NaNs \n',sum(sum(sum(isnan(THETAW)))));

fid = fopen('THETA_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,THETAN,'single');
fclose(fid);

fid = fopen('THETA_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,THETAS,'single');
fclose(fid);

fid = fopen('THETA_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,THETAE,'single');
fclose(fid);

fid = fopen('THETA_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,THETAW,'single');
fclose(fid);

clear THETA*
%% end THETA


%% SALT
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Salt.nc';

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



SALT_temp = ncread(str,'SALT',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        SALT_temp_temp = SALT_temp(:,:,jj,ii);
        SALT_temp_temp(hFacC(:,:,jj)==0) = NaN;
        SALT_temp_temp = fillmissingstan(SALT_temp_temp);
        SALT_temp(:,:,jj,ii) = SALT_temp_temp;
    end
end
SALT = zeros(192,132,52,61);

fprintf('SALT grid = [%g,%g]x[%g,%g] \n SALT nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,SALT_temp(:,:,ii,jj),'linear');
        SALT(:,:,ii,jj) = F(XC3,YC3);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = SALT(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of SALT mistakes = %g \n',num_mistakes)

SALTN = SALT(:,127,:,:);
SALTS = SALT(:,6,:,:);
SALTE = SALT(187,:,:,:);
SALTW = SALT(6,:,:,:);
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
SALTN(:,:,61) = SALTN(:,:,60);
SALTS(:,:,61) = SALTS(:,:,60);
SALTE(:,:,61) = SALTE(:,:,60);
SALTW(:,:,61) = SALTW(:,:,60);

fprintf('SALTN has %g NaNs \n',sum(sum(sum(isnan(SALTN)))));
fprintf('SALTS has %g NaNs \n',sum(sum(sum(isnan(SALTS)))));
fprintf('SALTE has %g NaNs \n',sum(sum(sum(isnan(SALTE)))));
fprintf('SALTW has %g NaNs \n',sum(sum(sum(isnan(SALTW)))));

fid = fopen('SALT_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,SALTN,'single');
fclose(fid);

fid = fopen('SALT_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,SALTS,'single');
fclose(fid);

fid = fopen('SALT_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,SALTE,'single');
fclose(fid);

fid = fopen('SALT_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,SALTW,'single');
fclose(fid);

clear SALT*
%% end SALT

%% UVEL
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Uvel.nc';

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



UVEL_temp = ncread(str,'UVEL',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        UVEL_temp_temp = UVEL_temp(:,:,jj,ii);
        UVEL_temp_temp(hFacW(:,:,jj)==0) = NaN;
        UVEL_temp_temp = fillmissingstan(UVEL_temp_temp);
        UVEL_temp(:,:,jj,ii) = UVEL_temp_temp;
    end
end
UVEL = zeros(192,132,52,61);

fprintf('UVEL grid = [%g,%g]x[%g,%g] \n UVEL nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,UVEL_temp(:,:,ii,jj),'linear');
        UVEL(:,:,ii,jj) = F(XU,YU);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = UVEL(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of UVEL mistakes = %g \n',num_mistakes)

UVELN = UVEL(:,127,:,:);
UVELS = UVEL(:,6,:,:);
UVELE = UVEL(187,:,:,:);
UVELW = UVEL(6,:,:,:);
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
UVELN(:,:,61) = UVELN(:,:,60);
UVELS(:,:,61) = UVELS(:,:,60);
UVELE(:,:,61) = UVELE(:,:,60);
UVELW(:,:,61) = UVELW(:,:,60);

fprintf('UVELN has %g NaNs \n',sum(sum(sum(isnan(UVELN)))));
fprintf('UVELS has %g NaNs \n',sum(sum(sum(isnan(UVELS)))));
fprintf('UVELE has %g NaNs \n',sum(sum(sum(isnan(UVELE)))));
fprintf('UVELW has %g NaNs \n',sum(sum(sum(isnan(UVELW)))));

fid = fopen('UVEL_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,UVELN,'single');
fclose(fid);

fid = fopen('UVEL_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,UVELS,'single');
fclose(fid);

fid = fopen('UVEL_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,UVELE,'single');
fclose(fid);

fid = fopen('UVEL_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,UVELW,'single');
fclose(fid);

clear UVEL*
%% end UVEL

%% VVEL
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_monthly_Vvel.nc';

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



VVEL_temp = ncread(str,'VVEL',[lox,loy,1,1],[nn,mm,52,60]);
for ii=1:60
    for jj=1:52
        VVEL_temp_temp = VVEL_temp(:,:,jj,ii);
        VVEL_temp_temp(hFacS(:,:,jj)==0) = NaN;
        VVEL_temp_temp = fillmissingstan(VVEL_temp_temp);
        VVEL_temp(:,:,jj,ii) = VVEL_temp_temp;
    end
end
VVEL = zeros(192,132,52,61);

fprintf('VVEL grid = [%g,%g]x[%g,%g] \n VVEL nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:60
        F = griddedInterpolant(XCS,YCS,VVEL_temp(:,:,ii,jj),'linear');
        VVEL(:,:,ii,jj) = F(XV,YV);
    end
end

num_mistakes = 0;
for kk=1:60
    Logic = VVEL(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[192*132*52,1]));
end
fprintf('number of VVEL mistakes = %g \n',num_mistakes)

VVELN = VVEL(:,127,:,:);
VVELS = VVEL(:,6,:,:);
VVELE = VVEL(187,:,:,:);
VVELW = VVEL(6,:,:,:);
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
VVELN(:,:,61) = VVELN(:,:,60);
VVELS(:,:,61) = VVELS(:,:,60);
VVELE(:,:,61) = VVELE(:,:,60);
VVELW(:,:,61) = VVELW(:,:,60);

fprintf('VVELN has %g NaNs \n',sum(sum(sum(isnan(VVELN)))));
fprintf('VVELS has %g NaNs \n',sum(sum(sum(isnan(VVELS)))));
fprintf('VVELE has %g NaNs \n',sum(sum(sum(isnan(VVELE)))));
fprintf('VVELW has %g NaNs \n',sum(sum(sum(isnan(VVELW)))));

fid = fopen('VVEL_NBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,VVELN,'single');
fclose(fid);

fid = fopen('VVEL_SBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,VVELS,'single');
fclose(fid);

fid = fopen('VVEL_EBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,VVELE,'single');
fclose(fid);

fid = fopen('VVEL_WBC_2013to2017_monthly_3.bin','w','b');
fwrite(fid,VVELW,'single');
fclose(fid);

clear VVEL*
%% end VVEL


