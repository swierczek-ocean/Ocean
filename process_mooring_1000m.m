
str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOH050-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

% depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = str2double(datestr(acc_convert_time_19000101(time(ii)),'yyyymmdd'));
end



Obs_1000_temp = [time,lat,lon+360,theta,salt];
Obs_1000_temp = sortrows(Obs_1000_temp,1);

start_date = 20161130;

start = find(Obs_1000_temp(:,1)>start_date,1);

Obs_1000_temp = Obs_1000_temp(start:end,:);


% sample_p = pres(1:1000);
% sample_lat = lat(1:1000);
% 
% histogram(sample_p)
% 
% depth = gsw_z_from_p(pres(ind),lat(ind));
% figure
% histogram(depth)

Obs_1000 = zeros(307,5);
date = 736665;

for ii=1:396
    date_n = str2double(datestr(date,'yyyymmdd'));
    Obs_1000(ii,:) = mean(Obs_1000_temp(Obs_1000_temp(:,1)==date_n,:),1);
    date = date+1;
end

clearvars -except Obs_1000

save Obs_1000