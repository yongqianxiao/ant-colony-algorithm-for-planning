%% ��·���
% R --- Բ�뾶
% a --- ���ĸ߶�
% l --- �����λ���¸߶�
% r --- �Ҳ���λ���¸߶�

function roadTunnel(R,a,l,r,axisValue)
% �� 0 - 180��
theta=0:0.01*pi:pi;
x=R*cos(theta);
y=sqrt(R^2-x.^2)+a;
plot(x,y,'r');
hold on;
% ����������
plot([-100,100],[0,0],'k--');
plot([0 0],[-100,100],'k--');
% axis([-R-2 R+2 -l-r-1 R+a+2]);
axis(axisValue);

% �������ұ߲���
rTheta=asin((a+r)/R);
temp1=0:0.01*pi:rTheta;
temp1=[temp1 rTheta];
xr=R*cos(temp1);
yr=-sqrt(R^2-xr.^2)+a;
plot(xr,yr,'r');
% ��������߲���
lTheta=asin((a+l)/R);
temp2=pi-lTheta:0.01*pi:pi;
temp2=[temp2 pi];
xl=R*cos(temp2);
yl=-sqrt(R^2-xl.^2)+a;
plot(xl,yl,'r');
plot([-R*cos(lTheta), R*cos(rTheta)],[(-l), -r],'r');
end

