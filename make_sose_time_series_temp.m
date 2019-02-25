%% BottomPres
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_BottomPres.nc';
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

BottomPres_temp = ncread(str,'BottomPres',[lox,loy,sd],[385,263,nd]);

for jj=1:nd
    BottomPres_temp_temp = BottomPres_temp(:,:,jj);
    BottomPres_temp_temp(hFacC(:,:,jj)==0) = NaN;
    BottomPres_temp_temp = fillmissingstan(BottomPres_temp_temp);
    BottomPres_temp(:,:,jj) = BottomPres_temp_temp;
end
BottomPres = zeros(192,132,nd);

for ii=1:nd
    F = griddedInterpolant(XCS,YCS,BottomPres_temp(:,:,ii),'linear');
    BottomPres(:,:,ii) = F(XC3,YC3);
end

BottomPres = BottomPres(6:187,6:127,:);

fid = fopen('BottomPres_bsose_ts.bin','w','b');
fwrite(fid,BottomPres,'single');
fclose(fid);

clear BottomPres*
%% BottomPres