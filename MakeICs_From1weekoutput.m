clear all
close all

addpath ~/ANALYSIS/
U12 = rdmds('/net/mazdata1/mmazloff/SOCCOM/SO12/I0/OUTPUT/U',10080);
V12 = rdmds('/net/mazdata1/mmazloff/SOCCOM/SO12/I0/OUTPUT/V',10080);
T12 = rdmds('/net/mazdata1/mmazloff/SOCCOM/SO12/I0/OUTPUT/T',10080);
S12 = rdmds('/net/mazdata1/mmazloff/SOCCOM/SO12/I0/OUTPUT/S',10080);

[NX NY NZ] = size(S12);

%FIX SPONGE AREA
for j = NY-6:NY
  T12(:,j,:) = T12(:,NY-7,:);
  S12(:,j,:) = S12(:,NY-7,:);
  U12(:,j,:) = U12(:,NY-7,:);
  V12(:,j,:) = V12(:,NY-7,:);
end

%FILL T AND S
fid = fopen('Tini_SO12_V1.bin','r','b');
T = fread(fid,inf,'single');
fclose(fid);
T = reshape(T,size(T12));
T12(T12==0) = T(T12==0);

fid = fopen('Sini_SO12_V1.bin','r','b');
T = fread(fid,inf,'single');
fclose(fid);
T = reshape(T,size(T12));
S12(S12==0) = T(S12==0);
clear T

fid = fopen('Uini_SO12_V2.data','w','b');
fwrite(fid,U12,'single');
fclose(fid);

fid = fopen('Vini_SO12_V2.data','w','b');
fwrite(fid,V12,'single');
fclose(fid);

fid = fopen('Tini_SO12_V2.data','w','b');
fwrite(fid,T12,'single');
fclose(fid);

fid = fopen('Sini_SO12_V2.data','w','b');
fwrite(fid,S12,'single');
fclose(fid);

%AND WRITE TILED
!mkdir TILED
        SNX =  45;
        SNY =  45;
        NPX =  96;
        NPY =  28;
        NR  =  104;

   for jpw = 1:NPY
     for ipw = 1:NPX
       if jpw>9;jpstr=['.0' num2str(jpw)];else;jpstr=['.00' num2str(jpw)];end
       if ipw>9;ipstr=['.0' num2str(ipw)];else;ipstr=['.00' num2str(ipw)];end
       fout=fopen(['TILED/Tini_SO12_V2' ipstr jpstr '.data'],'w','b');
       Q = T12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED/Sini_SO12_V2' ipstr jpstr '.data'],'w','b');
       Q = S12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED/Uini_SO12_V2' ipstr jpstr '.data'],'w','b');
       Q = U12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
       fout=fopen(['TILED/Vini_SO12_V2' ipstr jpstr '.data'],'w','b');
       Q = V12((ipw*SNX-SNX+1):ipw*SNX,(jpw*SNY-SNY+1):jpw*SNY,:);
       fwrite(fout,Q,'single');
       fclose(fout);
     end
   end



