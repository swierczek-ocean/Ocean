

%% DOP
str = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013tDOP017_5day_DOP.nc';
jj = 300;

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

DOP_temp = ncread(str,'TRAC08',[lox,loy,1,jj],[363,244,52,1]);

for jj=1:52
    DOP_temp_temp = DOP_temp(:,:,jj);
    DOP_temp_temp(hFacC(:,:,jj)==0) = NaN;
    DOP_temp_temp = fillmissingstan(DOP_temp_temp);
    DOP_temp(:,:,jj) = DOP_temp_temp;
end
DOP = zeros(192,132,52);

for ii=1:52
    F = griddedInterpolant(XCS,YCS,DOP_temp(:,:,ii),'linear');
    DOP(:,:,ii) = F(XC3,YC3);
end

Logic = DOP==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DOP mistakes = %g \n',num_mistakes)

for ii=1:5
    DOP(ii,6:127,:) = DOP(6,6:127,:); 
    DOP(6:187,ii,:) = DOP(6:187,6,:);
    DOP(187+ii,6:127,:) = DOP(187,6:127,:); 
    DOP(6:187,127+ii,:) = DOP(6:187,127,:);
end

Logic = DOP==0&HC~=0;
num_mistakes = sum(reshape(Logic,[192*132*52,1]));
fprintf('number of DOP mistakes = %g \n',num_mistakes)

fid = fopen('DOP_init_restr_20161216.bin','w','b');
fwrite(fid,DOP,'single');
fclose(fid);

clear DOP*
%% DOP

