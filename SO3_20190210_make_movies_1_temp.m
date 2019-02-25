        dtstr_t = str2double(datestr(numdate,'yyyymmdd'));
        Obs_Array_t = SALT_Obs(SALT_Obs(:,1)==dtstr_t,[2,3,argo_depth(qq)]);
        
        dtstr_y1 = str2double(datestr(numdate-1,'yyyymmdd'));
        Obs_Array_y1 = SALT_Obs(SALT_Obs(:,1)==dtstr_y1,[2,3,argo_depth(qq)]);
        if ii>2
            dtstr_y2 = str2double(datestr(numdate-2,'yyyymmdd'));
            Obs_Array_y2 = SALT_Obs(SALT_Obs(:,1)==dtstr_y2,[2,3,argo_depth(qq)]);
        end
        if ii>3
            dtstr_y3 = str2double(datestr(numdate-3,'yyyymmdd'));
            Obs_Array_y3 = SALT_Obs(SALT_Obs(:,1)==dtstr_y3,[2,3,argo_depth(qq)]);
        end
        if ii<NZ
            dtstr_t1 = str2double(datestr(numdate+1,'yyyymmdd'));
            Obs_Array_t1 = SALT_Obs(SALT_Obs(:,1)==dtstr_t1,[2,3,argo_depth(qq)]);
        end
        if ii<NZ-1
            dtstr_t2 = str2double(datestr(numdate+2,'yyyymmdd'));
            Obs_Array_t2 = SALT_Obs(SALT_Obs(:,1)==dtstr_t2,[2,3,argo_depth(qq)]);
        end
        if ii<NZ-2
            dtstr_t3 = str2double(datestr(numdate+3,'yyyymmdd'));
            Obs_Array_t3 = SALT_Obs(SALT_Obs(:,1)==dtstr_t3,[2,3,argo_depth(qq)]);
        end