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

fid = fopen('alk_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
alk = A(lox:hix,loy:hiy,:);
for ii=1:5
   alk(ii,6:127,:) = alk(6,6:127,:); 
   alk(6:187,ii,:) = alk(6:187,6,:);
   alk(187+ii,6:127,:) = alk(187,6:127,:); 
   alk(6:187,127+ii,:) = alk(6:187,127,:);
end

fid = fopen('alk_init_restr.bin','w','b');
fwrite(fid,alk,'single');
fclose(fid);

%%

fid = fopen('dic_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
dic = A(lox:hix,loy:hiy,:);

for ii=1:5
   dic(ii,6:127,:) = dic(6,6:127,:); 
   dic(6:187,ii,:) = dic(6:187,6,:);
   dic(187+ii,6:127,:) = dic(187,6:127,:); 
   dic(6:187,127+ii,:) = dic(6:187,127,:);
end

fid = fopen('dic_init_restr.bin','w','b');
fwrite(fid,dic,'single');
fclose(fid);

%%

fid = fopen('don_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
don = A(lox:hix,loy:hiy,:);

for ii=1:5
   don(ii,6:127,:) = don(6,6:127,:); 
   don(6:187,ii,:) = don(6:187,6,:);
   don(187+ii,6:127,:) = don(187,6:127,:); 
   don(6:187,127+ii,:) = don(6:187,127,:);
end

fid = fopen('don_init_restr.bin','w','b');
fwrite(fid,don,'single');
fclose(fid);

%%

fid = fopen('po4_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
po4 = A(lox:hix,loy:hiy,:);

for ii=1:5
   po4(ii,6:127,:) = po4(6,6:127,:); 
   po4(6:187,ii,:) = po4(6:187,6,:);
   po4(187+ii,6:127,:) = po4(187,6:127,:); 
   po4(6:187,127+ii,:) = po4(6:187,127,:);
end

fid = fopen('po4_init_restr.bin','w','b');
fwrite(fid,po4,'single');
fclose(fid);
%%

fid = fopen('fe_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
fe = A(lox:hix,loy:hiy,:);
for ii=1:5
   fe(ii,6:127,:) = fe(6,6:127,:); 
   fe(6:187,ii,:) = fe(6:187,6,:);
   fe(187+ii,6:127,:) = fe(187,6:127,:); 
   fe(6:187,127+ii,:) = fe(6:187,127,:);
end

fid = fopen('fe_init_restr.bin','w','b');
fwrite(fid,fe,'single');
fclose(fid);


fid = fopen('no3_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
no3 = A(lox:hix,loy:hiy,:);

for ii=1:5
   no3(ii,6:127,:) = no3(6,6:127,:); 
   no3(6:187,ii,:) = no3(6:187,6,:);
   no3(187+ii,6:127,:) = no3(187,6:127,:); 
   no3(6:187,127+ii,:) = no3(6:187,127,:);
end

fid = fopen('no3_init_restr.bin','w','b');
fwrite(fid,no3,'single');
fclose(fid);


fid = fopen('o2_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
o2 = A(lox:hix,loy:hiy,:);

for ii=1:5
   o2(ii,6:127,:) = o2(6,6:127,:); 
   o2(6:187,ii,:) = o2(6:187,6,:);
   o2(187+ii,6:127,:) = o2(187,6:127,:); 
   o2(6:187,127+ii,:) = o2(6:187,127,:);
end

fid = fopen('o2_init_restr.bin','w','b');
fwrite(fid,o2,'single');
fclose(fid);



fid = fopen('dop_init_frm105v1.bin','r','b');
U = fread(fid,inf,'single');
NZ = length(U)/NX/NY;
A = reshape(U,[NX,NY,NZ]);
fclose(fid);
dop = A(lox:hix,loy:hiy,:);

for ii=1:5
   dop(ii,6:127,:) = dop(6,6:127,:); 
   dop(6:187,ii,:) = dop(6:187,6,:);
   dop(187+ii,6:127,:) = dop(187,6:127,:); 
   dop(6:187,127+ii,:) = dop(6:187,127,:);
end

fid = fopen('dop_init_restr.bin','w','b');
fwrite(fid,dop,'single');
fclose(fid);


contourf(A(:,:,1)')


clear



toc()