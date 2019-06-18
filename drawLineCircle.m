%% 此函数实现画隧道轮廓直线段上孔的功能
% x --- 圆心横坐标
% y --- 圆心纵坐标
% r --- 需要画的圆的圆半径
% axes --- 需要画圆的坐标系
% color --- 圆的颜色信息
% inclineAngle --- 孔的探出角

function [ x,y ] = drawLineCircle(  x, y, r , inclineAngle, axes, color )
    size=length(x);
    % 直线斜率角
    theta1=atan((y(2)-y(1))/(x(2)-x(1)));
    
    for i=1:size
        theta = 0:0.01*pi:2*pi;
        X=r*cos(theta)+x(i);
        Y=r*sin(theta)+y(i);
        plot(axes, X, Y,color);
        if inclineAngle ~= 0 
            x1=[r*sin(theta1)+x(i),(r*3)*sin(theta1)+x(i)];
            y1=[-r*cos(theta1)+y(i),-(r*3)*cos(theta1)+y(i)];
            plot(axes,x1,y1,color);
        end
    end

end

