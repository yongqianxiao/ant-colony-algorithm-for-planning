%% ����Բ����Ҫ��׵Ŀ�����
% theta1/theta2 --- Բ���Ǵ�theta1��theta2, ��λ����
% X��Y --- Բ��Բ�ĵĺ�������
% R --- Բ���뾶
% upHole --- Բ���Ͽ׵ļ��
% x,y --- ���ؿ׵�����
% theta --- ���ؿ׾�֮��ļн�
function [ x,y, theta ] = calCircleHolesLocation( theta1,theta2, X, Y, R, upHole )
% theta1=-pi/2;
% theta2=0;
% X=-2;
% Y=2;
% R=6;
% upHole=0.5;

% ÿ��theta�Ƕ���һ����
theta = acos((2*R^2-upHole^2)/(2*R^2));
% ����׵ĸ���
size = (theta2 - theta1) / theta;
if mod(size,(floor(size)))<0.5
    size=floor(size);
else
    size=floor(size)+1;
end
x=ones(size,1);
y=ones(size,1);
for i=1:size
    x(i)=X+R*cos(theta1+theta*(i-1));
    y(i)=Y+R*sin(theta1+theta*(i-1));
end
% plot(x,y,'ro')
% axis([-10 10 -3 9]);
% hold on;
% plot([0 0],[0 2])
end

