



fid = fopen('UVEL_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[192,132,52]);
contourf(U(:,:,1)',100)
fclose(fid);







