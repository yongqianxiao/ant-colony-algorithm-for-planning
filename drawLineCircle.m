%% �˺���ʵ�ֻ��������ֱ�߶��Ͽ׵Ĺ���
% x --- Բ�ĺ�����
% y --- Բ��������
% r --- ��Ҫ����Բ��Բ�뾶
% axes --- ��Ҫ��Բ������ϵ
% color --- Բ����ɫ��Ϣ
% inclineAngle --- �׵�̽����

function [ x,y ] = drawLineCircle(  x, y, r , inclineAngle, axes, color )
    size=length(x);
    % ֱ��б�ʽ�
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

