%% ����������ס���ֱ�����������ɵĿ׵�������ӵ��׵Ľṹ����holes�У�
function [ holes ] = addLineHoles( sizeHoles,x,y,r,depth,inclineAngle )
% biasAngleΪ�ױߵ����-pi/2����Ϊ�ױ߿׵�̽����
biasAngle=atan((y(2)-y(1))/(x(2)-x(1)))-pi/2;
% sizeHolesΪ���Բ����֮��Ľṹ��ĳ���
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

