%% 将点击‘布孔’按钮后，轮廓圆弧上生成的孔添加到孔的结构数组holes中
% size --- 已有的holes的孔的个数
% perTheta --- 圆弧上每个孔所占的角度
% theta1 --- 圆弧的起始角度
% x,y,r --- 要添加的孔的圆心和半径
% inclineAngle --- 探出角
function [ holes ] = addCircleHoles( size,x,y,r,depth,perTheta,theta1,inclineAngle )
    for i=1:length(x)
        holeData.num=size+i;
        holeData.x=x(i);
        holeData.y=y(i);
        holeData.r=r;
        holeData.depth=depth;
        if inclineAngle==0
            holeData.biasAngle=0;
        else
            holeData.biasAngle=(perTheta*(i-1)+theta1);
        end
        holeData.inclineAngle=inclineAngle;
        holes(i)=holeData;
    end
end

