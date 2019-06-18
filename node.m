%% 1、已知：平面上的四个点 X1，Y1，X2，Y2
%  其中，X1与Y1确定一条直线，X2与Y2确定一条直线
% 2、任务：求解X1与Y1确定的直线，X2与Y2确定的直线的交点
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
% 判断两直线交点是否在两线段上

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
