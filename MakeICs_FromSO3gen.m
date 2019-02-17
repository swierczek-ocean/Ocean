clear all
close all


%READ IN GRIDS
load /data/soccom/GRID_3/grid XC YC RC hFacC
x3 = XC(:,1);
y3 = YC(1,:);
z3 = squeeze(RC);
[NX3 NY3 NZ3] = size(hFacC);
hFacC3 = hFacC;
%READ IN GRIDS
load /data/soccom/GRID_12/grid XC YC RC hFacC
x12 = XC(:,1);
y12 = YC(1,:);
z12 = squeeze(RC);
clear XC YC RC
[NX NY NZ] = size(hFacC);

idir = '/data/averdy/soccom/SO3grid/';
ostr = '_SO12.bin'

for iini = 1:3
  switch iini
    case 1; fname = 'phyto_sm'
    case 2; fname = 'phyto_lg'
    case 3; fname = 'phyto_diaz'
  end
  fid = fopen([idir fname '.bin'],'r','b');
  Q3 = fread(fid,NX3*NY3*NZ3,'single');
  fclose(fid);
  Q3 = reshape(Q3,[NX3 NY3 NZ3]);
  fid = fopen([fname ostr],'w','b');
  Q12 = zeros(NX,NY,NZ,'single');
  %NOW BIN
  for k = 1:NZ
    for j = 1:NY
      for i = 1:NX
        if hFacC(i,j,k) > 0
          if hFacC3(ceil(i/4), ceil(j/4), ceil(k/2) ) > 0;
            Q12(i,j,k) = Q3(ceil(i/4), ceil(j/4), ceil(k/2) );
          elseif k > 2  %check; 
            Q12(i,j,k) = Q3(ceil(i/4), ceil(j/4), ceil(k/2)-1 );%hoping sufficient
          end
          if Q12(i,j,k) == 0
display(['no value found for ' num2str(i) ' ' num2str(j) ' ' num2str(k) '. ERROR!!!'])
          end
        end
      end
    end
  end
  fwrite(fid,Q12,'single');
  fclose(fid);
end


break
if 0
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

if 0
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


if 0
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


