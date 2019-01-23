tic()
clc
clear
close all

XC = ncread('grid.nc','XC');
YC = ncread('grid.nc','YC');

X = XC(:,1);
Y = YC(1,:);

% lox = find(X>290,1);
% hix = find(X>349.9,1);
% loy = find(Y>-60.2,1);
% hiy = find(Y>-32.3,1);

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
NX = 1080;
NY = 315;

fid = fopen('runoff_clim921rivers_DJ_so3_ms_V0.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);

A = A(lox:hix,loy:hiy,:);
for ii=1:5
   A(ii,6:127,:) = A(6,6:127,:); 
   A(6:187,ii,:) = A(6:187,6,:);
   A(187+ii,6:127,:) = A(187,6:127,:); 
   A(6:187,127+ii,:) = A(6:187,127,:);
end

contourf(A(:,:,8)');

fid = fopen('runoff_clim921rivers_DJ_so3_ms_ArgBasin.bin','w','b');
fwrite(fid,A,'single');
fclose(fid);







