
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1)-0.015;
bottom = outerpos(2) + ti(2)-0.04;
ax_width = outerpos(3) + 0.06;
ax_height = outerpos(4) - ti(2) - ti(4) + 0.04;
ax.Position = [left bottom ax_width ax_height];