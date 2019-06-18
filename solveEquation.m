%% �����x1,y1��ֱ�ߺ���ֱ�߽�ƽ���ߣ���x2,y2���Ľ���
% line1_x1 y1 --- ��һ��ֱ�ߵ�һ����
% line1_x2 y2 --- ��һ��ֱ�ߵڶ�����
% line2_x1 y1 --- �ڶ���ֱ�ߵڶ�����
% line2_x2 y2 --- �ڶ���ֱ�ߵ�һ����
% x1 y1 --- �������x1,y1��ֱ�߷���
% x2 y2 --- �������x2,y2�Ľ�ƽ���߷���
% k1 --- ��һ��ֱ��б��
% tempk2 --- �ڶ���ֱ��б��
% k2 --- ��ֱ�߼н�б��
% [x y] --- ������ֱ�߽�������
function [ x,y ] = solveEquation( line1_x1,line1_y1,line1_x2,line1_y2,x1,y1,line2_x1,line2_y1,line2_x2,line2_y2,x2,y2 )
k1=(line1_y1-line1_y2)/(line1_x1-line1_x2);
tempk2=(line2_y1-line2_y2)/(line2_x1-line2_x2);
k2=tan((atan(k1)+atan(tempk2))/2);
if ~isinf(k1) && ~isinf(k2)
    if k1==0 && line1_x1<line1_x2
        k2=-k2;
    end
    if tempk2==0 && line2_x1<line2_x2
        k2=-k2;
    end
    b1=y1-k1*x1;
    b2=y2-k2*x2;
    x=(b2-b1)/(k1-k2);
    y=k1*(b2-b1)/(k1-k2)+b1;
    return;
end
if isinf(k1)
    if tempk2==0 && line2_x1<line2_x2
        k2=-k2;
    end
    b2=y2-k2*x2;
    x=x1;
    y=k2*x+b2;
    return;
end
if isinf(tempk2)
    if k1==0 && line1_x1<line1_x2
        k2=-k2;
    end
    b1=y1-k1*x1;
    b2=y2-k2*x2;
    x=(b2-b1)/(k1-k2);
    y=k1*(b2-b1)/(k1-k2)+b1;
    return;
end
end

