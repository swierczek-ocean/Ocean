clear all
close all

justwritetotile = 1 
justS = 0

if ~justwritetotile

%LOAD IN 1/6 GRID
load /net/mazdata1/mmazloff/SOSE/GRID/grid XC XG YC YG RC
xc6 = XC(:,1);xg6 = XG(:,1);
yc6 = YC(1,:);yg6 = YG(1,:);
rc6 = RC;
clear XC YC XG YG RC

%NOW LOAD IN OCCA GRID
odir = '/net/shared_data/OCCA_r2/'
tmp = rdmds([odir 'GRID/XC']); 
[NXO NYO] = size(tmp);
xco = tmp(:,1);
tmp = rdmds([odir 'GRID/XG']); xgo = tmp(:,1);
tmp = rdmds([odir 'GRID/YC']); yco = tmp(1,:);
tmp = rdmds([odir 'GRID/YG']); ygo = tmp(1,:);
tmp    = rdmds([odir 'GRID/RC']); rco = squeeze(tmp); clear tmp;

%MAKE HORIZONTAL GRID
XC = 1/24:1/12:360;
XG = 0:1/12:(360-1/24);
YG(1) = -78;
DYG(1) = 1/12*cosd(YG(1)); %ISOPTROPIC
DYG(1) = 1/12*cosd(YG(1)+DYG(1)/2);%adjust
j = 1;
while YG<-30 %KEEP ISOTROPIC OUT TO 30S
    j = j+1;
    YG(j) = YG(j-1)+DYG(j-1);
    DYG(j) = 1/12*cosd(YG(j)+DYG(j-1)/2);
    DYG(j) = 1/12*cosd(YG(j)+DYG(j)/2); %adjust
end
while DYG<.5  %now stretch to .5 degree in y
    j = j+1;
    YG(j) = YG(j-1)+DYG(j-1);
    DYG(j) = DYG(j-1)*1.05; %stretch  
end
for  j = (j-1):1260
    YG(j) = YG(j-1)+DYG(j-1);
    DYG(j) = 0.5;
end
YG(j+1) = YG(j)+DYG(j);
YC = (YG(1:end-1) + YG(2:end))./2;
YG(end) = [];

NX = length(XC);
NY = length(YC);
%GRID SIZE IS 4320  X 1260 
%TILE SIZE IS 45x45
%PROC IS
%1/12: 96 X 28 = 2688 (16*168)
%1/6:  48 X 14 = 672  (16* 42)
%1/3:  24 X  7 = 168  (14* 12)

%Actually stop mapping at
%1/12: j = 1254:1260 is sponge
%1/6:  j = 627:630 is sponge
%1/3:  j = 314:315 is sponge

%NOW MAKE VERTICAL GRID
Z(1:11) =[ 2 4.2 6.6 9.2 12 15.1  18.4 22 26 30.5 35]
Z(12:32) = 40:5:140;
Z(33:36) = [146 153 161 170 ];
Z(37:49) = 180:10:300;
Z(50:56) = [312 326 342 360 380 402 425];
Z(57:61) = 450:25:550;
Z(62:64) = [578 610 650];
Z(65:73) = [700:50:1100];
Z(74:76) = [1150 1215 1300]; %THIS could be spread better
Z(77:83) = [1400:100:2000];
Z(84:87) = [2120 2260 2420 2600];
Z(88:104) = [2800:200:6000];
RF = [0 Z];
DZF = diff(RF)
RC = -(RF(1:end-1) + RF(2:end))./2;
%DZF_LOW = DZF([1:2:end]) + DZF([2:2:end]);
%RF_LOW = cumsum(DZF_LOW);
NZ = length(RC);

if 1 % if 1 do TSUV, else do ice
%NOW INTERP TO THIS
%FIRST READ IN OCCA
%SAVE OCCA MAX AND MIN FOR TO CAP
Tmin = 99; Smin = 99; Tmax = -99; Smax = -99;
if justS == 0
fidin1 =  fopen([odir 'DDtheta0407daily.data'],'r','b');
fidin3 =  fopen([odir 'DDuvel0407daily.data'],'r','b');
fidin4 =  fopen([odir 'DDvvel0407daily.data'],'r','b');
end
fidin2 =  fopen([odir 'DDsalt0407daily.data'],'r','b');
  for t = 1:(61+366 - 31) %make dec 2004 first record
    t
    Qin2 = fread(fidin2,360*160*50,'single');
%USE THIS ONE YEAR TO GET MAX MIN S AND T
    Qin2(Qin2==0)=nan;
    Smin = min([min(Qin2),Smin]);
    Smax = max([max(Qin2),Smax]);
if justS == 0
    Qin1 = fread(fidin1,360*160*50,'single');
    Qin1(Qin1==0)=nan;
    Tmin = min([min(Qin1),Tmin]);
    Tmax = max([max(Qin1),Tmax]);
    Qin3 = fread(fidin3,360*160*50,'single');
    Qin4 = fread(fidin4,360*160*50,'single');
end
  end
  %NOW AVERAGE DEC AND JAN TO GET A JAN 1 FIELD
  Qin2 = Qin2*0;  
if justS == 0
  Qin1 = Qin1*0; Qin3 = Qin3*0;  Qin4 = Qin4*0;
end
  for t = 1:(62) %make dec 2004 first record
    62 - t
if justS == 0
    Qin1 = Qin1 + fread(fidin1,360*160*50,'single');
    Qin3 = Qin3 + fread(fidin3,360*160*50,'single');
    Qin4 = Qin4 + fread(fidin4,360*160*50,'single');
end
    Qin2 = Qin2 + fread(fidin2,360*160*50,'single');
  end
  Qin2 = Qin2/62;
if justS == 0
  Qin1 = Qin1/62;    Qin3 = Qin3/62;  Qin4 = Qin4/62;
end
  Socca = reshape(Qin2,[360,160,50]);
if justS == 0
  Tocca = reshape(Qin1,[360,160,50]);
  Uocca = reshape(Qin3,[360,160,50]);
  Vocca = reshape(Qin4,[360,160,50]);
end
  clear Qin*
%NOW READ IN SO6
idir = '/net/mazdata1/mmazloff/SOSE/SO6input/ICs/';
fid = fopen([idir 'Sini_SO6_2005to12.bin'],'r','b');
S6 = fread(fid,inf,'single');fclose(fid)
S6 = reshape(S6,[2160,320,42]);
if justS == 0
fid = fopen([idir 'Tini_SO6_2005to12.bin'],'r','b');
T6 = fread(fid,inf,'single');fclose(fid)
T6 = reshape(T6,[2160,320,42]);
fid = fopen([idir 'Uini_SO6_2005to12.bin'],'r','b');
U6 = fread(fid,inf,'single');fclose(fid)
U6 = reshape(U6,[2160,320,42]);
fid = fopen([idir 'Vini_SO6_2005to12.bin'],'r','b');
V6 = fread(fid,inf,'single');fclose(fid)
V6 = reshape(V6,[2160,320,42]);
end

%INTERP OCCA VERTICALLY
Q1 = zeros(360,160,length(RC));
Q2 = Q1;Q3=Q1;Q4=Q1;
tmprco1 = [rco; 6100]
for j = 1:160
  160-j
  for i = 1:360
    tmp = squeeze(Socca(i,j,:));
    I = find(tmp~=0);
    if length(I)>1
      tmprco2 = [0; rco(I); tmprco1(max(I)+1)];
      tmp = interp1(rco(I),tmp(I),tmprco2,'linear','extrap');
      %extrap is necessary now that have increased res in surface layer
      Q2(i,j,:) = interp1(tmprco2,tmp,RC);
if justS == 0
      tmp = squeeze(Tocca(i,j,:));%I = find(tmp~=0);
      tmp = interp1(rco(I),tmp(I),tmprco2,'linear','extrap');
      Q1(i,j,:) = interp1(tmprco2,tmp,RC);
%NOW U and V
      tmp = squeeze(Uocca(i,j,:));%     I = find(tmp~=0);
   %   if length(I)>1
   %   tmp = interp1(rco(I),tmp(I),[0; rco],'linear','extrap');
      tmp = interp1(rco,tmp,[0; rco],'linear','extrap');
      Q3(i,j,:) = interp1([0; rco],tmp,RC);
   %   end
      tmp = squeeze(Vocca(i,j,:));   %  I = find(tmp~=0);
   %   if length(I)>1
   %     tmp = interp1(rco(I),tmp(I),[0; rco],'linear','extrap');
      tmp = interp1(rco,tmp,[0; rco],'linear','extrap');
      Q4(i,j,:) = interp1([0; rco],tmp,RC);
   %   end
end
    end
  end
end

%NOW LAYER BY LAYER GET RID OF ZEROS IN T AND S
Socca = Q2*nan;
if justS == 0
Tocca = Socca;Uocca = Q3;Vocca = Q4;
end
for ifil = 1:3
for k = 1:NZ
    NZ - k
if justS == 0
    Tocca(:,:,k) = fillininils(360,160,Q1(:,:,k),[15,7],1);
end
    Socca(:,:,k) = fillininils(360,160,Q2(:,:,k),[15,7],1);  
end 
end

%NEED TO NAN OUT VALUES SO ZEROS DONT INTERP
Socca(Socca==0)=nan;
if justS == 0
Tocca(Tocca==0)=nan;
Uocca(Uocca==0)=nan;
Vocca(Vocca==0)=nan;
end

%INTERP OCCA HORIZONTALLY
S12a = zeros(NX,NY,NZ,'single');
if justS == 0
T12a = S12a; U12a = T12a; V12a = T12a;
T12b = T12a; S12b = T12a; U12b = T12a; V12b = T12a; 
end
for k = 1:NZ
  NZ - k
  tdx = xco(2) - xco(1);
  S12a(:,:,k) = interp2(yco,[xco(1)-tdx; xco; xco(NXO)+tdx],Socca([NXO 1:NXO 1],:,k),YC',XC);%,'linear','extrap');
if justS == 0 
  T12a(:,:,k) = interp2(yco,[xco(1)-tdx; xco; xco(NXO)+tdx],Tocca([NXO 1:NXO 1],:,k),YC',XC);%,'linear','extrap');
  U12a(:,:,k) = interp2(yco,[xgo(1)-tdx; xgo; xgo(NXO)+tdx],Uocca([NXO 1:NXO 1],:,k),YC',XG);%,'linear','extrap');
  V12a(:,:,k) = interp2(ygo,[xco(1)-tdx; xco; xco(NXO)+tdx],Vocca([NXO 1:NXO 1],:,k),YG',XC);%,'linear','extrap');
end
end

S12a(isnan(S12a))=0;
if justS == 0
T12a(isnan(T12a))=0;
U12a(isnan(U12a))=0;
V12a(isnan(V12a))=0;
end

%INTERP SO6 VERTICALLY
Q1 = zeros(2160,320,length(RC));
Q2 = Q1;Q3=Q1;Q4=Q1;
tmprco1 = [rc6; 6100]
for j = 1:320
  320-j
  for i = 1:2160
    tmp = squeeze(S6(i,j,:));     I = find(tmp~=0);
    if length(I)>1
      tmprco2 = [0; rc6(I); tmprco1(max(I)+1)];      
      tmp = interp1(rc6(I),tmp(I),tmprco2,'linear','extrap');
      Q2(i,j,:) = interp1(tmprco2,tmp,RC);
if justS == 0 
      tmp = squeeze(T6(i,j,:));%I = find(tmp~=0);
      tmp = interp1(rc6(I),tmp(I),tmprco2,'linear','extrap');
      Q1(i,j,:) = interp1(tmprco2,tmp,RC);
%NOW U AND V
      tmp = squeeze(U6(i,j,:));%I = find(tmp~=0);
%      if length(I)>1
%        tmp = interp1(rc6(I),tmp(I),[0; rc6],'linear','extrap');
        tmp = interp1(rc6,tmp,[0; rc6],'linear','extrap');
        Q3(i,j,:) = interp1([0; rc6],tmp,RC);
%      end
      tmp = squeeze(V6(i,j,:));%I = find(tmp~=0);
%      if length(I)>1
%        tmp = interp1(rc6(I),tmp(I),[0; rc6],'linear','extrap');
        tmp = interp1(rc6,tmp,[0; rc6],'linear','extrap');
        Q4(i,j,:) = interp1([0; rc6],tmp,RC);
%      end
end
    end
  end
end
%NOW LAYER BY LAYER GET RID OF ZEROS IN T AND S
clear T6 S6
U6 = Q3;V6 = Q4;
for ifil = 1:3
for k = 1:NZ
    NZ - k
if justS == 0 
    T6(:,:,k) = fillininils(2160,320,Q1(:,:,k),[91,43],1);
end
    S6(:,:,k) = fillininils(2160,320,Q2(:,:,k),[91,43],1);
end
end
%MAKE NANS TO EXPAND
S6(:,321,:) = nan;
if justS == 0 
T6(:,321,:) = nan;
U6(:,321,:) = nan;
V6(:,321,:) = nan;
end
yc6(321) = 10;yg6(321) = 10;

%NEED TO NAN OUT VALUES SO ZEROS DONT INTERP
S6(S6==0)=nan;
if justS == 0
T6(T6==0)=nan;
U6(U6==0)=nan;
V6(V6==0)=nan;
end

%INTERP SO6 HORIZONTALLY
for k = 1:NZ
  NZ - k
  S12b(:,:,k) = interp2(yc6,xc6,S6(:,:,k),YC',XC);%,'linear','extrap');
if justS == 0 
  T12b(:,:,k) = interp2(yc6,xc6,T6(:,:,k),YC',XC);%,'linear','extrap');
  U12b(:,:,k) = interp2(yc6,xg6,U6(:,:,k),YC',XG);%,'linear','extrap');
  V12b(:,:,k) = interp2(yg6,xc6,V6(:,:,k),YG',XC);%,'linear','extrap');
end
end
S12b(isnan(S12b))=0;
if justS == 0 
T12b(isnan(T12b))=0;
U12b(isnan(U12b))=0;
V12b(isnan(V12b))=0;
end

%NOW COMBINE THE TWO BETWEEN 30S and 25S
%YC(1172)=-29.9811
%YC(1202)=-25.2944
N = length(1172:1202);
wt = linspace(0,1,N);
S12 = S12a;
S12(:,1:1171,:) = S12b(:,1:1171,:);
if justS == 0 
  T12 = T12a;
  U12 = U12a;
  V12 = V12a;
  T12(:,1:1171,:) = T12b(:,1:1171,:);
  U12(:,1:1171,:) = U12b(:,1:1171,:);
  V12(:,1:1171,:) = V12b(:,1:1171,:);
end
  for j = 1172:1202
    1202-j
    i = j - 1171
    %REMOVE ZEROS IF ONE HAS AND ONE DOESNT
    tmpa = S12a(:,j,:); tmpb = S12b(:,j,:);
    tmpb(tmpb==0)=tmpa(tmpb==0);
    tmpa(tmpa==0)=tmpb(tmpa==0);
    tmpa(tmpa.*tmpb == 0) = nan; %make nan if both zero
    S12(:,j,:) = tmpa*wt(i) + tmpb*(1-wt(i));
    S12(isnan(S12))=0;
if justS == 0
    tmpa = T12a(:,j,:); tmpb = T12b(:,j,:);
    tmpb(tmpb==0)=tmpa(tmpb==0);
    tmpa(tmpa==0)=tmpb(tmpa==0);
    tmpa(tmpa.*tmpb == 0) = nan; %make nan if both zero
    T12(:,j,:) = tmpa*wt(i) + tmpb*(1-wt(i));
    T12(isnan(T12))=0;
    tmpa = U12a(:,j,:); tmpb = U12b(:,j,:);
    tmpb(tmpb==0)=tmpa(tmpb==0);
    tmpa(tmpa==0)=tmpb(tmpa==0);
    U12(:,j,:) = tmpa*wt(i) + tmpb*(1-wt(i));
    tmpa = V12a(:,j,:); tmpb = V12b(:,j,:);
    tmpb(tmpb==0)=tmpa(tmpb==0);
    tmpa(tmpa==0)=tmpb(tmpa==0);
    V12(:,j,:) = tmpa*wt(i) + tmpb*(1-wt(i));
end
  end

%FILL ZEROS
for ifil = 1:3
for k = 1:NZ
    NZ - k
if justS == 0
    T12(:,:,k) = fillininils(NX,NY,T12(:,:,k),[181,85],1);
end
    S12(:,:,k) = fillininils(NX,NY,S12(:,:,k),[181,85],1);
end
end


IT = find(T12(:)==0);
length(IT)
IS = find(S12(:)==0);
length(IS)

% Vert Int one more time
%EXTRAP T AND S DEEPER TO FILL HOLES
for j = 1:NY
  NY-j
  for i = 1:NX
    tmp = squeeze(S12(i,j,:));
    I = find(tmp~=0);
    if length(I)>1
      tmp = interp1(RC(I),tmp(I),RC,'linear','extrap');
      S12(i,j,:) = tmp;
      tmp = squeeze(T12(i,j,:));
      tmp = interp1(RC(I),tmp(I),RC,'linear','extrap');
      T12(i,j,:) = tmp;
    end
  end
end

%AND CAP MAX AND MIN WITH OCCA
   Tmin, Tmax, Smin, Smax
   min(T12(:))
   max(T12(:))
   min(S12(:))
   max(S12(:))

   T12(T12<Tmin)=Tmin;
   T12(T12>Tmax)=Tmax;
   S12(S12<Smin)=Smin;
   S12(S12>Smax)=Smax;

%NOW WRITE!!!

fid = fopen('Sini_SO12_V1.bin','w','b');
fwrite(fid,S12,'single');
fclose(fid)
if justS == 0
fid = fopen('Tini_SO12_V1.bin','w','b');
fwrite(fid,T12,'single');
fclose(fid)
fid = fopen('Uini_SO12_V1.bin','w','b');
fwrite(fid,U12,'single');
fclose(fid)
fid = fopen('Vini_SO12_V1.bin','w','b');
fwrite(fid,V12,'single');
fclose(fid)

%AND WRITE TILED
!mkdir TILED12.45
        SNX =  45;
        SNY =  45;
        NPX =  96;
        NPY =  28;
        NR  =  104;

   for jpw = 1:NPY
     for ipw = 1:NPX
       if jpw>9;jpstr=['.0' num2str(jpw)];else;jpstr=['.00' num2str(jpw)];end
       if ipw>9;ipstr=['.0' num2str(ipw)];else;ipstr=['.00' num2str(ipw)];end
       fout=fopen(['TILED12.45/Tini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = T12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED12.45/Sini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = S12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED12.45/Uini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = U12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED12.45/Vini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = V12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
     end
   end

end


else

%AND NOW DO ICE
idir = '/net/mazdata1/mmazloff/SOSE/SO6input/ICs/';
fid = fopen([idir 'Heff_SO6_2005to12.bin'],'r','b');
H = fread(fid,inf,'single');fclose(fid)
H = reshape(H,[2160,320]);
fid = fopen([idir 'Area_SO6_2005to12.bin'],'r','b');
A = fread(fid,inf,'single');fclose(fid)
A = reshape(A,[2160,320]);
%SPREAD
A(:,321) = 0;
H(:,321) = 0;
yc6(321) = 10;yg6(321) = 10;
%INTERP SO6 HORIZONTALLY
  A12 = interp2(yc6,xc6,A,YC',XC);
  H12 = interp2(yc6,xc6,H,YC',XC);

fid = fopen('AreaIC_SO12_V1.bin','w','b');
fwrite(fid,A12,'single');
fclose(fid)
fid = fopen('HeffIC_SO12_V1.bin','w','b');
fwrite(fid,H12,'single');
fclose(fid)

end

fid = fopen(['/net/mazdata1/mmazloff/SOSE/SO12input/BATHY/SOSE_12_bathy0.bin'],'r','b');
H = fread(fid,inf,'single');fclose(fid)
H = reshape(H,[NX,NY]);
figure
clf; pcolor(XC,YC,double(S12(:,:,3))');shading flat;axis xy;caxis([32 36]); colorbar
hold on
contour(XC,YC,double(H'),[0 0],'k','linewidth',3);


end

if justwritetotile


wearejustwritetotile = 99

        SNX =  45;
        SNY =  45;
        NPX =  96;
        NPY =  28;
        NR  =  104;
        NX = SNX*NPX; NY = SNY*NPY;

%NOTES TO SELF(
%This is  2688 cores
%but we have 
%)

fid = fopen('Sini_SO12_V1.bin','r','b');
tmp = fread(fid,inf,'single');
S12 = reshape(tmp,[NX,NY,NR]);
fclose(fid)
fid = fopen('Tini_SO12_V1.bin','r','b');
tmp = fread(fid,inf,'single');
T12 = reshape(tmp,[NX,NY,NR]);
fclose(fid)
fid = fopen('Uini_SO12_V1.bin','r','b');
tmp = fread(fid,inf,'single');
U12 = reshape(tmp,[NX,NY,NR]);
fclose(fid)
fid = fopen('Vini_SO12_V1.bin','r','b');
tmp = fread(fid,inf,'single');
V12 = reshape(tmp,[NX,NY,NR]);
fclose(fid)

%MAKE MINOR MOD HERE
if 0 %HERE MOD...
%SMOOTH U AN V A LOT -- had nasty eddies in some locals
 for k = 1:NR
  NR - k 
  soverlap = 1; ssiz = [37,37]; sstd = 7; rmz = 0;
  tmp = U12(:,:,k);
  U12(:,:,k) = Smooth2Dfnc(NX,NY,tmp,soverlap,ssiz,sstd,rmz);
  tmp = V12(:,:,k);
  V12(:,:,k) = Smooth2Dfnc(NX,NY,tmp,soverlap,ssiz,sstd,rmz);
 end

%REWRITE
 fid = fopen('Uini_SO12_V1.bin','w','b');
 fwrite(fid,U12,'single');
 fclose(fid)
 fid = fopen('Vini_SO12_V1.bin','w','b');
 fwrite(fid,V12,'single');
 fclose(fid)
end

%AND WRITE TILED
!mkdir TILED12.45

   for jpw = 1:NPY
     for ipw = 1:NPX
       if jpw>9;jpstr=['.0' num2str(jpw)];else;jpstr=['.00' num2str(jpw)];end
       if ipw>9;ipstr=['.0' num2str(ipw)];else;ipstr=['.00' num2str(ipw)];end
       fout=fopen(['TILED12.45/Tini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = T12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED12.45/Sini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = S12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED12.45/Uini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = U12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED12.45/Vini_SO12_V1' ipstr jpstr '.data'],'w','b');
       Q = V12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
     end
   end

end


