clear
close all
clc

tic()
format short g

% ncdisp('USGO_SO_2013_PFL_D.nc');
depth = ncread('USGO_SO_2013_PFL_D.nc','prof_depth');
S = ncread('USGO_SO_2013_PFL_D.nc','prof_S');
T = ncread('USGO_SO_2013_PFL_D.nc','prof_T');
lon = ncread('USGO_SO_2013_PFL_D.nc','prof_lon');
lat = ncread('USGO_SO_2013_PFL_D.nc','prof_lat');
date = ncread('USGO_SO_2013_PFL_D.nc','prof_YYYYMMDD');
RC = rdmds('RC');
RC = squeeze(RC);
RC = -RC;

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date<20130700);
D = A.*B.*C;
n_obs = sum(D);

Temp_Obs_Array = zeros(895,100);
Salt_Obs_Array = zeros(895,100);
counter = 1;

for ii=1:33644
   if D(ii)==1
      Temp_Obs_Array(counter,:) = [date(ii),lon(ii),lat(ii),...
          T(:,ii)'];
      Salt_Obs_Array(counter,:) = [date(ii),lon(ii),lat(ii),...
          S(:,ii)']; 
      counter = counter + 1;
   end
end

for ii=1:895
    for jj=1:100
        if Temp_Obs_Array(ii,jj)==-9999
            Temp_Obs_Array(ii,jj)=NaN;
        end
        if Salt_Obs_Array(ii,jj)==-9999
            Salt_Obs_Array(ii,jj)=NaN;
        end
    end
end

[sum(double(isnan(Temp_Obs_Array)))',[0;0;0;depth],[1:100]',[RC;zeros(48,1)]]


Temp_Obs_Array = sortrows(Temp_Obs_Array);
Salt_Obs_Array = sortrows(Salt_Obs_Array);

delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
    10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
    20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
    100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
    300, 380, 400, 400, 400, 400, 400, 400, 400, 400];

clearvars -except Temp_Obs_Array Salt_Obs_Array delZ RC

toc()