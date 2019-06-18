%% 计算圆弧需要打孔的孔坐标
% theta1/theta2 --- 圆弧是从theta1到theta2, 单位弧度
% X、Y --- 圆弧圆心的横纵坐标
% R --- 圆弧半径
% upHole --- 圆弧上孔的间距
% x,y --- 返回孔的坐标
% theta --- 返回孔距之间的夹角
function [ x,y, theta ] = calCircleHolesLocation( theta1,theta2, X, Y, R, upHole )
% theta1=-pi/2;
% theta2=0;
% X=-2;
% Y=2;
% R=6;
% upHole=0.5;

% 每隔theta角度有一个孔
theta = acos((2*R^2-upHole^2)/(2*R^2));
% 计算孔的个数
size = (theta2 - theta1) / theta;
if mod(size,(floor(size)))<0.5
    size=floor(size);
else
    size=floor(size)+1;
end
x=ones(size,1);
y=ones(size,1);
for i=1:size
    x(i)=X+R*cos(theta1+theta*(i-1));
    y(i)=Y+R*sin(theta1+theta*(i-1));
end
% plot(x,y,'ro')
% axis([-10 10 -3 9]);
% hold on;
% plot([0 0],[0 2])
end

