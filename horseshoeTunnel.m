%% 马蹄形隧道
% R --- 圆半径
% a --- 侧面高度
% l --- 左侧零位线下高度
% r --- 右侧零位线下高度
function horseshoeTunnel( R,a,l,r,axisValue )
% R=4;
% a=3.8;
% l=1;
% r=0.5;
% 绘 顶部圆弧
theta=0:0.01*pi:pi;
x=R*cos(theta);
y=sqrt(R^2-x.^2)+a;
plot(x,y,'r');
hold on;
% 绘制坐标轴
plot([-100,100],[0,0],'k--');
plot([0 0],[-100,100],'k--');
% axis([-R-6 R+6 -l-r-1 R+a+2]);
axis(axisValue);
% 绘左下的圆弧
yl=-l:0.01:a;
xl=R-sqrt(4*R^2-(yl-a).^2);
plot(xl,yl,'r');
%绘右下的圆弧
yr=-r:0.01:a;
xr=-R+sqrt(4*R^2-(yr-a).^2);
plot(xr,yr,'r');
plot([xl(1), xr(1)],[(-l), -r],'r');

end

