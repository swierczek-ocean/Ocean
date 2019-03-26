clear
close all
clc

tic()
format short g

fl_str = '../SOCCOM/USGO_SO_2016_PFL_D.nc';
ncdisp(fl_str);
depth = ncread(fl_str,'prof_depth');
S = ncread(fl_str,'prof_S');
T = ncread(fl_str,'prof_T');
lon = ncread(fl_str,'prof_lon');
lat = ncread(fl_str,'prof_lat');
date = ncread(fl_str,'prof_YYYYMMDD');
RC = rdmds('RC');
RC = squeeze(RC);
RC = -RC;

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>20161130);
D = A.*B.*C;
n_obs = sum(D);

THETA_Obs_Array1 = zeros(n_obs,100);
SALT_Obs_Array1 = zeros(n_obs,100);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      THETA_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          T(:,ii)'];
      SALT_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          S(:,ii)']; 
      counter = counter + 1;
   end
end

for ii=1:n_obs
    for jj=1:100
        if THETA_Obs_Array1(ii,jj)==-9999
            THETA_Obs_Array1(ii,jj)=NaN;
        end
        if SALT_Obs_Array1(ii,jj)==-9999
            SALT_Obs_Array1(ii,jj)=NaN;
        end
    end
end

THETA_Obs_Array1 = sortrows(THETA_Obs_Array1);
SALT_Obs_Array1 = sortrows(SALT_Obs_Array1);

fl_str = '../SOCCOM/VIZ_SO_2016_PFL.nc';
ncdisp(fl_str);
depth = ncread(fl_str,'prof_depth');
S = ncread(fl_str,'prof_S');
T = ncread(fl_str,'prof_T');
lon = ncread(fl_str,'prof_lon');
lat = ncread(fl_str,'prof_lat');
date = ncread(fl_str,'prof_YYYYMMDD');

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>20161130);
D = A.*B.*C;
n_obs = sum(D);

THETA_Obs_Array1b = zeros(n_obs,100);
SALT_Obs_Array1b = zeros(n_obs,100);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      THETA_Obs_Array1b(counter,:) = [date(ii),lon(ii),lat(ii),...
          T(:,ii)'];
      SALT_Obs_Array1b(counter,:) = [date(ii),lon(ii),lat(ii),...
          S(:,ii)']; 
      counter = counter + 1;
   end
end

for ii=1:n_obs
    for jj=1:100
        if THETA_Obs_Array1b(ii,jj)==-9999
            THETA_Obs_Array1b(ii,jj)=NaN;
        end
        if SALT_Obs_Array1b(ii,jj)==-9999
            SALT_Obs_Array1b(ii,jj)=NaN;
        end
    end
end

THETA_Obs_Array1b = sortrows(THETA_Obs_Array1b);
SALT_Obs_Array1b = sortrows(SALT_Obs_Array1b);

[sum(double(isnan(THETA_Obs_Array1b)))',[0;0;0;depth],[1:100]',[RC;zeros(48,1)]]

fl_str = '../SOCCOM/USGO_WO_2017_PFL_D.nc';
ncdisp(fl_str);
depth = ncread(fl_str,'prof_depth');
S = ncread(fl_str,'prof_S');
T = ncread(fl_str,'prof_T');
lon = ncread(fl_str,'prof_lon');
lat = ncread(fl_str,'prof_lat');
date = ncread(fl_str,'prof_YYYYMMDD');

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>20161130);
D = A.*B.*C;
n_obs = sum(D);

THETA_Obs_Array2 = zeros(n_obs,100);
SALT_Obs_Array2 = zeros(n_obs,100);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      THETA_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          T(:,ii)'];
      SALT_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          S(:,ii)']; 
      counter = counter + 1;
   end
end

for ii=1:n_obs
    for jj=1:100
        if THETA_Obs_Array2(ii,jj)==-9999
            THETA_Obs_Array2(ii,jj)=NaN;
        end
        if SALT_Obs_Array2(ii,jj)==-9999
            SALT_Obs_Array2(ii,jj)=NaN;
        end
    end
end

THETA_Obs_Array2 = sortrows(THETA_Obs_Array2);
SALT_Obs_Array2 = sortrows(SALT_Obs_Array2);

fl_str = '../SOCCOM/VIZ_SO_2017_PFL.nc';
ncdisp(fl_str);
depth = ncread(fl_str,'prof_depth');
S = ncread(fl_str,'prof_S');
T = ncread(fl_str,'prof_T');
lon = ncread(fl_str,'prof_lon');
lat = ncread(fl_str,'prof_lat');
date = ncread(fl_str,'prof_YYYYMMDD');

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>20161130);
D = A.*B.*C;
n_obs = sum(D);

THETA_Obs_Array2b = zeros(n_obs,100);
SALT_Obs_Array2b = zeros(n_obs,100);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      THETA_Obs_Array2b(counter,:) = [date(ii),lon(ii),lat(ii),...
          T(:,ii)'];
      SALT_Obs_Array2b(counter,:) = [date(ii),lon(ii),lat(ii),...
          S(:,ii)']; 
      counter = counter + 1;
   end
end

for ii=1:n_obs
    for jj=1:100
        if THETA_Obs_Array2b(ii,jj)==-9999
            THETA_Obs_Array2b(ii,jj)=NaN;
        end
        if SALT_Obs_Array2b(ii,jj)==-9999
            SALT_Obs_Array2b(ii,jj)=NaN;
        end
    end
end

THETA_Obs_Array2b = sortrows(THETA_Obs_Array2b);
SALT_Obs_Array2b = sortrows(SALT_Obs_Array2b);

THETA_temp1 = [THETA_Obs_Array1;THETA_Obs_Array1b];
THETA_temp1 = sortrows(THETA_temp1);
THETA_temp2 = [THETA_Obs_Array2;THETA_Obs_Array2b];
THETA_temp2 = sortrows(THETA_temp2);
THETA_Obs = [THETA_temp1;THETA_temp2];

SALT_temp1 = [SALT_Obs_Array1;SALT_Obs_Array1b];
SALT_temp1 = sortrows(SALT_temp1);
SALT_temp2 = [SALT_Obs_Array2;SALT_Obs_Array2b];
SALT_temp2 = sortrows(SALT_temp2);
SALT_Obs = [SALT_temp1;SALT_temp2];

clearvars -except SALT_Obs THETA_Obs
save Obs

toc()