

str3 = '../OOI_Data/deployment0003_GA02HYPM-WFP02-04-CTDPFL000-recovered_wfp-ctdpf_ckl_wfp_instrument_recovered_20161030T000003-20171003T185844.999253.nc';

ncdisp(str3)

pres = ncread(str3,'ctdpf_ckl_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdpf_ckl_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = str2double(datestr(acc_convert_time_19000101(time(ii)),'yyyymmdd'));
end



Obs_Prof_temp = [time,lat,lon+360,theta,salt];
Obs_Prof_temp = sortrows(Obs_Prof_temp,1);

start_date = 20161130;

start = find(Obs_Prof_temp(:,1)>start_date,1);

Obs_Prof_temp = Obs_Prof_temp(start:end,:);


% sample_p = pres(1:1000);
% sample_lat = lat(1:1000);
% 
% histogram(sample_p)
% 
% depth = gsw_z_from_p(pres(ind),lat(ind));
% figure
% histogram(depth)

Obs_Prof = zeros(396,5);
date = 736665;

for ii=1:396
    date_n = str2double(datestr(date,'yyyymmdd'));
    Obs_Prof(ii,:) = mean(Obs_Prof_temp(Obs_Prof_temp(:,1)==date_n,:),1);
    date = date+1;
end

clearvars -except Obs_Prof

save Obs_Prof