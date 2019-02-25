
str3 = '../OOI_Data/deployment0003_GA03FLMB-RIM01-02-CTDMOG068-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = str2double(datestr(acc_convert_time_19000101(time(ii)),'yyyymmdd'));
end



Obs_500_temp = [time,lat,lon+360,theta,salt];
Obs_500_temp = sortrows(Obs_500_temp,1);

start_date = 20161130;

start = find(Obs_500_temp(:,1)>start_date,1);

Obs_500_temp = Obs_500_temp(start:end,:);


% sample_p = pres(1:1000);
% sample_lat = lat(1:1000);
% 
% histogram(sample_p)
% 
% depth = gsw_z_from_p(pres(ind),lat(ind));
% figure
% histogram(depth)

Obs_500 = zeros(307,5);
date = 736665;

for ii=1:396
    date_n = str2double(datestr(date,'yyyymmdd'));
    Obs_500(ii,:) = mean(Obs_500_temp(Obs_500_temp(:,1)==date_n,:),1);
    date = date+1;
end

clearvars -except Obs_500

save Obs_500







