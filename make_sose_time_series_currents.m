

stru = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Uvel.nc';
strv = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Vvel.nc';
strt = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc';

hFacC = ncread(strt,'hFacC',[1,1,1],[2160,588,1]);

Current = zeros(2160,588,203);

for ii=1:203
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents1.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,203);

for ii=204:406
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-203) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents2.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,203);

for ii=407:609
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-406) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents3.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,203);

for ii=610:812
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-609) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents4.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,203);

for ii=813:1015
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-812) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents5.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

Current = zeros(2160,588,203);

for ii=1016:1218
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-1015) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents6.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,203);

for ii=1219:1421
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-1218) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents7.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,203);

for ii=1422:1624
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-1421) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents8.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

Current = zeros(2160,588,201);

for ii=1625:1826
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    UV = squeeze(UV);
    VV = squeeze(VV);
    U = sqrt(UV.^2+VV.^2);
    
    U(U>1.47)=1.48;
    U(hFacC==0)=200;
    clear UV VV
    Current(:,:,ii-1624) = U;
    clear U
    fprintf('on iteration %g \n',ii)
end

fid = fopen('Currents9.bin','w','b');
fwrite(fid,Current,'single');
fclose(fid);

clear Current

clear
