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

fid = fopen('UVEL_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
UVEL = A(lox:hix,loy:hiy,:);
for ii=1:5
   UVEL(ii,6:127,:) = UVEL(6,6:127,:); 
   UVEL(6:187,ii,:) = UVEL(6:187,6,:);
   UVEL(187+ii,6:127,:) = UVEL(187,6:127,:); 
   UVEL(6:187,127+ii,:) = UVEL(6:187,127,:);
end

fid = fopen('UVEL_init_restr.bin','w','b');
fwrite(fid,UVEL,'single');
fclose(fid);


fid = fopen('VVEL_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
VVEL = A(lox:hix,loy:hiy,:);

for ii=1:5
   VVEL(ii,6:127,:) = VVEL(6,6:127,:); 
   VVEL(6:187,ii,:) = VVEL(6:187,6,:);
   VVEL(187+ii,6:127,:) = VVEL(187,6:127,:); 
   VVEL(6:187,127+ii,:) = VVEL(6:187,127,:);
end

fid = fopen('VVEL_init_restr.bin','w','b');
fwrite(fid,VVEL,'single');
fclose(fid);


fid = fopen('THETA_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
THETA = A(lox:hix,loy:hiy,:);

for ii=1:5
   THETA(ii,6:127,:) = THETA(6,6:127,:); 
   THETA(6:187,ii,:) = THETA(6:187,6,:);
   THETA(187+ii,6:127,:) = THETA(187,6:127,:); 
   THETA(6:187,127+ii,:) = THETA(6:187,127,:);
end

fid = fopen('THETA_init_restr.bin','w','b');
fwrite(fid,THETA,'single');
fclose(fid);



fid = fopen('SALT_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
SALT = A(lox:hix,loy:hiy,:);

for ii=1:5
   SALT(ii,6:127,:) = SALT(6,6:127,:); 
   SALT(6:187,ii,:) = SALT(6:187,6,:);
   SALT(187+ii,6:127,:) = SALT(187,6:127,:); 
   SALT(6:187,127+ii,:) = SALT(6:187,127,:);
end

fid = fopen('SALT_init_restr.bin','w','b');
fwrite(fid,SALT,'single');
fclose(fid);


% contourf(A(:,:,1)')






toc()