
acc_settings

time = 1:70;
temp1 = linspace(20,50,70)+normrnd(0,10,1,70);

set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
plot(time, temp1,'LineWidth',2.4,'Color',Color(:,c1))
hold on
xlabel('time')
ylabel('temperature')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
text(55,22,'Hey, it''s cold!','FontSize',16);
acc_plots
hold off
print('moron','-djpeg')






