%% ����������ס���ť������Բ�������ɵĿ���ӵ��׵Ľṹ����holes��
% size --- ���е�holes�Ŀ׵ĸ���
% perTheta --- Բ����ÿ������ռ�ĽǶ�
% theta1 --- Բ������ʼ�Ƕ�
% x,y,r --- Ҫ��ӵĿ׵�Բ�ĺͰ뾶
% inclineAngle --- ̽����
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

