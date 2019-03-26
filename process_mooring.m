
% str1 = '../OOI_Data/deployment0003_GA01SUMO-SBD11-06-METBKA000-telemetered-metbk_a_dcl_instrument_20161027T014720.743000-20170324T223258.498000.nc';
% ncdisp(str1)
% str2 = '../OOI_Data/deployment0003_GA02HYPM-RIM01-02-CTDMOG039-recovered_inst-ctdmo_ghqr_instrument_recovered_20161029T221501-20180111T121501.nc';
% ncdisp(str2)
% pressure_temp = ncread(str2,'pressure_temp');

str3 = '../OOI_Data/deployment0003_GA01SUMO-SBD12-06-METBKA000-telemetered-metbk_a_dcl_instrument_20161027T014717.360000-20171022T084451.670000.nc';

ncdisp(str3)

pres = ncread(str3,'ctdpf_ckl_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdpf_ckl_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

ind = find(pres>1800 & pres<1845);

block = [lat(ind),lon(ind),time(ind),pres(ind),temp(ind),salt(ind)];

% sample_p = pres(1:1000);
% sample_lat = lat(1:1000);
% 
% histogram(sample_p)
% 
depth = gsw_z_from_p(pres(ind),lat(ind));

figure
histogram(depth)
