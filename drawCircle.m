%% 此函数实现画隧道轮廓圆弧上孔的功能
% x --- 圆心横坐标
% y --- 圆心纵坐标
% r --- 需要画的圆的圆半径
% axes --- 需要画圆的坐标系
% color --- 圆的颜色信息
% inclineAngle --- 孔的探出角
% perTheta --- 圆弧上两孔之间的夹角
% theta1 --- 圆弧的起始角
function drawCircle( x, y, r , perTheta, theta1, inclineAngle, axes, color)
% x=1;
% y=1;
% r=5;
    size=length(x);
    for i=1:size
        theta = 0:0.01*pi:2*pi;
        X=r*cos(theta)+x(i);
        Y=r*sin(theta)+y(i);
        plot(axes, X, Y,color);
        % 只有当探出角不为0时，才画孔的倾角
        if inclineAngle ~= 0
            x1=[r*cos(theta1+ perTheta*i)+x(i),(r*3)*cos(theta1+ perTheta*i)+x(i)];
            y1=[r*sin(theta1+ perTheta*i)+y(i),(r*3)*sin(theta1+ perTheta*i)+y(i)];
            plot(axes,x1,y1,color);
        end
    end

end

