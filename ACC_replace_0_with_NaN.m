tic()
clc
clear
close all

%% sea surface temperature
load('SST.mat')

SST_avg = mean(SST,3);
SST_std = std(SST,0,3);
clear SST
SST_avg = SST_avg';
SST_std = SST_std';
[m,n] = size(SST_avg);

for ii=1:m
    for jj=1:n
        if (SST_avg(ii,jj)==0)
            SST_avg(ii,jj) = NaN;
            SST_std(ii,jj) = NaN;
        end
    end
end

save SST_avg
save SST_std
fprintf('Finished saving SST\n')
clear
%%

%% sea surface salinity
load('SSS.mat')

SSS_avg = mean(SSS,3);
SSS_std = std(SSS,0,3);
clear SSS
SSS_avg = SSS_avg';
SSS_std = SSS_std';

[m,n] = size(SSS_avg);

for ii=1:m
    for jj=1:n
        if (SSS_avg(ii,jj)==0)
            SSS_avg(ii,jj) = NaN;
            SSS_std(ii,jj) = NaN;
        end
    end
end

save SSS_avg
save SSS_std
fprintf('Finished saving SSS\n')
clear
%%

%% sea surface height
load('SSH.mat')

SSH_avg = mean(SSH,3);
SSH_std = std(SSH,0,3);
clear SSH
SSH_avg = SSH_avg';
SSH_std = SSH_std';

[m,n] = size(SSH_avg);

for ii=1:m
    for jj=1:n
        if (SSH_avg(ii,jj)==0)
            SSH_avg(ii,jj) = NaN;
            SSH_std(ii,jj) = NaN;
        end
    end
end

save SSH_avg
save SSH_std
fprintf('Finished saving SSH\n')
clear
%%

%% surface zonal velocity
load('SSU.mat')

SSU_avg = mean(SSU,3);
SSU_std = std(SSU,0,3);
clear SSU
SSU_avg = SSU_avg';
SSU_std = SSU_std';

[m,n] = size(SSU_avg);

for ii=1:m
    for jj=1:n
        if (SSU_avg(ii,jj)==0)
            SSU_avg(ii,jj) = NaN;
            SSU_std(ii,jj) = NaN;
        end
    end
end

save SSU_avg
save SSU_std
fprintf('Finished saving SSU\n')
clear
%%

%% surface meridional velocity
load('SSV.mat')

SSV_avg = mean(SSV,3);
SSV_std = std(SSV,0,3);
clear SSV
SSV_avg = SSV_avg';
SSV_std = SSV_std';

[m,n] = size(SSV_avg);

for ii=1:m
    for jj=1:n
        if (SSV_avg(ii,jj)==0)
            SSV_avg(ii,jj) = NaN;
            SSV_std(ii,jj) = NaN;
        end
    end
end

save SSV_avg
save SSV_std
fprintf('Finished saving SSV\n')
clear
%%

%% mixed layer depth
load('MLD.mat')

MLD_avg = mean(MLD,3);
MLD_std = std(MLD,0,3);
clear MLD
MLD_avg = MLD_avg';
MLD_std = MLD_std';

[m,n] = size(MLD_avg);

for ii=1:m
    for jj=1:n
        if (MLD_avg(ii,jj)==0)
            MLD_avg(ii,jj) = NaN;
            MLD_std(ii,jj) = NaN;
        end
    end
end

save MLD_avg
save MLD_std
fprintf('Finished saving MLD\n')
clear
%%

%% zonal wind stress
load('TAUX.mat')

TAUX_avg = mean(TAUX,3);
TAUX_std = std(TAUX,0,3);
clear TAUX
TAUX_avg = TAUX_avg';
TAUX_std = TAUX_std';

[m,n] = size(TAUX_avg);

for ii=1:m
    for jj=1:n
        if (TAUX_avg(ii,jj)==0)
            TAUX_avg(ii,jj) = NaN;
            TAUX_std(ii,jj) = NaN;
        end
    end
end

save TAUX_avg
save TAUX_std
fprintf('Finished saving TAUX\n')
clear
%%

%% meridional wind stress
load('TAUY.mat')

TAUY_avg = mean(TAUY,3);
TAUY_std = std(TAUY,0,3);
clear TAUY
TAUY_avg = TAUY_avg';
TAUY_std = TAUY_std';

[m,n] = size(TAUY_avg);

for ii=1:m
    for jj=1:n
        if (TAUY_avg(ii,jj)==0)
            TAUY_avg(ii,jj) = NaN;
            TAUY_std(ii,jj) = NaN;
        end
    end
end

save TAUY_avg
save TAUY_std
fprintf('Finished saving TAUY\n')
clear
%%

%% heat flux
load('TFLUX.mat')

TFLUX_avg = mean(TFLUX,3);
TFLUX_std = std(TFLUX,0,3);
clear TFLUX
TFLUX_avg = TFLUX_avg';
TFLUX_std = TFLUX_std';

[m,n] = size(TFLUX_avg);

for ii=1:m
    for jj=1:n
        if (TFLUX_avg(ii,jj)==0)
            TFLUX_avg(ii,jj) = NaN;
            TFLUX_std(ii,jj) = NaN;
        end
    end
end

save TFLUX_avg
save TFLUX_std
fprintf('Finished saving TFLUX\n')
clear
%% 

%% CO2 flux
load('CFLUX.mat')

CFLUX_avg = mean(CFLUX,3);
CFLUX_std = std(CFLUX,0,3);
clear CFLUX
CFLUX_avg = CFLUX_avg';
CFLUX_std = CFLUX_std';

[m,n] = size(CFLUX_avg);

for ii=1:m
    for jj=1:n
        if (CFLUX_avg(ii,jj)==0)
            CFLUX_avg(ii,jj) = NaN;
            CFLUX_std(ii,jj) = NaN;
        end
    end
end

save CFLUX_avg
save CFLUX_std
fprintf('Finished saving CFLUX\n')
clear
%%

%% oxygen flux
load('OFLUX.mat')

OFLUX_avg = mean(OFLUX,3);
OFLUX_std = std(OFLUX,0,3);
clear OFLUX
OFLUX_avg = OFLUX_avg';
OFLUX_std = OFLUX_std';

[m,n] = size(OFLUX_avg);

for ii=1:m
    for jj=1:n
        if (OFLUX_avg(ii,jj)==0)
            OFLUX_avg(ii,jj) = NaN;
            OFLUX_std(ii,jj) = NaN;
        end
    end
end

save OFLUX_avg
save OFLUX_std
fprintf('Finished saving OFLUX\n')
clear
%%

%% salt flux
load('SFLUX.mat')

PCO2_avg = mean(SFLUX,3);
PCO2_std = std(SFLUX,0,3);
clear SFLUX
PCO2_avg = PCO2_avg';
PCO2_std = PCO2_std';

[m,n] = size(PCO2_avg);

for ii=1:m
    for jj=1:n
        if (PCO2_avg(ii,jj)==0)
            PCO2_avg(ii,jj) = NaN;
            PCO2_std(ii,jj) = NaN;
        end
    end
end

save SFLUX_avg
save SFLUX_std
fprintf('Finished saving SFLUX\n')
clear
%%

%% CO2 concentration
load('PCO2.mat')

PCO2_avg = mean(PCO2,3);
PCO2_std = std(PCO2,0,3);
clear PCO2
PCO2_avg = PCO2_avg';
PCO2_std = PCO2_std';

[m,n] = size(PCO2_avg);

for ii=1:m
    for jj=1:n
        if (PCO2_avg(ii,jj)==0)
            PCO2_avg(ii,jj) = NaN;
            PCO2_std(ii,jj) = NaN;
        end
    end
end

save PCO2_avg
save PCO2_std
fprintf('Finished saving PCO2\n')
clear
%%

toc()