set(gca, 'defaultUicontrolFontName', 'Ubuntu')
set(gca, 'defaultUitableFontName', 'Ubuntu')
set(gca, 'defaultAxesFontName', 'Ubuntu')
set(gca, 'defaultTextFontName', 'Ubuntu')
set(gca, 'defaultUipanelFontName', 'Ubuntu')
% set(gca,'DefaultAxesFontSize', 14)
% set(gca,'DefaultTextFontSize', 14)
fig = gcf;
set(findall(fig, '-property', 'FontSize'), 'FontSize', 14)