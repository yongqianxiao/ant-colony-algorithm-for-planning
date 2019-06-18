%% 将点击‘布孔’后，直线轮廓上生成的孔的数据添加到孔的结构数组holes中，
function [ holes ] = addLineHoles( sizeHoles,x,y,r,depth,inclineAngle )
% biasAngle为底边的倾角-pi/2，即为底边孔的探出角
biasAngle=atan((y(2)-y(1))/(x(2)-x(1)))-pi/2;
% sizeHoles为添加圆弧孔之后的结构体的长度
    for i=1:length(x)
        holeData.num=sizeHoles+i;
        holeData.x=x(i);
        holeData.y=y(i);
        holeData.r=r;
        holeData.depth=depth;
        if inclineAngle == 0
            holeData.biasAngle=0;
        else
            holeData.biasAngle=biasAngle;
        end
        holeData.inclineAngle=inclineAngle;
        holes(i)=holeData;
    end

end

