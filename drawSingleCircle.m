%% ������ӿ�ʱ����
% x,y --- �׵�x,y����
% r --- �׵Ŀ׾�
% biasAngle --- �׵�ƫ��
% inclineAngle --- �׵�̽����
% axes --- ��Ҫaxes����ϵ�ϻ���
% color --- �׵���ɫ
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

