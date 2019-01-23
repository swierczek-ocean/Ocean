tic()
clc
clear
close all

NX = 1080;
NY = 315;
NZ = 52;

%% DIC
time = ncread('bsose_i121_2013to2017_monthly_DIC.nc','time');
XCD = ncread('bsose_i121_2013to2017_monthly_DIC.nc','XC');
YCD = ncread('bsose_i121_2013to2017_monthly_DIC.nc','YC');
DIC = ncread('bsose_i121_2013to2017_monthly_DIC.nc','TRAC01');

X = XCD;
Y = YCD;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('DIC grid = [%g,%g]x[%g,%g] \n DIC nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


DICN = DIC(lox:hix,YY,:,:);
DICS = DIC(lox:hix,loy+5,:,:);
DICE = DIC(hix-5,loy:hiy,:,:);
DICW = DIC(loy+5,loy:hiy,:,:);
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

fid = fopen('DIC_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DICN,'single');
fclose(fid);

fid = fopen('DIC_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DICS,'single');
fclose(fid);

fid = fopen('DIC_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DICE,'single');
fclose(fid);

fid = fopen('DIC_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DICW,'single');
fclose(fid);

clear DIC*
%% end DIC


%% ALK
time = ncread('bsose_i121_2013to2017_monthly_Alk.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_Alk.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_Alk.nc','YC');
ALK = ncread('bsose_i121_2013to2017_monthly_Alk.nc','TRAC02');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('ALK grid = [%g,%g]x[%g,%g] \n ALK nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


ALKN = ALK(lox:hix,YY,:,:);
ALKS = ALK(lox:hix,loy+5,:,:);
ALKE = ALK(hix-5,loy:hiy,:,:);
ALKW = ALK(loy+5,loy:hiy,:,:);
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

fid = fopen('ALK_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,ALKN,'single');
fclose(fid);

fid = fopen('ALK_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,ALKS,'single');
fclose(fid);

fid = fopen('ALK_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,ALKE,'single');
fclose(fid);

fid = fopen('ALK_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,ALKW,'single');
fclose(fid);

clear ALK*
%% end ALK

%% O2
time = ncread('bsose_i121_2013to2017_monthly_O2.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_O2.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_O2.nc','YC');
O2 = ncread('bsose_i121_2013to2017_monthly_O2.nc','TRAC03');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('O2 grid = [%g,%g]x[%g,%g] \n O2 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


O2N = O2(lox:hix,YY,:,:);
O2S = O2(lox:hix,loy+5,:,:);
O2E = O2(hix-5,loy:hiy,:,:);
O2W = O2(loy+5,loy:hiy,:,:);
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

fid = fopen('O2_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,O2N,'single');
fclose(fid);

fid = fopen('O2_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,O2S,'single');
fclose(fid);

fid = fopen('O2_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,O2E,'single');
fclose(fid);

fid = fopen('O2_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,O2W,'single');
fclose(fid);

clear O2*
%% end O2

%% NO3
time = ncread('bsose_i121_2013to2017_monthly_NO3.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_NO3.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_NO3.nc','YC');
NO3 = ncread('bsose_i121_2013to2017_monthly_NO3.nc','TRAC04');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('NO3 grid = [%g,%g]x[%g,%g] \n NO3 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


NO3N = NO3(lox:hix,YY,:,:);
NO3S = NO3(lox:hix,loy+5,:,:);
NO3E = NO3(hix-5,loy:hiy,:,:);
NO3W = NO3(loy+5,loy:hiy,:,:);
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

fid = fopen('NO3_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,NO3N,'single');
fclose(fid);

fid = fopen('NO3_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,NO3S,'single');
fclose(fid);

fid = fopen('NO3_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,NO3E,'single');
fclose(fid);

fid = fopen('NO3_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,NO3W,'single');
fclose(fid);

clear NO3*
%% end NO3

%% PO4
time = ncread('bsose_i121_2013to2017_monthly_PO4.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_PO4.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_PO4.nc','YC');
PO4 = ncread('bsose_i121_2013to2017_monthly_PO4.nc','TRAC05');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('PO4 grid = [%g,%g]x[%g,%g] \n PO4 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


PO4N = PO4(lox:hix,YY,:,:);
PO4S = PO4(lox:hix,loy+5,:,:);
PO4E = PO4(hix-5,loy:hiy,:,:);
PO4W = PO4(loy+5,loy:hiy,:,:);
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

fid = fopen('PO4_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,PO4N,'single');
fclose(fid);

fid = fopen('PO4_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,PO4S,'single');
fclose(fid);

fid = fopen('PO4_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,PO4E,'single');
fclose(fid);

fid = fopen('PO4_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,PO4W,'single');
fclose(fid);

clear PO4*
%% end PO4

%% FE
time = ncread('bsose_i121_2013to2017_monthly_Fe.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_Fe.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_Fe.nc','YC');
FE = ncread('bsose_i121_2013to2017_monthly_Fe.nc','TRAC06');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('FE grid = [%g,%g]x[%g,%g] \n FE nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


FEN = FE(lox:hix,YY,:,:);
FES = FE(lox:hix,loy+5,:,:);
FEE = FE(hix-5,loy:hiy,:,:);
FEW = FE(loy+5,loy:hiy,:,:);
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

fid = fopen('FE_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,FEN,'single');
fclose(fid);

fid = fopen('FE_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,FES,'single');
fclose(fid);

fid = fopen('FE_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,FEE,'single');
fclose(fid);

fid = fopen('FE_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,FEW,'single');
fclose(fid);

clear FE*
%% end FE

%% DON
time = ncread('bsose_i121_2013to2017_monthly_DON.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_DON.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_DON.nc','YC');
DON = ncread('bsose_i121_2013to2017_monthly_DON.nc','TRAC07');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('DON grid = [%g,%g]x[%g,%g] \n DON nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


DONN = DON(lox:hix,YY,:,:);
DONS = DON(lox:hix,loy+5,:,:);
DONE = DON(hix-5,loy:hiy,:,:);
DONW = DON(loy+5,loy:hiy,:,:);
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

fid = fopen('DON_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DONN,'single');
fclose(fid);

fid = fopen('DON_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DONS,'single');
fclose(fid);

fid = fopen('DON_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DONE,'single');
fclose(fid);

fid = fopen('DON_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DONW,'single');
fclose(fid);

clear DON*
%% end DON

%% DOP
time = ncread('bsose_i121_2013to2017_monthly_DOP.nc','time');
XCS = ncread('bsose_i121_2013to2017_monthly_DOP.nc','XC');
YCS = ncread('bsose_i121_2013to2017_monthly_DOP.nc','YC');
DOP = ncread('bsose_i121_2013to2017_monthly_DOP.nc','TRAC08');

X = XCS;
Y = YCS;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
YY = find(Y>-32.1,1);


fprintf('DOP grid = [%g,%g]x[%g,%g] \n DOP nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


DOPN = DOP(lox:hix,YY,:,:);
DOPS = DOP(lox:hix,loy+5,:,:);
DOPE = DOP(hix-5,loy:hiy,:,:);
DOPW = DOP(loy+5,loy:hiy,:,:);
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

fid = fopen('DOP_NBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DOPN,'single');
fclose(fid);

fid = fopen('DOP_SBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DOPS,'single');
fclose(fid);

fid = fopen('DOP_EBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DOPE,'single');
fclose(fid);

fid = fopen('DOP_WBC_2013to2017_monthly.bin','w','b');
fwrite(fid,DOPW,'single');
fclose(fid);

clear DOP*
%% end DOP





