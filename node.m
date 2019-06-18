%% 1����֪��ƽ���ϵ��ĸ��� X1��Y1��X2��Y2
%  ���У�X1��Y1ȷ��һ��ֱ�ߣ�X2��Y2ȷ��һ��ֱ��
% 2���������X1��Y1ȷ����ֱ�ߣ�X2��Y2ȷ����ֱ�ߵĽ���
function [X,Y,isIntersect]= node( X1,Y1,X2,Y2 )
isIntersect=false;
if X1(1)==Y1(1)
    X=X1(1);
    k2=(Y2(2)-X2(2))/(Y2(1)-X2(1));
    b2=X2(2)-k2*X2(1); 
    Y=k2*X+b2;
end
if X2(1)==Y2(1)
    X=X2(1);
    k1=(Y1(2)-X1(2))/(Y1(1)-X1(1));
    b1=X1(2)-k1*X1(1);
    Y=k1*X+b1;
end
if X1(1)~=Y1(1) && X2(1)~=Y2(1)
    k1=(Y1(2)-X1(2))/(Y1(1)-X1(1));
    k2=(Y2(2)-X2(2))/(Y2(1)-X2(1));
    b1=X1(2)-k1*X1(1);
    b2=X2(2)-k2*X2(1);
    if k1==k2
        X=[];
        Y=[];
    else
        X=(b2-b1)/(k1-k2);
        Y=k1*X+b1;
    end
end
% plot([X1(1),Y1(1)],[X1(2),Y1(2)],'r-');
% hold on;
% plot([X2(1),Y2(1)],[X2(2),Y2(2)],'k-');
% �ж���ֱ�߽����Ƿ������߶���

if ~isempty(X) && ~isempty(Y)
    if (min(X1(1),Y1(1))<=X && X<=max(X1(1),Y1(1)) &&...
        min(X2(1),Y2(1))<=X && X<=max(X2(1),Y2(1)) &&...
        min(X1(2),Y1(2))<=Y && Y<=max(X1(2),Y1(2)) &&...
        min(X2(2),Y2(2))<=Y && Y<=max(X2(2),Y2(2)))
    %     plot(X,Y,'x');
        isIntersect=true;
    end
else
    isIntersect=false;
end
