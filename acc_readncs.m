clear
clc
format short g

ncdisp('USGO_SO_2013_PFL_D.nc')

depth = ncread('USGO_SO_2013_PFL_D.nc','prof_depth');

S = ncread('USGO_SO_2013_PFL_D.nc','prof_S');

Sest = ncread('USGO_SO_2013_PFL_D.nc','prof_Sestim');

lon = ncread('USGO_SO_2013_PFL_D.nc','prof_lon');
lat = ncread('USGO_SO_2013_PFL_D.nc','prof_lat');

delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
    10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
    20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
    100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
    300, 380, 400, 400, 400, 400, 400, 400, 400, 400];

dZ = cumsum(delZ)';
[dZ,[1:52]']