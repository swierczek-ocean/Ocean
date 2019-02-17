


H = rdmds('hFacS');

size(H)


% contourf(H(:,:,45)',2)


A = poissrnd(1,6,6);
B = poissrnd(1,6,6);

G = A==0&B~=0




A(G) = 100