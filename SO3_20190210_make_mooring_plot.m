close all
clear
clc

acc_settings

% str2 = '../OOI_Data/deployment0002_GA01SUMO-SBD11-06-METBKA000-telemetered-metbk_a_dcl_instrument_20151114T210631.697000-20161108T100305.770000.nc';
% 
% str3 = '../OOI_Data/deployment0003_GA01SUMO-SBD12-06-METBKA000-telemetered-metbk_a_dcl_instrument_20161027T014717.360000-20171022T084451.670000.nc';
% 
% ncdisp(str3)
% ncdisp(str2)
% 
% 
% pco23 = ncread(str3,'partial_pressure_co2_ssw');
% time3 = ncread(str3,'internal_timestamp');
% temp3 = ncread(str3,'sea_surface_temperature');
% precip3 = ncread(str3,'precipitation');
% swi3 = ncread(str3,'shortwave_irradiance');
% salt3 = ncread(str3,'met_salsurf');
% lat3 = ncread(str3,'lat');
% lon3 = ncread(str3,'lon');
% 
% % pco22 = ncread(str2,'partial_pressure_co2_ssw');
% time2 = ncread(str2,'time');
% temp2 = ncread(str2,'sea_surface_temperature');
% precip2 = ncread(str2,'precipitation');
% swi2 = ncread(str2,'shortwave_irradiance');
% % salt2 = ncread(str2,'met_salsurf');
% lat2 = ncread(str2,'lat');
% lon2 = ncread(str2,'lon');
% 
% 
% 
% 
% time = [time2;time3];
% precip = [precip2;precip3];
% swi = [swi2;swi3];
% time3 = acc_convert_time_19000101(time3);
% 
% 
% set(gcf, 'Position', [1, 1, 1900, 900])
% plot(time3,pco23,'LineWidth',1.8,'Color',Color(:,9))
% ylabel('W/m^2')
% title('Incoming shortwave radiation at Argentine Basin Apex Surface Mooring')
% dateFormat = 'yyyy mmm dd';
% datetick('x',dateFormat)
% acc_plots
% print('ISWR_AB','-djpeg')



str3 = '../OOI_Data/deployment0003_GA01SUMO-RII11-02-PCO2WC051-telemetered-pco2w_abc_imodem_instrument_20161027T020009-20180114T100009.nc';

ncdisp(str3)

time = ncread(str3,'record_time');
pco2 = ncread(str3,'pco2_seawater');

time = acc_convert_time_19040101(time)

set(gcf, 'Position', [1, 1, 1900, 900])
plot(time,pco2,'LineWidth',1.8,'Color',Color(:,9))
dateFormat = 'yyyy mmm dd';
datetick('x',dateFormat)
acc_plots
acc_movie





