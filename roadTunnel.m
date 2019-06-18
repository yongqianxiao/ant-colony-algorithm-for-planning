%% 公路隧道
% R --- 圆半径
% a --- 中心高度
% l --- 左侧零位线下高度
% r --- 右侧零位线下高度

function roadTunnel(R,a,l,r,axisValue)
% 绘 0 - 180度
theta=0:0.01*pi:pi;
x=R*cos(theta);
y=sqrt(R^2-x.^2)+a;
plot(x,y,'r');
hold on;
% 绘制坐标轴
plot([-100,100],[0,0],'k--');
plot([0 0],[-100,100],'k--');
% axis([-R-2 R+2 -l-r-1 R+a+2]);
axis(axisValue);

% 绘多出的右边部分
rTheta=asin((a+r)/R);
temp1=0:0.01*pi:rTheta;
temp1=[temp1 rTheta];
xr=R*cos(temp1);
yr=-sqrt(R^2-xr.^2)+a;
plot(xr,yr,'r');
% 绘多出的左边部分
lTheta=asin((a+l)/R);
temp2=pi-lTheta:0.01*pi:pi;
temp2=[temp2 pi];
xl=R*cos(temp2);
yl=-sqrt(R^2-xl.^2)+a;
plot(xl,yl,'r');
plot([-R*cos(lTheta), R*cos(rTheta)],[(-l), -r],'r');
end

