%% �������������Ի��������Ŀ�
% tunnel --- �ṹ�����飺������͡�������гߴ磨����Բ�����߶Σ�
% holeDis --- �׾�
% floorDis --- ���
% handles --- �����ͼ�ξ��
% holesR --- �׾�
% inclineAngle --- ̽����
% depth --- ����
function [ holes ] = assignCustonHoles( tunnel, holes, holeDis, handles, holesR, inclineAngle, holesDepth )
%% ��Բ���ϵĿ�
if ~isempty(tunnel.arc)
    arc=tunnel.arc;
    for i=1:length(arc)
        theta1=tunnel.arc(i).theta1;
        theta2=tunnel.arc(i).theta2;
        X=tunnel.arc(i).x;
        Y=tunnel.arc(i).y;
        R=tunnel.arc(i).r;
        size=length(holes);
        [x,y,perTheta] = calCircleHolesLocation( theta1,theta2, X, Y, R, holeDis );
        [ arcHoles ] = addCircleHoles( size,x,y,holesR,holesDepth,perTheta,theta1,inclineAngle );
        holes = coverHole(holes, arcHoles);
    end
end
%% ��ֱ���ϵĿ�
if ~isempty(tunnel.line)
    line=tunnel.line;
    for i=1:length(line)
        x1=line(i).x1;
        y1=line(i).y1;
        x2=line(i).x2;
        y2=line(i).y2;
        sizeHoles=length(holes);
        [ x,y ] = calLineHolesLocation(x1,y1,x2,y2,holeDis );
        [ lineHoles ] = addLineHoles( sizeHoles,x,y,holesR,holesDepth,inclineAngle );
        holes=coverHole(holes,lineHoles);
    end
end
% ������������ϵĿ�
for i=1:length(holes)
    drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );
end
end

