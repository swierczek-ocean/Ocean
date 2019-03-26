
clear
close all
clc

tic()
acc_settings
load BGCObs
load mask
load Obs_DO_350

mask = permute(mask,[2,1,3]);
rr = 180;
hh = 616;

XC = rdmds('XC');
YC = rdmds('YC');
HC = rdmds('hFacC');
XC = XC(:,end);
YC = YC(end,:);

XC = XC(6:rr);
YC = YC(6:127);
HC = HC(6:rr,6:127,:);

XCm = XCm(1:hh);
mask = mask(:,1:hh,:);

vl = [4,16,27,30,36,41];
depth_names = [20,135,350,500,1000,1800];
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
argo_depth = [10,33,52,58,69,78];
nn = 182;
mm = 122;
nlvls = 200;
str1 = '_mitgcm_ts_vl_';
str2 = '_bsose_ts_vl_';
strng = 'ice';
cm = acc_colormap(strng);
cm = flipud(cm);
cm = [cm(1,:);cm(1,:);cm(1,:);cm(1,:);cm;Color(:,46)'];

for qq=2:2
    
    numdate = 736665;
    temp_str = num2str(vl(qq));
    temp_name = ['../SO3_20190210/diag/DIC',str1,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Um = fread(fid,inf,'single');
    NZ = length(Um)/nn/mm;
    Um = reshape(Um,[nn,mm,NZ]);
    fclose(fid);
    Um = Um(1:rr-5,:,:);
    Um = permute(Um,[2,1,3]);
    
    temp_name = ['DIC',str2,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Ub = fread(fid,inf,'single');
    NZ = length(Ub)/nn/mm;
    Ub = reshape(Ub,[nn,mm,NZ]);
    fclose(fid);
    Ub = Ub(1:rr-5,:,:);
    Ub = permute(Ub,[2,1,3]);
    
    if qq==1
        lb = 2;
        ub = 2.4;
    end
    if qq==2
        lb = 2.05;
        ub = 2.45;
    end
    %     if qq==3
    %         lb = 0;
    %         ub = 17;
    %     end
    %     if qq==4
    %         lb = 0;
    %         ub = 13.5;
    %     end
    %     if qq==5
    %         ub = 7;
    %         lb = 0;
    %     end
    %     if qq==6
    %         ub = 3.5;
    %         lb = -0.5;
    %     end
    z = linspace(lb,ub,nlvls);
    z = [0,1,1.45,1.9,z,9999998];
    DIC_LIAR_Obs_Array_t = [DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
        DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
        DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
        DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
        DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
    
    DIC_LIAR_Obs_Array_t = DIC_LIAR_Obs_Array_t(isnan(DIC_LIAR_Obs_Array_t(:,3))==0,:);
    
    figure()
    set(gcf, 'Position', [1, 1, 1900, 900])
    colormap(cm)
    subplot(1,2,1);
    contourf(XC,YC,Um(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),osz,'w','filled')
    scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),sz,DIC_LIAR_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['MITGCM + BLING vs. BGC-Argo DIC (mol C/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_1
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Ub(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),osz,'w','filled')
    scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),sz,DIC_LIAR_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['BSOSE vs. BGC-Argo DIC (mol C/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_2
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    print(['DIC_',datestr(numdate,'yyyymmdd')],'-djpeg')
    close all
    
    
    for ii=2:NZ
        numdate = numdate + 5;
        
        DIC_LIAR_Obs_Array_t = [DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
        DIC_LIAR_Obs_Array_t = DIC_LIAR_Obs_Array_t(isnan(DIC_LIAR_Obs_Array_t(:,3))==0,:);
        
        
        DIC_LIAR_Obs_Array_y1 = [DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-1,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-2,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-3,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-4,[2,3,argo_depth(qq)]);...
            DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-5,[2,3,argo_depth(qq)])];
        DIC_LIAR_Obs_Array_y1 = DIC_LIAR_Obs_Array_y1(isnan(DIC_LIAR_Obs_Array_y1(:,3))==0,:);
        
        if ii>2
            DIC_LIAR_Obs_Array_y2 = [DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-6,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-7,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-8,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-9,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate-10,[2,3,argo_depth(qq)])];
            DIC_LIAR_Obs_Array_y2 = DIC_LIAR_Obs_Array_y2(isnan(DIC_LIAR_Obs_Array_y2(:,3))==0,:);
        end
        if ii<NZ
            DIC_LIAR_Obs_Array_t1 = [DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+5,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+6,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+7,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+8,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+9,[2,3,argo_depth(qq)])];
            DIC_LIAR_Obs_Array_t1 = DIC_LIAR_Obs_Array_t1(isnan(DIC_LIAR_Obs_Array_t1(:,3))==0,:);
        end
        if ii<NZ-1
            DIC_LIAR_Obs_Array_t2 = [DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+10,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+11,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+12,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+13,[2,3,argo_depth(qq)]);...
                DIC_LIAR_Obs(DIC_LIAR_Obs(:,1)==numdate+14,[2,3,argo_depth(qq)])];
            DIC_LIAR_Obs_Array_t2 = DIC_LIAR_Obs_Array_t2(isnan(DIC_LIAR_Obs_Array_t2(:,3))==0,:);
        end
        figure()
        set(gcf, 'Position', [1, 1, 1900, 900])
        colormap(cm)
        subplot(1,2,1);
        contourf(XC,YC,Um(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),osz,'w','filled')
        scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),sz,DIC_LIAR_Obs_Array_t(:,3),'filled')
        scatter(DIC_LIAR_Obs_Array_y1(:,1),DIC_LIAR_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(DIC_LIAR_Obs_Array_y1(:,1),DIC_LIAR_Obs_Array_y1(:,2),0.80*sz,DIC_LIAR_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(DIC_LIAR_Obs_Array_y2(:,1),DIC_LIAR_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(DIC_LIAR_Obs_Array_y2(:,1),DIC_LIAR_Obs_Array_y2(:,2),0.65*sz,DIC_LIAR_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(DIC_LIAR_Obs_Array_t1(:,1),DIC_LIAR_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(DIC_LIAR_Obs_Array_t1(:,1),DIC_LIAR_Obs_Array_t1(:,2),0.80*sz,DIC_LIAR_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(DIC_LIAR_Obs_Array_t2(:,1),DIC_LIAR_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(DIC_LIAR_Obs_Array_t2(:,1),DIC_LIAR_Obs_Array_t2(:,2),0.65*sz,DIC_LIAR_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('MITGCM + BLING vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_1
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Ub(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),osz,'w','filled')
        scatter(DIC_LIAR_Obs_Array_t(:,1),DIC_LIAR_Obs_Array_t(:,2),sz,DIC_LIAR_Obs_Array_t(:,3),'filled')
        scatter(DIC_LIAR_Obs_Array_y1(:,1),DIC_LIAR_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(DIC_LIAR_Obs_Array_y1(:,1),DIC_LIAR_Obs_Array_y1(:,2),0.80*sz,DIC_LIAR_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(DIC_LIAR_Obs_Array_y2(:,1),DIC_LIAR_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(DIC_LIAR_Obs_Array_y2(:,1),DIC_LIAR_Obs_Array_y2(:,2),0.65*sz,DIC_LIAR_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(DIC_LIAR_Obs_Array_t1(:,1),DIC_LIAR_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(DIC_LIAR_Obs_Array_t1(:,1),DIC_LIAR_Obs_Array_t1(:,2),0.80*sz,DIC_LIAR_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(DIC_LIAR_Obs_Array_t2(:,1),DIC_LIAR_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(DIC_LIAR_Obs_Array_t2(:,1),DIC_LIAR_Obs_Array_t2(:,2),0.65*sz,DIC_LIAR_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('BSOSE vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_2
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        print(['DIC_',datestr(numdate,'yyyymmdd')],'-djpeg')
        close all
    end
    
    
    close all
    clear z U*
end


strng = 'dawn';
cm = acc_colormap(strng);

cm = [cm(1,:);cm(1,:);cm(1,:);cm;Color(:,46)'];


for qq=2:0
    numdate = 736665;
    temp_str = num2str(vl(qq));
    temp_name = ['../SO3_20190210/diag/ALK',str1,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Um = fread(fid,inf,'single');
    NZ = length(Um)/nn/mm;
    Um = reshape(Um,[nn,mm,NZ]);
    fclose(fid);
    Um = Um(1:rr-5,:,:);
    Um = permute(Um,[2,1,3]);
    
    temp_name = ['Alk',str2,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Ub = fread(fid,inf,'single');
    NZ = length(Ub)/nn/mm;
    Ub = reshape(Ub,[nn,mm,NZ]);
    fclose(fid);
    Ub = Ub(1:rr-5,:,:);
    Ub = permute(Ub,[2,1,3]);
    
    if qq==1
        lb = 2.21;
        ub = 2.5;
    end
    if qq==2
        lb = 2.25;
        ub = 2.45;
    end
    %     if qq==3
    %         lb = 33;
    %         ub = 36;
    %     end
    %     if qq==4
    %         lb = 33.6;
    %         ub = 35.5;
    %     end
    %     if qq==5
    %         ub = 35;
    %         lb = 34;
    %     end
    %     if qq==6
    %         ub = 35;
    %         lb = 34.4;
    %     end
    
    z = linspace(lb,ub,nlvls);
    z = [1,1.5,2,z,9999998];
    
    ALK_LIAR_Obs_Array_t = [ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
        ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
        ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
        ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
        ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
    
    ALK_LIAR_Obs_Array_t = ALK_LIAR_Obs_Array_t(isnan(ALK_LIAR_Obs_Array_t(:,3))==0,:);
    
    figure()
    set(gcf, 'Position', [1, 1, 1900, 900])
    colormap(cm)
    subplot(1,2,1);
    contourf(XC,YC,Um(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),osz,'w','filled')
    scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),sz,ALK_LIAR_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['MITGCM + BLING vs. BGC-Argo alkalinity (mol eq) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_1
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Ub(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),osz,'w','filled')
    scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),sz,ALK_LIAR_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['BSOSE vs. BGC-Argo alkalinity (mol eq) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_2
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    print(['ALK_',datestr(numdate,'yyyymmdd')],'-djpeg')
    close all
    
    for ii=2:NZ
        numdate = numdate + 5;
        
        ALK_LIAR_Obs_Array_t = [ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
        ALK_LIAR_Obs_Array_t = ALK_LIAR_Obs_Array_t(isnan(ALK_LIAR_Obs_Array_t(:,3))==0,:);
        
        
        ALK_LIAR_Obs_Array_y1 = [ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-1,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-2,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-3,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-4,[2,3,argo_depth(qq)]);...
            ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-5,[2,3,argo_depth(qq)])];
        ALK_LIAR_Obs_Array_y1 = ALK_LIAR_Obs_Array_y1(isnan(ALK_LIAR_Obs_Array_y1(:,3))==0,:);
        
        if ii>2
            ALK_LIAR_Obs_Array_y2 = [ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-6,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-7,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-8,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-9,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate-10,[2,3,argo_depth(qq)])];
            ALK_LIAR_Obs_Array_y2 = ALK_LIAR_Obs_Array_y2(isnan(ALK_LIAR_Obs_Array_y2(:,3))==0,:);
        end
        if ii<NZ
            ALK_LIAR_Obs_Array_t1 = [ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+5,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+6,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+7,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+8,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+9,[2,3,argo_depth(qq)])];
            ALK_LIAR_Obs_Array_t1 = ALK_LIAR_Obs_Array_t1(isnan(ALK_LIAR_Obs_Array_t1(:,3))==0,:);
        end
        if ii<NZ-1
            ALK_LIAR_Obs_Array_t2 = [ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+10,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+11,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+12,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+13,[2,3,argo_depth(qq)]);...
                ALK_LIAR_Obs(ALK_LIAR_Obs(:,1)==numdate+14,[2,3,argo_depth(qq)])];
            ALK_LIAR_Obs_Array_t2 = ALK_LIAR_Obs_Array_t2(isnan(ALK_LIAR_Obs_Array_t2(:,3))==0,:);
        end
        figure()
        set(gcf, 'Position', [1, 1, 1900, 900])
        colormap(cm)
        subplot(1,2,1);
        contourf(XC,YC,Um(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),osz,'w','filled')
        scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),sz,ALK_LIAR_Obs_Array_t(:,3),'filled')
        scatter(ALK_LIAR_Obs_Array_y1(:,1),ALK_LIAR_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(ALK_LIAR_Obs_Array_y1(:,1),ALK_LIAR_Obs_Array_y1(:,2),0.80*sz,ALK_LIAR_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(ALK_LIAR_Obs_Array_y2(:,1),ALK_LIAR_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(ALK_LIAR_Obs_Array_y2(:,1),ALK_LIAR_Obs_Array_y2(:,2),0.65*sz,ALK_LIAR_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(ALK_LIAR_Obs_Array_t1(:,1),ALK_LIAR_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(ALK_LIAR_Obs_Array_t1(:,1),ALK_LIAR_Obs_Array_t1(:,2),0.80*sz,ALK_LIAR_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(ALK_LIAR_Obs_Array_t2(:,1),ALK_LIAR_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(ALK_LIAR_Obs_Array_t2(:,1),ALK_LIAR_Obs_Array_t2(:,2),0.65*sz,ALK_LIAR_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('MITGCM + BLING vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_1
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Ub(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),osz,'w','filled')
        scatter(ALK_LIAR_Obs_Array_t(:,1),ALK_LIAR_Obs_Array_t(:,2),sz,ALK_LIAR_Obs_Array_t(:,3),'filled')
        scatter(ALK_LIAR_Obs_Array_y1(:,1),ALK_LIAR_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(ALK_LIAR_Obs_Array_y1(:,1),ALK_LIAR_Obs_Array_y1(:,2),0.80*sz,ALK_LIAR_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(ALK_LIAR_Obs_Array_y2(:,1),ALK_LIAR_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(ALK_LIAR_Obs_Array_y2(:,1),ALK_LIAR_Obs_Array_y2(:,2),0.65*sz,ALK_LIAR_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(ALK_LIAR_Obs_Array_t1(:,1),ALK_LIAR_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(ALK_LIAR_Obs_Array_t1(:,1),ALK_LIAR_Obs_Array_t1(:,2),0.80*sz,ALK_LIAR_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(ALK_LIAR_Obs_Array_t2(:,1),ALK_LIAR_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(ALK_LIAR_Obs_Array_t2(:,1),ALK_LIAR_Obs_Array_t2(:,2),0.65*sz,ALK_LIAR_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('BSOSE vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_2
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        print(['ALK_',datestr(numdate,'yyyymmdd')],'-djpeg')
        close all
    end
    
    
    close all
    clear z U*
end

strng = 'purplegreen';
cm = acc_colormap(strng);

cm = [Color(:,46)';cm;Color(:,46)'];

for qq=2:2
    numdate = 736665;
    temp_str = num2str(vl(qq));
    temp_name = ['../SO3_20190210/diag/NO3',str1,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Um = fread(fid,inf,'single');
    NZ = length(Um)/nn/mm;
    Um = reshape(Um,[nn,mm,NZ]);
    fclose(fid);
    Um = Um(1:rr-5,:,:);
    Um = permute(Um,[2,1,3]);
    
    temp_name = ['NO3',str2,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Ub = fread(fid,inf,'single');
    NZ = length(Ub)/nn/mm;
    Ub = reshape(Ub,[nn,mm,NZ]);
    fclose(fid);
    Ub = Ub(1:rr-5,:,:);
    Ub = permute(Ub,[2,1,3]);
    
    if qq==1
        lb = -0.00325;
        ub = 0.0325;
    end
    if qq==2
        lb = 0;
        ub = 0.035;
    end
    %     if qq==3
    %         lb = 33;
    %         ub = 36;
    %     end
    %     if qq==4
    %         lb = 33.6;
    %         ub = 35.5;
    %     end
    %     if qq==5
    %         ub = 35;
    %         lb = 34;
    %     end
    %     if qq==6
    %         ub = 35;
    %         lb = 34.4;
    %     end
    
    z = linspace(lb,ub,nlvls);
    z = [-100000,z,9999998];
    
    NO3_Obs_Array_t = [NO3_Obs(NO3_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
        NO3_Obs(NO3_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
        NO3_Obs(NO3_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
        NO3_Obs(NO3_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
        NO3_Obs(NO3_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
    
    NO3_Obs_Array_t = NO3_Obs_Array_t(isnan(NO3_Obs_Array_t(:,3))==0,:);
    
    figure()
    set(gcf, 'Position', [1, 1, 1900, 900])
    colormap(cm)
    subplot(1,2,1);
    contourf(XC,YC,Um(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),osz,'w','filled')
    scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),sz,NO3_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('MITGCM + BLING vs. BGC-Argo','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_1
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Ub(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),osz,'w','filled')
    scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),sz,NO3_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('BSOSE vs. BGC-Argo','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_2
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    print(['NO_',datestr(numdate,'yyyymmdd')],'-djpeg')
    close all
    
    for ii=2:NZ
        numdate = numdate + 5;
        
        NO3_Obs_Array_t = [NO3_Obs(NO3_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
        NO3_Obs_Array_t = NO3_Obs_Array_t(isnan(NO3_Obs_Array_t(:,3))==0,:);
        
        
        NO3_Obs_Array_y1 = [NO3_Obs(NO3_Obs(:,1)==numdate-1,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate-2,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate-3,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate-4,[2,3,argo_depth(qq)]);...
            NO3_Obs(NO3_Obs(:,1)==numdate-5,[2,3,argo_depth(qq)])];
        NO3_Obs_Array_y1 = NO3_Obs_Array_y1(isnan(NO3_Obs_Array_y1(:,3))==0,:);
        
        if ii>2
            NO3_Obs_Array_y2 = [NO3_Obs(NO3_Obs(:,1)==numdate-6,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate-7,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate-8,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate-9,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate-10,[2,3,argo_depth(qq)])];
            NO3_Obs_Array_y2 = NO3_Obs_Array_y2(isnan(NO3_Obs_Array_y2(:,3))==0,:);
        end
        if ii<NZ
            NO3_Obs_Array_t1 = [NO3_Obs(NO3_Obs(:,1)==numdate+5,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+6,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+7,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+8,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+9,[2,3,argo_depth(qq)])];
            NO3_Obs_Array_t1 = NO3_Obs_Array_t1(isnan(NO3_Obs_Array_t1(:,3))==0,:);
        end
        if ii<NZ-1
            NO3_Obs_Array_t2 = [NO3_Obs(NO3_Obs(:,1)==numdate+10,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+11,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+12,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+13,[2,3,argo_depth(qq)]);...
                NO3_Obs(NO3_Obs(:,1)==numdate+14,[2,3,argo_depth(qq)])];
            NO3_Obs_Array_t2 = NO3_Obs_Array_t2(isnan(NO3_Obs_Array_t2(:,3))==0,:);
        end
        figure()
        set(gcf, 'Position', [1, 1, 1900, 900])
        colormap(cm)
        subplot(1,2,1);
        contourf(XC,YC,Um(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),osz,'w','filled')
        scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),sz,NO3_Obs_Array_t(:,3),'filled')
        scatter(NO3_Obs_Array_y1(:,1),NO3_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(NO3_Obs_Array_y1(:,1),NO3_Obs_Array_y1(:,2),0.80*sz,NO3_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(NO3_Obs_Array_y2(:,1),NO3_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(NO3_Obs_Array_y2(:,1),NO3_Obs_Array_y2(:,2),0.65*sz,NO3_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(NO3_Obs_Array_t1(:,1),NO3_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(NO3_Obs_Array_t1(:,1),NO3_Obs_Array_t1(:,2),0.80*sz,NO3_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(NO3_Obs_Array_t2(:,1),NO3_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(NO3_Obs_Array_t2(:,1),NO3_Obs_Array_t2(:,2),0.65*sz,NO3_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('MITGCM + BLING vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_1
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Ub(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),osz,'w','filled')
        scatter(NO3_Obs_Array_t(:,1),NO3_Obs_Array_t(:,2),sz,NO3_Obs_Array_t(:,3),'filled')
        scatter(NO3_Obs_Array_y1(:,1),NO3_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(NO3_Obs_Array_y1(:,1),NO3_Obs_Array_y1(:,2),0.80*sz,NO3_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(NO3_Obs_Array_y2(:,1),NO3_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(NO3_Obs_Array_y2(:,1),NO3_Obs_Array_y2(:,2),0.65*sz,NO3_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(NO3_Obs_Array_t1(:,1),NO3_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(NO3_Obs_Array_t1(:,1),NO3_Obs_Array_t1(:,2),0.80*sz,NO3_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(NO3_Obs_Array_t2(:,1),NO3_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(NO3_Obs_Array_t2(:,1),NO3_Obs_Array_t2(:,2),0.65*sz,NO3_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('BSOSE vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_2
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        print(['NO_',datestr(numdate,'yyyymmdd')],'-djpeg')
        close all
    end
    
    
    close all
    clear z U*
end


strng = 'fire';
cm = acc_colormap(strng);

cm = [Color(:,46)';cm;Color(:,46)'];

for qq=2:2
    numdate = 736665;
    temp_str = num2str(vl(qq));
    temp_name = ['../SO3_20190210/diag/O2',str1,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Um = fread(fid,inf,'single');
    NZ = length(Um)/nn/mm;
    Um = reshape(Um,[nn,mm,NZ]);
    fclose(fid);
    Um = Um(1:rr-5,:,:);
    Um = permute(Um,[2,1,3]);
    
    temp_name = ['O2',str2,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Ub = fread(fid,inf,'single');
    NZ = length(Ub)/nn/mm;
    Ub = reshape(Ub,[nn,mm,NZ]);
    fclose(fid);
    Ub = Ub(1:rr-5,:,:);
    Ub = permute(Ub,[2,1,3]);
    
    if qq==1
        lb = 0.15;
        ub = 0.40;
    end
    if qq==2
        lb = 0.125;
        ub = 0.4;
    end
    %     if qq==3
    %         lb = 33;
    %         ub = 36;
    %     end
    %     if qq==4
    %         lb = 33.6;
    %         ub = 35.5;
    %     end
    %     if qq==5
    %         ub = 35;
    %         lb = 34;
    %     end
    %     if qq==6
    %         ub = 35;
    %         lb = 34.4;
    %     end
    
    z = linspace(lb,ub,nlvls);
    z = [-100000,z,9999998];
    
    O2_Obs_Array_t = [O2_Obs(O2_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
        O2_Obs(O2_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
        O2_Obs(O2_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
        O2_Obs(O2_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
        O2_Obs(O2_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
    
    O2_Obs_Array_t = O2_Obs_Array_t(isnan(O2_Obs_Array_t(:,3))==0,:);
    
    figure()
    set(gcf, 'Position', [1, 1, 1900, 900])
    colormap(cm)
    subplot(1,2,1);
    contourf(XC,YC,Um(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),osz,'w','filled')
    scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),sz,O2_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['MITGCM + BLING vs. BGC-Argo dissolved oxygen (mol O/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_1
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Ub(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),osz,'w','filled')
    scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),sz,O2_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['BSOSE vs. BGC-Argo dissolved oxygen (mol O/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_2
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    print(['O2_',datestr(numdate,'yyyymmdd')],'-djpeg')
    close all
    
    for ii=2:NZ
        numdate = numdate + 5;
        
        O2_Obs_Array_t = [O2_Obs(O2_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
        O2_Obs_Array_t = O2_Obs_Array_t(isnan(O2_Obs_Array_t(:,3))==0,:);
        
        
        O2_Obs_Array_y1 = [O2_Obs(O2_Obs(:,1)==numdate-1,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate-2,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate-3,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate-4,[2,3,argo_depth(qq)]);...
            O2_Obs(O2_Obs(:,1)==numdate-5,[2,3,argo_depth(qq)])];
        O2_Obs_Array_y1 = O2_Obs_Array_y1(isnan(O2_Obs_Array_y1(:,3))==0,:);
        
        if ii>2
            O2_Obs_Array_y2 = [O2_Obs(O2_Obs(:,1)==numdate-6,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate-7,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate-8,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate-9,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate-10,[2,3,argo_depth(qq)])];
            O2_Obs_Array_y2 = O2_Obs_Array_y2(isnan(O2_Obs_Array_y2(:,3))==0,:);
        end
        if ii<NZ
            O2_Obs_Array_t1 = [O2_Obs(O2_Obs(:,1)==numdate+5,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+6,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+7,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+8,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+9,[2,3,argo_depth(qq)])];
            O2_Obs_Array_t1 = O2_Obs_Array_t1(isnan(O2_Obs_Array_t1(:,3))==0,:);
        end
        if ii<NZ-1
            O2_Obs_Array_t2 = [O2_Obs(O2_Obs(:,1)==numdate+10,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+11,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+12,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+13,[2,3,argo_depth(qq)]);...
                O2_Obs(O2_Obs(:,1)==numdate+14,[2,3,argo_depth(qq)])];
            O2_Obs_Array_t2 = O2_Obs_Array_t2(isnan(O2_Obs_Array_t2(:,3))==0,:);
        end
        figure()
        set(gcf, 'Position', [1, 1, 1900, 900])
        colormap(cm)
        subplot(1,2,1);
        contourf(XC,YC,Um(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),osz,'w','filled')
        scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),sz,O2_Obs_Array_t(:,3),'filled')
        scatter(O2_Obs_Array_y1(:,1),O2_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(O2_Obs_Array_y1(:,1),O2_Obs_Array_y1(:,2),0.80*sz,O2_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(O2_Obs_Array_y2(:,1),O2_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(O2_Obs_Array_y2(:,1),O2_Obs_Array_y2(:,2),0.65*sz,O2_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(O2_Obs_Array_t1(:,1),O2_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(O2_Obs_Array_t1(:,1),O2_Obs_Array_t1(:,2),0.80*sz,O2_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(O2_Obs_Array_t2(:,1),O2_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(O2_Obs_Array_t2(:,1),O2_Obs_Array_t2(:,2),0.65*sz,O2_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('MITGCM + BLING vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_1
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Ub(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),osz,'w','filled')
        scatter(O2_Obs_Array_t(:,1),O2_Obs_Array_t(:,2),sz,O2_Obs_Array_t(:,3),'filled')
        scatter(O2_Obs_Array_y1(:,1),O2_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(O2_Obs_Array_y1(:,1),O2_Obs_Array_y1(:,2),0.80*sz,O2_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(O2_Obs_Array_y2(:,1),O2_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(O2_Obs_Array_y2(:,1),O2_Obs_Array_y2(:,2),0.65*sz,O2_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(O2_Obs_Array_t1(:,1),O2_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(O2_Obs_Array_t1(:,1),O2_Obs_Array_t1(:,2),0.80*sz,O2_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(O2_Obs_Array_t2(:,1),O2_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(O2_Obs_Array_t2(:,1),O2_Obs_Array_t2(:,2),0.65*sz,O2_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title('BSOSE vs. BGC-Argo','FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_2
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        print(['O2_',datestr(numdate,'yyyymmdd')],'-djpeg')
        close all
    end
    
    
    close all
    clear z U*
end

strng = 'kryptonite';
cm = acc_colormap(strng);

cm = [Color(:,46)';cm;Color(:,46)'];

for qq=2:2
    numdate = 736665;
    temp_str = num2str(vl(qq));
    temp_name = ['../SO3_20190210/diag/PO4',str1,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Um = fread(fid,inf,'single');
    NZ = length(Um)/nn/mm;
    Um = reshape(Um,[nn,mm,NZ]);
    fclose(fid);
    Um = Um(1:rr-5,:,:);
    Um = permute(Um,[2,1,3]);
    
    temp_name = ['PO4',str2,temp_str,'.bin'];
    fid = fopen(temp_name,'r','b');
    Ub = fread(fid,inf,'single');
    NZ = length(Ub)/nn/mm;
    Ub = reshape(Ub,[nn,mm,NZ]);
    fclose(fid);
    Ub = Ub(1:rr-5,:,:);
    Ub = permute(Ub,[2,1,3]);
    
    if qq==1
        lb = 0.15;
        ub = 0.40;
    end
    if qq==2
        lb = 0.125;
        ub = 0.4;
    end
    %     if qq==3
    %         lb = 33;
    %         ub = 36;
    %     end
    %     if qq==4
    %         lb = 33.6;
    %         ub = 35.5;
    %     end
    %     if qq==5
    %         ub = 35;
    %         lb = 34;
    %     end
    %     if qq==6
    %         ub = 35;
    %         lb = 34.4;
    %     end
    
    z = linspace(lb,ub,nlvls);
    z = [-100000,z,9999998];
    
    PO4_Obs_Array_t = [PO4_Obs(PO4_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
        PO4_Obs(PO4_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
        PO4_Obs(PO4_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
        PO4_Obs(PO4_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
        PO4_Obs(PO4_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
    
    PO4_Obs_Array_t = PO4_Obs_Array_t(isnan(PO4_Obs_Array_t(:,3))==0,:);
    
    figure()
    set(gcf, 'Position', [1, 1, 1900, 900])
    colormap(cm)
    subplot(1,2,1);
    contourf(XC,YC,Um(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),osz,'w','filled')
    scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),sz,PO4_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['MITGCM + BLING vs. BGC-Argo phosphate (mol PO4/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_1
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Ub(:,:,1),'LineStyle','none','LevelList',z);
    cbar = colorbar('southoutside');
    set(cbar,'XLim',[lb ub]);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),osz,'w','filled')
    scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),sz,PO4_Obs_Array_t(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['BSOSE vs. BGC-Argo phosphate (mol PO4/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
    acc_movie
    acc_sbs_plots_2
    % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
    print(['PO4_',datestr(numdate,'yyyymmdd')],'-djpeg')
    close all
    
    for ii=2:NZ
        numdate = numdate + 5;
        
        PO4_Obs_Array_t = [PO4_Obs(PO4_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate+4,[2,3,argo_depth(qq)])];
        PO4_Obs_Array_t = PO4_Obs_Array_t(isnan(PO4_Obs_Array_t(:,3))==0,:);
        
        
        PO4_Obs_Array_y1 = [PO4_Obs(PO4_Obs(:,1)==numdate-1,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate-2,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate-3,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate-4,[2,3,argo_depth(qq)]);...
            PO4_Obs(PO4_Obs(:,1)==numdate-5,[2,3,argo_depth(qq)])];
        PO4_Obs_Array_y1 = PO4_Obs_Array_y1(isnan(PO4_Obs_Array_y1(:,3))==0,:);
        
        if ii>2
            PO4_Obs_Array_y2 = [PO4_Obs(PO4_Obs(:,1)==numdate-6,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate-7,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate-8,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate-9,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate-10,[2,3,argo_depth(qq)])];
            PO4_Obs_Array_y2 = PO4_Obs_Array_y2(isnan(PO4_Obs_Array_y2(:,3))==0,:);
        end
        if ii<NZ
            PO4_Obs_Array_t1 = [PO4_Obs(PO4_Obs(:,1)==numdate+5,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+6,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+7,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+8,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+9,[2,3,argo_depth(qq)])];
            PO4_Obs_Array_t1 = PO4_Obs_Array_t1(isnan(PO4_Obs_Array_t1(:,3))==0,:);
        end
        if ii<NZ-1
            PO4_Obs_Array_t2 = [PO4_Obs(PO4_Obs(:,1)==numdate+10,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+11,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+12,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+13,[2,3,argo_depth(qq)]);...
                PO4_Obs(PO4_Obs(:,1)==numdate+14,[2,3,argo_depth(qq)])];
            PO4_Obs_Array_t2 = PO4_Obs_Array_t2(isnan(PO4_Obs_Array_t2(:,3))==0,:);
        end
        
        figure()
        set(gcf, 'Position', [1, 1, 1900, 900])
        colormap(cm)
        subplot(1,2,1);
        contourf(XC,YC,Um(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),osz,'w','filled')
        scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),sz,PO4_Obs_Array_t(:,3),'filled')
        scatter(PO4_Obs_Array_y1(:,1),PO4_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(PO4_Obs_Array_y1(:,1),PO4_Obs_Array_y1(:,2),0.80*sz,PO4_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(PO4_Obs_Array_y2(:,1),PO4_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(PO4_Obs_Array_y2(:,1),PO4_Obs_Array_y2(:,2),0.65*sz,PO4_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(PO4_Obs_Array_t1(:,1),PO4_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(PO4_Obs_Array_t1(:,1),PO4_Obs_Array_t1(:,2),0.80*sz,PO4_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(PO4_Obs_Array_t2(:,1),PO4_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(PO4_Obs_Array_t2(:,1),PO4_Obs_Array_t2(:,2),0.65*sz,PO4_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title(['MITGCM + BLING vs. BGC-Argo phosphate (mol PO4/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_1
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Ub(:,:,ii),'LineStyle','none','LevelList',z);
        cbar = colorbar('southoutside');
        set(cbar,'XLim',[lb ub]);
        hold on
        contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
        scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),osz,'w','filled')
        scatter(PO4_Obs_Array_t(:,1),PO4_Obs_Array_t(:,2),sz,PO4_Obs_Array_t(:,3),'filled')
        scatter(PO4_Obs_Array_y1(:,1),PO4_Obs_Array_y1(:,2),0.80*osz,'w','filled')
        scatter(PO4_Obs_Array_y1(:,1),PO4_Obs_Array_y1(:,2),0.80*sz,PO4_Obs_Array_y1(:,3),'filled')
        if ii>2
            scatter(PO4_Obs_Array_y2(:,1),PO4_Obs_Array_y2(:,2),0.65*osz,'w','filled')
            scatter(PO4_Obs_Array_y2(:,1),PO4_Obs_Array_y2(:,2),0.65*sz,PO4_Obs_Array_y2(:,3),'filled')
        end
        if ii<NZ
            scatter(PO4_Obs_Array_t1(:,1),PO4_Obs_Array_t1(:,2),0.80*osz,'w','filled')
            scatter(PO4_Obs_Array_t1(:,1),PO4_Obs_Array_t1(:,2),0.80*sz,PO4_Obs_Array_t1(:,3),'filled')
        end
        if ii<NZ-1
            scatter(PO4_Obs_Array_t2(:,1),PO4_Obs_Array_t2(:,2),0.65*osz,'w','filled')
            scatter(PO4_Obs_Array_t2(:,1),PO4_Obs_Array_t2(:,2),0.65*sz,PO4_Obs_Array_t2(:,3),'filled')
        end
        caxis([lb ub])
        axis(coords)
        title(['BSOSE vs. BGC-Argo phosphate (mol PO4/m) at ',num2str(depth_names(qq)),'m depth'],'FontWeight','Normal','FontSize',16)
        xtickformat('degrees')
        ytickformat('degrees')
        acc_movie
        acc_sbs_plots_2
        % text(291.5,-34,datestr(numdate,'yyyy mmm'),'FontSize',28,'Color','w')
        hold off
        print(['PO4_',datestr(numdate,'yyyymmdd')],'-djpeg')
        close all
    end
    
    
    close all
    clear z U*
end

toc()