%% 输水隧道
% R --- 圆半径
% t --- 宽度
% a --- 中心高度
% l --- 左侧零位线下高度
% r --- 右侧零位线下高度
function waterTunnel( R, t, a, l, r ,axisValue)
%画上面圆弧
x=-t/2:0.01:t/2;
y=sqrt(R^2-x.^2)+a;
plot(x,y,'r');
hold on;
%画坐标轴
plot([-100,100],[0,0],'k--');
plot([0, 0], [-100, 100],'k--');
% axis([-t-2,t+2 , -l-r-1, a+R+2]);
axis(axisValue);
%画直线
%第一条线:点[-t/2, sqrt(R^2-(t/2)^2)+a]~点[-t/2, -l]
%第二条线：点[t/2, sqrt(R^2-(t/2)^2)+a]~点[-t/2, -r]
%第三条线：点[-t/2, -l]~点[-t/2, -r]
plot([-t/2, -t/2, t/2, t/2],[sqrt(R^2-(t/2)^2)+a, -l, -r, sqrt(R^2-(t/2)^2)+a],'r');
end

