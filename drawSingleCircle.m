%% 单独添加孔时调用
% x,y --- 孔的x,y坐标
% r --- 孔的孔径
% biasAngle --- 孔的偏角
% inclineAngle --- 孔的探出角
% axes --- 在要axes坐标系上画孔
% color --- 孔的颜色
function drawSingleCircle( x,y,r,biasAngle,inclineAngle,axes,color )
    theta = 0:0.01*pi:2*pi;
    X=r*cos(theta)+x;
    Y=r*sin(theta)+y;
    plot(axes, X, Y,color);
    if inclineAngle ~= 0
        x1=[x+r*cos(biasAngle), x+3*r*cos(biasAngle)];
        y1=[y+r*sin(biasAngle), y+3*r*sin(biasAngle)];
        plot(axes,x1,y1,color);
    end
end

