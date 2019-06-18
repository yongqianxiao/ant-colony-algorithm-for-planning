%% 求过点x1,y1的直线和两直线角平分线（过x2,y2）的交点
% line1_x1 y1 --- 第一条直线第一个点
% line1_x2 y2 --- 第一条直线第二个点
% line2_x1 y1 --- 第二条直线第二个点
% line2_x2 y2 --- 第二条直线第一个点
% x1 y1 --- 用来求过x1,y1的直线方程
% x2 y2 --- 用来求过x2,y2的角平分线方程
% k1 --- 第一条直线斜率
% tempk2 --- 第二条直线斜率
% k2 --- 两直线夹角斜率
% [x y] --- 返回两直线交点坐标
function [ x,y ] = solveEquation( line1_x1,line1_y1,line1_x2,line1_y2,x1,y1,line2_x1,line2_y1,line2_x2,line2_y2,x2,y2 )
k1=(line1_y1-line1_y2)/(line1_x1-line1_x2);
tempk2=(line2_y1-line2_y2)/(line2_x1-line2_x2);
k2=tan((atan(k1)+atan(tempk2))/2);
if ~isinf(k1) && ~isinf(k2)
    if k1==0 && line1_x1<line1_x2
        k2=-k2;
    end
    if tempk2==0 && line2_x1<line2_x2
        k2=-k2;
    end
    b1=y1-k1*x1;
    b2=y2-k2*x2;
    x=(b2-b1)/(k1-k2);
    y=k1*(b2-b1)/(k1-k2)+b1;
    return;
end
if isinf(k1)
    if tempk2==0 && line2_x1<line2_x2
        k2=-k2;
    end
    b2=y2-k2*x2;
    x=x1;
    y=k2*x+b2;
    return;
end
if isinf(tempk2)
    if k1==0 && line1_x1<line1_x2
        k2=-k2;
    end
    b1=y1-k1*x1;
    b2=y2-k2*x2;
    x=(b2-b1)/(k1-k2);
    y=k1*(b2-b1)/(k1-k2)+b1;
    return;
end
end

