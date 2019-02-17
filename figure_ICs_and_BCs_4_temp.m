



for ii=1:60
    for jj=1:52
        VVEL_temp_temp = VVEL_temp(:,:,jj,ii);
        VVEL_temp_temp(hFacC(:,:,jj)==0) = NaN;
        VVEL_temp_temp = fillmissingstan(VVEL_temp_temp);
        VVEL_temp(:,:,jj,ii) = VVEL_temp_temp;
    end
end





