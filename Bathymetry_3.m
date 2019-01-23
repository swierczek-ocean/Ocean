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

ncdisp('grid.nc');

XG = ncread('grid.nc','XG');
YG = ncread('grid.nc','YG');
DXG = ncread('grid.nc','DXG');
DYG = ncread('grid.nc','DYG');
hFacC = ncread('grid.nc','hFacC');
hFacS = ncread('grid.nc','hFacS');
hFacW = ncread('grid.nc','hFacW');
Bath = ncread('grid.nc','Depth');
RC = ncread('grid.nc','RC');
RF = ncread('grid.nc','RF');
DRC = ncread('grid.nc','DRC');
DRF = ncread('grid.nc','DRF');
RAC = ncread('grid.nc','RAC');
RAS = ncread('grid.nc','RAS');
RAW = ncread('grid.nc','RAW');
XC = ncread('grid.nc','XC');
YC = ncread('grid.nc','YC');
DXC = ncread('grid.nc','DXC');
DYC = ncread('grid.nc','DYC');








% X = XG(:,1);
% Y = YG(1,:);
% Bath = -Bath';
% 
% cc = 9;
% lw = 2.2;
% 
% lox = find(X>288.3,1);
% hix = find(X>351.9,1);
% loy = find(Y>-61,1);
% hiy = find(Y>-30.1,1);
% 
% loxx = find(X>289.99,1);
% hixx = find(X>350,1);
% loyy = find(Y>-58.99,1);
% hiyy = find(Y>-32,1);
% 
% Bath = Bath(loy:hiy,lox:hix);
% X = X(lox:hix);
% Y = Y(loy:hiy);
% 
% bottom = loyy-loy;
% top = hiy-hiyy;
% right = hix-hixx;
% left = loxx-lox;
% 
% for ii=1:left
%    Bath(:,ii) = Bath(:,left+1); 
% end
% 
% for ii=1:right
%    Bath(:,end-ii+1) = Bath(:,end-right); 
% end
% 
% for ii=1:top
%    Bath(end-ii+1,:) = Bath(end-top,:); 
% end
% 
% for ii=1:bottom
%    Bath(ii,:) = Bath(bottom+1,:); 
% end
% 
% Bath(1:bottom,1:left) = zeros(bottom,left);
% Bath(1:bottom,end-right:end) = zeros(bottom,right+1);
% Bath(end-top:end,end-right:end) = ...
%     zeros(top+1,right+1);




% figure()
% set(gcf, 'Position', [25, 25, 1600, 900])
% colormap(flipud(colormap4))
% s = surf(X,Y,Bath);
% s.EdgeColor = 'none';
% axis([288 352 -61 -30 -10000 3000])
% c = colorbar('eastoutside');
% c.Label.String = 'm';
% caxis([lb ub])
% xlabel('Latitude')
% ylabel('Longitude')
% zlabel('Depth')
% title('Modified Argentine Basin Bathymetry in [288,352] E x [-59,-30] S')
% print('Mod_Argentine_Basin_bathymetry_surf_r','-djpeg')