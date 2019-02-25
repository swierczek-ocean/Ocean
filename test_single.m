

A = randn(5,5)
A(1,1) = 99999999;
A = single(A);

fid = fopen('A.bin','w','b');
fwrite(fid,A,'single');
fclose(fid);

fid = fopen('A.bin','r','b');
U = fread(fid,inf,'single');
fclose(fid);

U = reshape(U,[5,5])


