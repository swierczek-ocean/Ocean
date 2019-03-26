close all
clear
clc

% %% UVEL
% tic()
% for qq=1:10
%     ACC_Settings
%     
%     delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
%         10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
%         20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
%         100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
%         300, 380, 400, 400, 400, 400, 400, 400, 400, 400];
%     
%     uu = 3;
%     Q = [1,2,6,10,13,21,29,31,40,46];
%     
%     XC = rdmds('XC');
%     YC = rdmds('YC');
%     XC = XC(:,end);
%     YC = YC(649,:);
%     XCs = rdmds('1XC');
%     YCs = rdmds('1YC');
%     XCs = XCs(:,end);
%     YCs = YCs(end,:);
%     lox = find(XC>289.99,1);
%     hix = find(XC>335.99,1);
%     loy = find(YC>-59.3,1);
%     hiy = find(YC>-32,1);
%     loxx = find(XCs>289.99,1);
%     hixx = find(XCs>335.99,1);
%     loyy = find(YCs>-59.3,1);
%     hiyy = find(YCs>-32,1);
%     XC = XC(lox:hix);
%     YC = YC(loy:hiy);
%     XCs = XCs(loxx:hixx);
%     YCs = YCs(loyy:hiyy);
%     n = length(XC);
%     m = length(YC);
%     n1 = length(XCs);
%     m1 = length(YCs);
%     
%     
%     Temp_Series1 = zeros(n,m,60);
%     
%     Temp_Series4 = zeros(n1,m1,60);
%     
%     
%     for ii=1:4
%         char = ['diag_state.00000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.00000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     for ii=5:41
%         char = ['diag_state.0000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.0000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     for ii=42:60
%         char = ['diag_state.000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     Temp_Series1 = permute(Temp_Series1,[2,1,3]);
%     Temp_Series4 = permute(Temp_Series4,[2,1,3]);
%     A = Temp_Series1(:,:,1);
%     
%     [m,n,l] = size(Temp_Series1);
%     
%     for ii=1:m
%         for jj=1:n
%             for kk=1:l
%                 if (Temp_Series1(ii,jj,kk)==0)
%                     Temp_Series1(ii,jj,kk) = NaN;
%                     Temp_Series4(ii,jj,kk) = NaN;
%                 end
%             end
%             if (A(ii,jj)==0)
%                 A(ii,jj) = NaN;
%             end
%         end
%     end
%     
%     lb = -0.5;
%     ub = 0.5;
%     A = isnan(A);
%     z = linspace(lb,ub,21);
%     
%     coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
%     
%     figure()
%     set(gcf, 'Position', [1, 1, 1600, 900])
%     colormap(cmbluered)
%     subplot(1,2,1);
%     contourf(XC,YC,Temp_Series1(:,:,1),'LineStyle','none','LevelList',z);
%     hold on
%     colorbar('southoutside');
%     contour(XC,YC,0+A,'Color','k')
%     caxis([lb ub])
%     axis(coords)
%     title(['SO zonal velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%     xlabel('Latitude')
%     ax = gca;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset;
%     left = outerpos(1)-0.05;
%     bottom = outerpos(2) + ti(2)-0.05;
%     ax_width = outerpos(3) + 0.06;
%     ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%     ax.Position = [left bottom ax_width ax_height];
%     hold off
%     
%     subplot(1,2,2);
%     contourf(XC,YC,Temp_Series4(:,:,1),'LineStyle','none','LevelList',z);
%     caxis([lb ub])
%     hold on
%     colorbar('southoutside');
%     contour(XC,YC,0+A,'Color','k')
%     axis(coords)
%     title(['AB zonal velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%     xlabel('Latitude')
%     hold off
%     ax = gca;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset;
%     left = outerpos(1)-0.02;
%     bottom = outerpos(2) + ti(2)-0.05;
%     ax_width = outerpos(3) + 0.06;
%     ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%     ax.Position = [left bottom ax_width ax_height];
%     set(gca, 'nextplot','replacechildren', 'Visible','on');
%     
%     vidObj = VideoWriter(['UVEL_SBS_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
%     vidObj.Quality = 100;
%     vidObj.FrameRate = 6;
%     open(vidObj);
%     writeVideo(vidObj, getframe(gcf));
%     
%     for ii=2:60
%         subplot(1,2,1);
%         contourf(XC,YC,Temp_Series1(:,:,ii),'LineStyle','none','LevelList',z);
%         hold on
%         colorbar('southoutside');
%         contour(XC,YC,0+A,'Color','k')
%         caxis([lb ub])
%         axis(coords)
%         title(['SO zonal velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%         xlabel('Latitude')
%         ax = gca;
%         outerpos = ax.OuterPosition;
%         ti = ax.TightInset;
%         left = outerpos(1)-0.05;
%         bottom = outerpos(2) + ti(2)-0.05;
%         ax_width = outerpos(3) + 0.06;
%         ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%         ax.Position = [left bottom ax_width ax_height];
%         hold off
%         
%         subplot(1,2,2);
%         contourf(XC,YC,Temp_Series4(:,:,ii),'LineStyle','none','LevelList',z);
%         hold on
%         colorbar('southoutside');
%         contour(XC,YC,0+A,'Color','k')
%         caxis([lb ub])
%         axis(coords)
%         title(['AB zonal velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%         xlabel('Latitude')
%         ax = gca;
%         outerpos = ax.OuterPosition;
%         ti = ax.TightInset;
%         left = outerpos(1)-0.02;
%         bottom = outerpos(2) + ti(2)-0.05;
%         ax_width = outerpos(3) + 0.06;
%         ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%         ax.Position = [left bottom ax_width ax_height];
%         hold off
%         drawnow()
%         writeVideo(vidObj, getframe(gcf));
%     end
%     
%     close(vidObj);
% end
% 
% 
% time = toc();
% fprintf('Time to create UVEL movies: %g\n',time)
% clear
% %% end UVEL
% 
% %% VVEL
% tic()
% for qq=1:10
%     ACC_Settings
%     
%     delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
%         10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
%         20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
%         100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
%         300, 380, 400, 400, 400, 400, 400, 400, 400, 400];
%     
%     uu = 4;
%     Q = [1,2,6,10,13,21,29,31,40,46];
%     
%     XC = rdmds('XC');
%     YC = rdmds('YC');
%     XC = XC(:,end);
%     YC = YC(649,:);
%     XCs = rdmds('1XC');
%     YCs = rdmds('1YC');
%     XCs = XCs(:,end);
%     YCs = YCs(end,:);
%     lox = find(XC>289.99,1);
%     hix = find(XC>335.99,1);
%     loy = find(YC>-59.3,1);
%     hiy = find(YC>-32,1);
%     loxx = find(XCs>289.99,1);
%     hixx = find(XCs>335.99,1);
%     loyy = find(YCs>-59.3,1);
%     hiyy = find(YCs>-32,1);
%     XC = XC(lox:hix);
%     YC = YC(loy:hiy);
%     XCs = XCs(loxx:hixx);
%     YCs = YCs(loyy:hiyy);
%     n = length(XC);
%     m = length(YC);
%     n1 = length(XCs);
%     m1 = length(YCs);
%     
%     
%     Temp_Series1 = zeros(n,m,60);
%     
%     Temp_Series4 = zeros(n1,m1,60);
%     
%     
%     for ii=1:4
%         char = ['diag_state.00000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.00000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     for ii=5:41
%         char = ['diag_state.0000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.0000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     for ii=42:60
%         char = ['diag_state.000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     Temp_Series1 = permute(Temp_Series1,[2,1,3]);
%     Temp_Series4 = permute(Temp_Series4,[2,1,3]);
%     A = Temp_Series1(:,:,1);
%     
%     [m,n,l] = size(Temp_Series1);
%     
%     for ii=1:m
%         for jj=1:n
%             for kk=1:l
%                 if (Temp_Series1(ii,jj,kk)==0)
%                     Temp_Series1(ii,jj,kk) = NaN;
%                     Temp_Series4(ii,jj,kk) = NaN;
%                 end
%             end
%             if (A(ii,jj)==0)
%                 A(ii,jj) = NaN;
%             end
%         end
%     end
%     
%     lb = -0.5;
%     ub = 0.5;
%     A = isnan(A);
%     z = linspace(lb,ub,21);
%     
%     coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
%     
%     figure()
%     set(gcf, 'Position', [1, 1, 1600, 900])
%     colormap(cmbluered)
%     subplot(1,2,1);
%     contourf(XC,YC,Temp_Series1(:,:,1),'LineStyle','none','LevelList',z);
%     hold on
%     colorbar('southoutside');
%     contour(XC,YC,0+A,'Color','k')
%     caxis([lb ub])
%     axis(coords)
%     title(['SO meridional velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%     xlabel('Latitude')
%     ax = gca;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset;
%     left = outerpos(1)-0.05;
%     bottom = outerpos(2) + ti(2)-0.05;
%     ax_width = outerpos(3) + 0.06;
%     ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%     ax.Position = [left bottom ax_width ax_height];
%     hold off
%     
%     subplot(1,2,2);
%     contourf(XC,YC,Temp_Series4(:,:,1),'LineStyle','none','LevelList',z);
%     caxis([lb ub])
%     hold on
%     colorbar('southoutside');
%     contour(XC,YC,0+A,'Color','k')
%     axis(coords)
%     title(['AB meridional velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%     xlabel('Latitude')
%     hold off
%     ax = gca;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset;
%     left = outerpos(1)-0.02;
%     bottom = outerpos(2) + ti(2)-0.05;
%     ax_width = outerpos(3) + 0.06;
%     ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%     ax.Position = [left bottom ax_width ax_height];
%     set(gca, 'nextplot','replacechildren', 'Visible','on');
%     
%     vidObj = VideoWriter(['VVEL_SBS_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
%     vidObj.Quality = 100;
%     vidObj.FrameRate = 6;
%     open(vidObj);
%     writeVideo(vidObj, getframe(gcf));
%     
%     for ii=2:60
%         subplot(1,2,1);
%         contourf(XC,YC,Temp_Series1(:,:,ii),'LineStyle','none','LevelList',z);
%         hold on
%         colorbar('southoutside');
%         contour(XC,YC,0+A,'Color','k')
%         caxis([lb ub])
%         axis(coords)
%         title(['SO meridional velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%         xlabel('Latitude')
%         ax = gca;
%         outerpos = ax.OuterPosition;
%         ti = ax.TightInset;
%         left = outerpos(1)-0.05;
%         bottom = outerpos(2) + ti(2)-0.05;
%         ax_width = outerpos(3) + 0.06;
%         ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%         ax.Position = [left bottom ax_width ax_height];
%         hold off
%         
%         subplot(1,2,2);
%         contourf(XC,YC,Temp_Series4(:,:,ii),'LineStyle','none','LevelList',z);
%         hold on
%         colorbar('southoutside');
%         contour(XC,YC,0+A,'Color','k')
%         caxis([lb ub])
%         axis(coords)
%         title(['AB meridional velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%         xlabel('Latitude')
%         ax = gca;
%         outerpos = ax.OuterPosition;
%         ti = ax.TightInset;
%         left = outerpos(1)-0.02;
%         bottom = outerpos(2) + ti(2)-0.05;
%         ax_width = outerpos(3) + 0.06;
%         ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%         ax.Position = [left bottom ax_width ax_height];
%         hold off
%         drawnow()
%         writeVideo(vidObj, getframe(gcf));
%     end
%     
%     close(vidObj);
% end
% 
% 
% time = toc();
% fprintf('Time to create VVEL movies: %g\n',time)
% clear
% %% end VVEL
% 
% 
% %% WVEL
% tic()
% for qq=1:10
%     ACC_Settings
%     
%     delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
%         10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
%         20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
%         100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
%         300, 380, 400, 400, 400, 400, 400, 400, 400, 400];
%     
%     uu = 5;
%     Q = [1,2,6,10,13,21,29,31,40,46];
%     
%     XC = rdmds('XC');
%     YC = rdmds('YC');
%     XC = XC(:,end);
%     YC = YC(649,:);
%     XCs = rdmds('1XC');
%     YCs = rdmds('1YC');
%     XCs = XCs(:,end);
%     YCs = YCs(end,:);
%     lox = find(XC>289.99,1);
%     hix = find(XC>335.99,1);
%     loy = find(YC>-59.3,1);
%     hiy = find(YC>-32,1);
%     loxx = find(XCs>289.99,1);
%     hixx = find(XCs>335.99,1);
%     loyy = find(YCs>-59.3,1);
%     hiyy = find(YCs>-32,1);
%     XC = XC(lox:hix);
%     YC = YC(loy:hiy);
%     XCs = XCs(loxx:hixx);
%     YCs = YCs(loyy:hiyy);
%     n = length(XC);
%     m = length(YC);
%     n1 = length(XCs);
%     m1 = length(YCs);
%     
%     
%     Temp_Series1 = zeros(n,m,60);
%     
%     Temp_Series4 = zeros(n1,m1,60);
%     
%     
%     for ii=1:4
%         char = ['diag_state.00000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.00000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     for ii=5:41
%         char = ['diag_state.0000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.0000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     for ii=42:60
%         char = ['diag_state.000000',num2str(24*ii)];
%         temp = rdmds(char);
%         Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
%         char1 = ['1diag_state.000000',num2str(24*ii)];
%         temp1 = rdmds(char1);
%         Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
%     end
%     
%     Temp_Series1 = permute(Temp_Series1,[2,1,3]);
%     Temp_Series4 = permute(Temp_Series4,[2,1,3]);
%     A = Temp_Series1(:,:,1);
%     
%     [m,n,l] = size(Temp_Series1);
%     
%     for ii=1:m
%         for jj=1:n
%             for kk=1:l
%                 if (Temp_Series1(ii,jj,kk)==0)
%                     Temp_Series1(ii,jj,kk) = NaN;
%                     Temp_Series4(ii,jj,kk) = NaN;
%                 end
%             end
%             if (A(ii,jj)==0)
%                 A(ii,jj) = NaN;
%             end
%         end
%     end
%     
%     lb = -0.0004;
%     ub = 0.0004;
%     A = isnan(A);
%     z = linspace(lb,ub,25);
%     
%     coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
%     
%     figure()
%     set(gcf, 'Position', [1, 1, 1600, 900])
%     colormap(cmbluered)
%     subplot(1,2,1);
%     contourf(XC,YC,Temp_Series1(:,:,1),'LineStyle','none','LevelList',z);
%     hold on
%     colorbar('southoutside');
%     contour(XC,YC,0+A,'Color','k')
%     caxis([lb ub])
%     axis(coords)
%     title(['SO vertical velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%     xlabel('Latitude')
%     ax = gca;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset;
%     left = outerpos(1)-0.05;
%     bottom = outerpos(2) + ti(2)-0.05;
%     ax_width = outerpos(3) + 0.06;
%     ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%     ax.Position = [left bottom ax_width ax_height];
%     hold off
%     
%     subplot(1,2,2);
%     contourf(XC,YC,Temp_Series4(:,:,1),'LineStyle','none','LevelList',z);
%     caxis([lb ub])
%     hold on
%     colorbar('southoutside');
%     contour(XC,YC,0+A,'Color','k')
%     axis(coords)
%     title(['AB vertical velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%     xlabel('Latitude')
%     hold off
%     ax = gca;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset;
%     left = outerpos(1)-0.02;
%     bottom = outerpos(2) + ti(2)-0.05;
%     ax_width = outerpos(3) + 0.06;
%     ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%     ax.Position = [left bottom ax_width ax_height];
%     set(gca, 'nextplot','replacechildren', 'Visible','on');
%     
%     vidObj = VideoWriter(['WVEL_SBS_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
%     vidObj.Quality = 100;
%     vidObj.FrameRate = 6;
%     open(vidObj);
%     writeVideo(vidObj, getframe(gcf));
%     
%     for ii=2:60
%         subplot(1,2,1);
%         contourf(XC,YC,Temp_Series1(:,:,ii),'LineStyle','none','LevelList',z);
%         hold on
%         colorbar('southoutside');
%         contour(XC,YC,0+A,'Color','k')
%         caxis([lb ub])
%         axis(coords)
%         title(['SO vertical velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%         xlabel('Latitude')
%         ax = gca;
%         outerpos = ax.OuterPosition;
%         ti = ax.TightInset;
%         left = outerpos(1)-0.05;
%         bottom = outerpos(2) + ti(2)-0.05;
%         ax_width = outerpos(3) + 0.06;
%         ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%         ax.Position = [left bottom ax_width ax_height];
%         hold off
%         
%         subplot(1,2,2);
%         contourf(XC,YC,Temp_Series4(:,:,ii),'LineStyle','none','LevelList',z);
%         hold on
%         colorbar('southoutside');
%         contour(XC,YC,0+A,'Color','k')
%         caxis([lb ub])
%         axis(coords)
%         title(['AB vertical velocity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in m/s'])
%         xlabel('Latitude')
%         ax = gca;
%         outerpos = ax.OuterPosition;
%         ti = ax.TightInset;
%         left = outerpos(1)-0.02;
%         bottom = outerpos(2) + ti(2)-0.05;
%         ax_width = outerpos(3) + 0.06;
%         ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
%         ax.Position = [left bottom ax_width ax_height];
%         hold off
%         drawnow()
%         writeVideo(vidObj, getframe(gcf));
%     end
%     
%     close(vidObj);
% end
% 
% 
% time = toc();
% fprintf('Time to create WVEL movies: %g\n',time)
% clear
% %% end WVEL

%% THETA
tic()
for qq=1:10
    set(0,'DefaultFigureVisible','off')
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
    Q = [1,2,6,10,13,21,29,31,40,46];
    ACC_Colors
    ACC_Colormaps
    uu = 1;
    
    
    XC = rdmds('XC');
    YC = rdmds('YC');
    XC = XC(:,end);
    YC = YC(649,:);
    XCs = rdmds('1XC');
    YCs = rdmds('1YC');
    XCs = XCs(:,end);
    YCs = YCs(end,:);
    lox = find(XC>289.99,1);
    hix = find(XC>350,1);
    loy = find(YC>-59.3,1);
    hiy = find(YC>-32,1);
    loxx = find(XCs>289.99,1);
    hixx = find(XCs>350,1);
    loyy = find(YCs>-59.3,1);
    hiyy = find(YCs>-32,1);
    XC = XC(lox:hix);
    YC = YC(loy:hiy);
    XCs = XCs(loxx:hixx);
    YCs = YCs(loyy:hiyy);
    n = length(XC);
    m = length(YC);
    n1 = length(XCs);
    m1 = length(YCs);
    
    
    Temp_Series1 = zeros(n,m,60);
    
    Temp_Series4 = zeros(n1,m1,60);
    
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.00000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.0000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    Temp_Series = Temp_Series1-Temp_Series4;
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series1(:,:,31);
    A = A';
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj)=NaN;
            end
        end
    end
    
    if (qq<6)
        ub = 15;
        nlvls = 31;
    elseif (qq==6)
        ub = 12;
        nlvls = 25;
    elseif (qq>6)&&(qq<9)
        ub = 6;
        nlvls = 25;
    elseif (qq>8)
        ub = 2;
        nlvls = 21;
    end
        
    lb = -ub;
    A = isnan(A);
    z = linspace(lb,ub,nlvls);
    
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cmbluered)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    
    hold on
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title(['temperature difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in degrees C'])
    xlabel('Latitude')
    ylabel('Longitude')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) + 0.01;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) - 0.03;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.02;
    ax.Position = [left bottom ax_width ax_height];
    hold off
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['THETA_ERR_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        colorbar('eastoutside');
        
        hold on
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['temperature difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in degrees C'])
        xlabel('Latitude')
        ylabel('Longitude')
        hold off
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create THETA movies: %g\n',time)
clear
%% end THETA

%% SALT
tic()
for qq=1:10
    set(0,'DefaultFigureVisible','off')
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
    Q = [1,2,6,10,13,21,29,31,40,46];
    ACC_Colors
    ACC_Colormaps
    
    uu = 2;
    
    
    XC = rdmds('XC');
    YC = rdmds('YC');
    XC = XC(:,end);
    YC = YC(649,:);
    XCs = rdmds('1XC');
    YCs = rdmds('1YC');
    XCs = XCs(:,end);
    YCs = YCs(end,:);
    lox = find(XC>289.99,1);
    hix = find(XC>350,1);
    loy = find(YC>-59.3,1);
    hiy = find(YC>-32,1);
    loxx = find(XCs>289.99,1);
    hixx = find(XCs>350,1);
    loyy = find(YCs>-59.3,1);
    hiyy = find(YCs>-32,1);
    XC = XC(lox:hix);
    YC = YC(loy:hiy);
    XCs = XCs(loxx:hixx);
    YCs = YCs(loyy:hiyy);
    n = length(XC);
    m = length(YC);
    n1 = length(XCs);
    m1 = length(YCs);
    
    
    Temp_Series1 = zeros(n,m,60);
    
    Temp_Series4 = zeros(n1,m1,60);
    
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.00000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.0000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    Temp_Series = Temp_Series1-Temp_Series4;
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series1(:,:,20);
    A = A';
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj)=NaN;
            end
        end
    end
    
    size(A)
    
    if (qq<3)
        ub = 7;
        nlvls = 15;
    elseif (qq==3)
        ub = 5;
        nlvls = 16;
    elseif (qq>3)&&(qq<6)
        ub = 4;
        nlvls = 17;
    elseif (qq==6)
        ub = 3;
        nlvls = 19;
    elseif (qq>6)
        ub = 2;
        nlvls = 17;
    end
    
    lb = -ub;
    A = isnan(A);
    z = linspace(lb,ub,nlvls);
    
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cmbluered)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    
    caxis([lb ub])
    axis(coords)
    title(['salinity difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in psu'])
    xlabel('Latitude')
    ylabel('Longitude')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) + 0.01;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) - 0.03;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.02;
    ax.Position = [left bottom ax_width ax_height];
    hold off
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['SALT_ERR_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        colorbar('eastoutside');
        
        hold on
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['salinity difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in psu'])
        xlabel('Latitude')
        ylabel('Longitude')
        hold off
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create SALT movies: %g\n',time)
clear
%% end SALT

%% THETA SBS
tic()
for qq=1:10
    ACC_Settings
    
    delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
        10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
        20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
        100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
        300, 380, 400, 400, 400, 400, 400, 400, 400, 400];
    
    uu = 1;
    Q = [1,2,6,10,13,21,29,31,40,46];
    
    XC = rdmds('XC');
    YC = rdmds('YC');
    XC = XC(:,end);
    YC = YC(649,:);
    XCs = rdmds('1XC');
    YCs = rdmds('1YC');
    XCs = XCs(:,end);
    YCs = YCs(end,:);
    lox = find(XC>289.99,1);
    hix = find(XC>335.99,1);
    loy = find(YC>-59.3,1);
    hiy = find(YC>-32,1);
    loxx = find(XCs>289.99,1);
    hixx = find(XCs>335.99,1);
    loyy = find(YCs>-59.3,1);
    hiyy = find(YCs>-32,1);
    XC = XC(lox:hix);
    YC = YC(loy:hiy);
    XCs = XCs(loxx:hixx);
    YCs = YCs(loyy:hiyy);
    n = length(XC);
    m = length(YC);
    n1 = length(XCs);
    m1 = length(YCs);
    
    
    Temp_Series1 = zeros(n,m,60);
    
    Temp_Series4 = zeros(n1,m1,60);
    
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.00000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.0000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    Temp_Series1 = permute(Temp_Series1,[2,1,3]);
    Temp_Series4 = permute(Temp_Series4,[2,1,3]);
    A = Temp_Series1(:,:,1);
    
    [m,n,l] = size(Temp_Series1);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series1(ii,jj,kk)==0)
                    Temp_Series1(ii,jj,kk) = NaN;
                    Temp_Series4(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj) = NaN;
            end
        end
    end
    
    lb = -3;
    ub = 29;
    A = isnan(A);
    z = linspace(lb,ub,33);
    
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cmbluered)
    subplot(1,2,1);
    contourf(XC,YC,Temp_Series1(:,:,1),'LineStyle','none','LevelList',z);
    hold on
    colorbar('southoutside');
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title(['SO temperature at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in degrees C'])
    xlabel('Latitude')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.05;
    bottom = outerpos(2) + ti(2)-0.05;
    ax_width = outerpos(3) + 0.06;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
    ax.Position = [left bottom ax_width ax_height];
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Temp_Series4(:,:,1),'LineStyle','none','LevelList',z);
    caxis([lb ub])
    hold on
    colorbar('southoutside');
    contour(XC,YC,0+A,'Color','k')
    axis(coords)
    title(['AB temperature at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in degrees C'])
    xlabel('Latitude')
    hold off
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.02;
    bottom = outerpos(2) + ti(2)-0.05;
    ax_width = outerpos(3) + 0.06;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
    ax.Position = [left bottom ax_width ax_height];
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['THETA_SBS_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        subplot(1,2,1);
        contourf(XC,YC,Temp_Series1(:,:,ii),'LineStyle','none','LevelList',z);
        hold on
        colorbar('southoutside');
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['SO temperature at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in degrees C'])
        xlabel('Latitude')
        ax = gca;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset;
        left = outerpos(1)-0.05;
        bottom = outerpos(2) + ti(2)-0.05;
        ax_width = outerpos(3) + 0.06;
        ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
        ax.Position = [left bottom ax_width ax_height];
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Temp_Series4(:,:,ii),'LineStyle','none','LevelList',z);
        hold on
        colorbar('southoutside');
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['AB temperature at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in degrees C'])
        xlabel('Latitude')
        ax = gca;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset;
        left = outerpos(1)-0.02;
        bottom = outerpos(2) + ti(2)-0.05;
        ax_width = outerpos(3) + 0.06;
        ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
        ax.Position = [left bottom ax_width ax_height];
        hold off
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create THETA SBS movies: %g\n',time)
clear
%% end TSBS


%% SALT SBS
tic()
for qq=1:10
    ACC_Settings
    
    delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
        10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
        20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
        100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
        300, 380, 400, 400, 400, 400, 400, 400, 400, 400];
    
    uu = 2;
    Q = [1,2,6,10,13,21,29,31,40,46];
    
    XC = rdmds('XC');
    YC = rdmds('YC');
    XC = XC(:,end);
    YC = YC(649,:);
    XCs = rdmds('1XC');
    YCs = rdmds('1YC');
    XCs = XCs(:,end);
    YCs = YCs(end,:);
    lox = find(XC>289.99,1);
    hix = find(XC>335.99,1);
    loy = find(YC>-59.3,1);
    hiy = find(YC>-32,1);
    loxx = find(XCs>289.99,1);
    hixx = find(XCs>335.99,1);
    loyy = find(YCs>-59.3,1);
    hiyy = find(YCs>-32,1);
    XC = XC(lox:hix);
    YC = YC(loy:hiy);
    XCs = XCs(loxx:hixx);
    YCs = YCs(loyy:hiyy);
    n = length(XC);
    m = length(YC);
    n1 = length(XCs);
    m1 = length(YCs);
    
    
    Temp_Series1 = zeros(n,m,60);
    
    Temp_Series4 = zeros(n1,m1,60);
    
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.00000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.0000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    Temp_Series1 = permute(Temp_Series1,[2,1,3]);
    Temp_Series4 = permute(Temp_Series4,[2,1,3]);
    A = Temp_Series1(:,:,1);
    
    [m,n,l] = size(Temp_Series1);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series1(ii,jj,kk)==0)
                    Temp_Series1(ii,jj,kk) = NaN;
                    Temp_Series4(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj) = NaN;
            end
        end
    end
    
    if (qq<3)
        lb = 29;
        ub = 37;
        nlvls = 17;
    elseif (qq==3)
        lb = 30;
        ub = 37;
        nlvls = 15;
    elseif (qq>3)&&(qq<7)
        lb = 32;
        ub = 37;
        nlvls = 16;
    elseif (qq>6)
        lb = 33;
        ub = 36;
        nlvls = 16;        
    end
    
    A = isnan(A);
    z = linspace(lb,ub,nlvls);
    
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cmbluered)
    subplot(1,2,1);
    contourf(XC,YC,Temp_Series1(:,:,1),'LineStyle','none','LevelList',z);
    hold on
    colorbar('southoutside');
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title(['SO salinity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in psu'])
    xlabel('Latitude')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.05;
    bottom = outerpos(2) + ti(2)-0.05;
    ax_width = outerpos(3) + 0.06;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
    ax.Position = [left bottom ax_width ax_height];
    hold off
    
    subplot(1,2,2);
    contourf(XC,YC,Temp_Series4(:,:,1),'LineStyle','none','LevelList',z);
    caxis([lb ub])
    hold on
    colorbar('southoutside');
    contour(XC,YC,0+A,'Color','k')
    axis(coords)
    title(['AB salinity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in psu'])
    xlabel('Latitude')
    hold off
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.02;
    bottom = outerpos(2) + ti(2)-0.05;
    ax_width = outerpos(3) + 0.06;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
    ax.Position = [left bottom ax_width ax_height];
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['SALT_SBS_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        subplot(1,2,1);
        contourf(XC,YC,Temp_Series1(:,:,ii),'LineStyle','none','LevelList',z);
        hold on
        colorbar('southoutside');
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['SO salinity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in psu'])
        xlabel('Latitude')
        ax = gca;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset;
        left = outerpos(1)-0.05;
        bottom = outerpos(2) + ti(2)-0.05;
        ax_width = outerpos(3) + 0.06;
        ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
        ax.Position = [left bottom ax_width ax_height];
        hold off
        
        subplot(1,2,2);
        contourf(XC,YC,Temp_Series4(:,:,ii),'LineStyle','none','LevelList',z);
        hold on
        colorbar('southoutside');
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['AB salinity at depth ',num2str(sum(delZ(1:Q(qq)-1))),' m in psu'])
        xlabel('Latitude')
        ax = gca;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset;
        left = outerpos(1)-0.02;
        bottom = outerpos(2) + ti(2)-0.05;
        ax_width = outerpos(3) + 0.06;
        ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
        ax.Position = [left bottom ax_width ax_height];
        hold off
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create SALT SBS movies: %g\n',time)
clear
%% end SSBS

%% UVEL
tic()
for qq=1:10
    set(0,'DefaultFigureVisible','off')
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
    Q = [1,2,6,10,13,21,29,31,40,46];
    ACC_Colors
    ACC_Colormaps
    
    uu = 3;
    
    
    XC = rdmds('XC');
    YC = rdmds('YC');
    XC = XC(:,end);
    YC = YC(649,:);
    XCs = rdmds('1XC');
    YCs = rdmds('1YC');
    XCs = XCs(:,end);
    YCs = YCs(end,:);
    lox = find(XC>289.99,1);
    hix = find(XC>350,1);
    loy = find(YC>-59.3,1);
    hiy = find(YC>-32,1);
    loxx = find(XCs>289.99,1);
    hixx = find(XCs>350,1);
    loyy = find(YCs>-59.3,1);
    hiyy = find(YCs>-32,1);
    XC = XC(lox:hix);
    YC = YC(loy:hiy);
    XCs = XCs(loxx:hixx);
    YCs = YCs(loyy:hiyy);
    n = length(XC);
    m = length(YC);
    n1 = length(XCs);
    m1 = length(YCs);
    
    
    Temp_Series1 = zeros(n,m,60);
    
    Temp_Series4 = zeros(n1,m1,60);
    
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.00000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.0000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    Temp_Series = Temp_Series1-Temp_Series4;
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series1(:,:,1);
    A = A';
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj)=NaN;
            end
        end
    end
    
    lb = -0.5;
    ub = 0.5;
    A = isnan(A);
    z = linspace(lb,ub,21);
    
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cmbluered)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    
    caxis([lb ub])
    axis(coords)
    title(['zonal velocity difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),'m in m/s'])
    xlabel('Latitude')
    ylabel('Longitude')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) + 0.01;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) - 0.03;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.02;
    ax.Position = [left bottom ax_width ax_height];
    hold off
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['UVEL_ERR_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        colorbar('eastoutside');
        
        hold on
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['zonal velocity difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),'m in m/s'])
        xlabel('Latitude')
        ylabel('Longitude')
        hold off
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create UVEL movies: %g\n',time)
clear
%% end UVEL


%% VVEL
tic()
for qq=1:10
    set(0,'DefaultFigureVisible','off')
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
    Q = [1,2,6,10,13,21,29,31,40,46];
    ACC_Colors
    ACC_Colormaps
    
    uu = 4;
    
    
    XC = rdmds('XC');
    YC = rdmds('YC');
    XC = XC(:,end);
    YC = YC(649,:);
    XCs = rdmds('1XC');
    YCs = rdmds('1YC');
    XCs = XCs(:,end);
    YCs = YCs(end,:);
    lox = find(XC>289.99,1);
    hix = find(XC>350,1);
    loy = find(YC>-59.3,1);
    hiy = find(YC>-32,1);
    loxx = find(XCs>289.99,1);
    hixx = find(XCs>350,1);
    loyy = find(YCs>-59.3,1);
    hiyy = find(YCs>-32,1);
    XC = XC(lox:hix);
    YC = YC(loy:hiy);
    XCs = XCs(loxx:hixx);
    YCs = YCs(loyy:hiyy);
    n = length(XC);
    m = length(YC);
    n1 = length(XCs);
    m1 = length(YCs);
    
    
    Temp_Series1 = zeros(n,m,60);
    
    Temp_Series4 = zeros(n1,m1,60);
    
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.00000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.0000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series1(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        char1 = ['1diag_state.000000',num2str(24*ii)];
        temp1 = rdmds(char1);
        Temp_Series4(:,:,ii) = temp1(loxx:hixx,loyy:hiyy,Q(qq),uu);
    end
    
    Temp_Series = Temp_Series1-Temp_Series4;
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series1(:,:,58);
    A = A';
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj)=NaN;
            end
        end
    end
    
    lb = -0.5;
    ub = 0.5;
    A = isnan(A);
    z = linspace(lb,ub,21);
    
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cmbluered)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    
    caxis([lb ub])
    axis(coords)
    title(['meridional velocity difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),'m in m/s'])
    xlabel('Latitude')
    ylabel('Longitude')
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) + 0.01;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) - 0.03;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.02;
    ax.Position = [left bottom ax_width ax_height];
    hold off
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    
    vidObj = VideoWriter(['VVEL_ERR_',num2str(sum(delZ(1:Q(qq)-1))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 6;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:60
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        colorbar('eastoutside');
        
        hold on
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['meridional velocity difference at depth ',num2str(sum(delZ(1:Q(qq)-1))),'m in m/s'])
        xlabel('Latitude')
        ylabel('Longitude')
        hold off
        drawnow()
        writeVideo(vidObj, getframe(gcf));
    end
    
    close(vidObj);
end


time = toc();
fprintf('Time to create VVEL movies: %g\n',time)
clear
%% end VVEL

