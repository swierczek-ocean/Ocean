

fid = fopen('DOP_SBC_2013to2017_monthly.bin','r','b');
U = fread(fid,inf,'single');
fclose(fid);
z = length(U)/192/52;
U = reshape(U,[192,52,z]);
U = permute(U,[2,1,3]);

contourf(flipud(U(:,:,1)),100)


fid = fopen('UVEL_NBC_2013to2017_monthly.bin','r','b');
U = fread(fid,inf,'single');
z = length(U)/192/52;
U = reshape(U,[192,52,z]);
U = permute(U,[2,1,3]);

figure()
contourf(flipud(U(:,:,1)),100)



