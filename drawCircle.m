%% �˺���ʵ�ֻ��������Բ���Ͽ׵Ĺ���
% x --- Բ�ĺ�����
% y --- Բ��������
% r --- ��Ҫ����Բ��Բ�뾶
% axes --- ��Ҫ��Բ������ϵ
% color --- Բ����ɫ��Ϣ
% inclineAngle --- �׵�̽����
% perTheta --- Բ��������֮��ļн�
% theta1 --- Բ������ʼ��
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
        % ֻ�е�̽���ǲ�Ϊ0ʱ���Ż��׵����
        if inclineAngle ~= 0
            x1=[r*cos(theta1+ perTheta*i)+x(i),(r*3)*cos(theta1+ perTheta*i)+x(i)];
            y1=[r*sin(theta1+ perTheta*i)+y(i),(r*3)*sin(theta1+ perTheta*i)+y(i)];
            plot(axes,x1,y1,color);
        end
    end

end

