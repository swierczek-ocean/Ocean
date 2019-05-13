

XG = XG(:,end);
YG = YG(end,:);
XC = XC(:,end);
YC = YC(end,:);

lox = find(XG>288.6,1)-1;
hix = find(XG>351.58,1)+1;

loy = find(YG>-59.68,1)-2;
hiy = find(YG>-30.6,1)+1;



figure()
colormap(bone)
surf(-Depth(lox:hix,loy:hiy)')

YG3 = YG(loy:hiy);
XG3 = XG(lox:hix);
YC3 = YC(loy:hiy);
XC3 = XC(lox:hix);


