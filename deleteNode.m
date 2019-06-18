%% 该函数用来判断路径中是否有非邻的相交线段，此时将一路径的端点作为另一相交路径的下一孔位，另外的两端点也互为相邻孔位
% Route --- 为路径
% C --- 孔位坐标(n x 2)
% D --- 各孔之间的距离矩阵

% function [ Route , bestLength] = deleteNode( Route, C, bestLength，D)
function [ tempRoute, Length ] = deleteNode( Route, C,D)
Length = 0;
tempRoute=Route;
n=size(C,1);
    for i=1:n-2
        X1=C(tempRoute(i),:);
        Y1=C(tempRoute(i+1),:);
        for j=i+2:n-1
            X2=C(tempRoute(j),:);
            Y2=C(tempRoute(j+1),:);
            [~,~,isIntersect]= node( X1,Y1,X2,Y2 );
            if isIntersect
                % 将X1和Y2（不包括X1/Y2）之间的所有孔位倒序
                tempRoute=[tempRoute(1:i),flip(tempRoute(i+1:j)),tempRoute(j+1:end)];
%                 temp=tempRoute(i+1);
%                 tempRoute(i+1)=tempRoute(j);
%                 tempRoute(j)=temp;     
%                 changeLength=0;
%                 for k=1:n-1
%                     % 求出更改后的路径长度
%                     changeLength=changeLength + D(tempRoute(k),tempRoute(k+1));
%                 end
%                 if changeLength < bestLength
%                     bestLength=changeLength;
%                     Route=tempRoute;
%                 else
%                     tempRoute=Route;
%                 end 
            end
        end
    end
    for k=1:n-1
        % 求出更改后的路径长度
        Length=Length + D(tempRoute(k),tempRoute(k+1));
    end
end

