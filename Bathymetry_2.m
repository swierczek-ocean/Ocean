tic()
clc
clear
format long g


lb = -6000;
ub = 0;
z = linspace(lb,ub,13);
v = [-6000:1000:0];
ACC_Colors
ACC_Colormaps

% ncdisp('grid.nc');

XC = ncread('grid.nc','XC');
YC = ncread('grid.nc','YC');
XG = ncread('grid.nc','XG');
YG = ncread('grid.nc','YG');
XG = XG(:,1);
YG = YG(1,:);

X = XC(:,1);
Y = YC(1,:);

Bath = ncread('grid.nc','Depth');
Bath = -Bath';

cc = 9;
lw = 2.2;

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1);
hiy = find(Y>-30.7,1);

loxx = find(X>289.99,1);
hixx = find(X>350,1);
loyy = find(Y>-59.3,1);
hiyy = find(Y>-32.1,1);

Bath = Bath(loy-1:hiy,lox:hix);
X = X(lox:hix);
Y = Y(loy-1:hiy);
XG = XG(lox:hix);
YG = YG(loy-1:hiy+1);
delY = YG(2:end)-YG(1:end-1);
fprintf('delY starts with: %g %g %g %g %g %g \n',delY(1),delY(2),delY(3),delY(4),delY(5),delY(6))

fprintf('bathymetry box = [%g,%g]x[%g,%g] \n',X(1),X(end),Y(1),Y(end));

bottom = loyy-loy;
top = hiy-hiyy;
right = hix-hixx-1;
left = loxx-lox;

Bath_closed = Bath;

for ii=1:left
   Bath(:,ii) = Bath(:,left+1); 
end

for ii=1:right
   Bath(:,end-ii+1) = Bath(:,end-right); 
end

for ii=1:top
   Bath(end-ii+1,:) = Bath(end-top,:); 
end

for ii=1:bottom
   Bath(ii,:) = Bath(bottom+1,:); 
end

Bath(1:bottom,1:left) = zeros(bottom,left);
Bath(1:bottom,end-right:end) = zeros(bottom,right+1);
Bath(end-top:end,end-right:end) = ...
    zeros(top+1,right+1);




figure()
set(gcf, 'Position', [1, 1, 1500, 800])
colormap(flipud(bone))
s = surf(X,Y,Bath);
s.EdgeColor = 'none';
axis([288.5 352.167 -61 -29.7 -10000 3000])
c = colorbar('eastoutside');
c.Label.String = 'm';
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Modified Argentine Basin Bathymetry in [288,352] E x [-59,-30] S')
print('Mod_Argentine_Basin_bathymetry_surf_r','-djpeg')



Bath = Bath';

fid = fopen('Bathy_ArgBasin_stretched.bin','w','b');
fwrite(fid,Bath,'single');
fclose(fid);


Bath_closed(:,1:5) = zeros(132,5);
Bath_closed(:,188:192) = zeros(132,5);
Bath_closed(1:5,:) = zeros(5,192);

for ii=1:top
   Bath_closed(end-ii+1,:) = Bath_closed(end-top,:); 
end


figure()
set(gcf, 'Position', [1, 1, 1500, 800])
colormap(flipud(bone))
s = surf(X,Y,Bath_closed);
s.EdgeColor = 'none';
axis([288.5 352.167 -61 -29.7 -10000 3000])
c = colorbar('eastoutside');
c.Label.String = 'm';
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Modified Argentine Basin Bathymetry in [288.5,352.167] E x [-61,-29.7] S')
print('Mod_Argentine_Basin_bathymetry_surf_c','-djpeg')



Bath_closed = Bath_closed';

fid = fopen('Bathy_ArgBasin_closed.bin','w','b');
fwrite(fid,Bath_closed,'single');
fclose(fid);

