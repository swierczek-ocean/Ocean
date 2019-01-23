clear
close all
clc

%% SPEED
tic()
for qq=1:52
    set(0,'DefaultFigureVisible','on')
    set(gca, 'defaultUicontrolFontName', 'Ubuntu')
    set(gca, 'defaultUitableFontName', 'Ubuntu')
    set(gca, 'defaultAxesFontName', 'Ubuntu')
    set(gca, 'defaultTextFontName', 'Ubuntu')
    set(gca, 'defaultUipanelFontName', 'Ubuntu')
    delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
        10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
        20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
        100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
        300, 380, 400, 400, 400, 400, 400, 400, 400, 400];
    ACC_Colors
    ACC_Colormaps
    vv = 3;
    uu = 4;
    XC = rdmds('XC');
    YC = rdmds('YC');
    Temp_Series1 = zeros(192,132,60);
    Temp_Series2 = zeros(192,132,60);
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(:,:,qq,vv);
        Temp_Series2(:,:,ii) = temp(:,:,qq,uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(:,:,qq,vv);
        Temp_Series2(:,:,ii) = temp(:,:,qq,uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(:,:,qq,vv);
        Temp_Series2(:,:,ii) = temp(:,:,qq,uu);
    end
    
    Temp_Series = sqrt(Temp_Series1.^2 + Temp_Series2.^2);
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series(:,:,1);
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                    A(ii,jj) = NaN;
                end
            end
        end
    end
    
    lb = 0;
    ub = 1;
    A = isnan(A);
    z = linspace(lb,ub,11);
    
    XC = XC(:,end);
    YC = YC(end,:);
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1280, 720])
    colormap(colormap3)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    c = colorbar('eastoutside');
    c.Label.String = 'm/s';
    caxis([lb ub])
    axis(coords)
    title(['speed at depth ',num2str(sum(delZ(1:qq-1))),' m'],'FontName','Ubuntu')
    xlabel('Latitude','FontName','Ubuntu')
    ylabel('Longitude','FontName','Ubuntu')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) + 0.01;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) - 0.03;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.02;
    ax.Position = [left bottom ax_width ax_height];
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['SPEED_',num2str(qq),'.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        c = colorbar('eastoutside');
        c.Label.String = 'm/s';
        caxis([lb ub])
        axis(coords)
        title(['speed at depth ',num2str(sum(delZ(1:qq-1))),' m'])
        xlabel('Latitude')
        ylabel('Longitude')
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create SPEED movies: %g\n',time)
% clear
%% end SPEED