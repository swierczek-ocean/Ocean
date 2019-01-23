tic()
clc
clear
close all

XC = ncread('grid.nc','XC');
YC = ncread('grid.nc','YC');

X = XC(:,1);
Y = YC(1,:);

% lox = find(X>290,1);
% hix = find(X>349.9,1);
% loy = find(Y>-60.2,1);
% hiy = find(Y>-32.3,1);

lox = find(X>288.3,1);
hix = find(X>352,1);
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1);
NX = 1080;
NY = 315;

str1 = 'atm_pco2_capegrim_';
str2 = 'atm_pco2_capegrim_SO3_';
str3 = 'atm_pco2_carbontracker_';
str4 = 'atm_pco2_carbontracker_SO3_';

for ii=2005:2017
    temp_str = num2str(ii);
    temp_name = [str1,temp_str];
    fid = fopen(temp_name,'r','b');
    U = fread(fid,inf,'single');
    NZ = length(U)/NX/NY;
    A = reshape(U,[NX,NY,NZ]);
    fclose(fid);
    CO2 = A(lox:hix,loy:hiy,:);
    for jj=1:5
        CO2(jj,6:127,:) = CO2(6,6:127,:);
        CO2(6:187,jj,:) = CO2(6:187,6,:);
        CO2(187+jj,6:127,:) = CO2(187,6:127,:);
        CO2(6:187,127+jj,:) = CO2(6:187,127,:);
    end
    
    fid = fopen(temp_name,'w','b');
    fwrite(fid,CO2,'single');
    fclose(fid);
end

for ii=2005:2018
    temp_str = num2str(ii);
    temp_name = [str2,temp_str];
    fid = fopen(temp_name,'r','b');
    U = fread(fid,inf,'single');
    NZ = length(U)/NX/NY;
    A = reshape(U,[NX,NY,NZ]);
    fclose(fid);
    CO2 = A(lox:hix,loy:hiy,:);
    for jj=1:5
        CO2(jj,6:127,:) = CO2(6,6:127,:);
        CO2(6:187,jj,:) = CO2(6:187,6,:);
        CO2(187+jj,6:127,:) = CO2(187,6:127,:);
        CO2(6:187,127+jj,:) = CO2(6:187,127,:);
    end
    
    fid = fopen(temp_name,'w','b');
    fwrite(fid,CO2,'single');
    fclose(fid);
end

for ii=2005:2018
    temp_str = num2str(ii);
    temp_name = [str3,temp_str];
    fid = fopen(temp_name,'r','b');
    U = fread(fid,inf,'single');
    NZ = length(U)/NX/NY;
    A = reshape(U,[NX,NY,NZ]);
    fclose(fid);
    CO2 = A(lox:hix,loy:hiy,:);
    for jj=1:5
        CO2(jj,6:127,:) = CO2(6,6:127,:);
        CO2(6:187,jj,:) = CO2(6:187,6,:);
        CO2(187+jj,6:127,:) = CO2(187,6:127,:);
        CO2(6:187,127+jj,:) = CO2(6:187,127,:);
    end
    
    fid = fopen(temp_name,'w','b');
    fwrite(fid,CO2,'single');
    fclose(fid);
end

for ii=2005:2018
    temp_str = num2str(ii);
    temp_name = [str4,temp_str];
    fid = fopen(temp_name,'r','b');
    U = fread(fid,inf,'single');
    NZ = length(U)/NX/NY;
    A = reshape(U,[NX,NY,NZ]);
    fclose(fid);
    CO2 = A(lox:hix,loy:hiy,:);
    for jj=1:5
        CO2(jj,6:127,:) = CO2(6,6:127,:);
        CO2(6:187,jj,:) = CO2(6:187,6,:);
        CO2(187+jj,6:127,:) = CO2(187,6:127,:);
        CO2(6:187,127+jj,:) = CO2(6:187,127,:);
    end
    
    fid = fopen(temp_name,'w','b');
    fwrite(fid,CO2,'single');
    fclose(fid);
end

toc()