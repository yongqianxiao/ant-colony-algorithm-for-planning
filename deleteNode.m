%% �ú��������ж�·�����Ƿ��з��ڵ��ཻ�߶Σ���ʱ��һ·���Ķ˵���Ϊ��һ�ཻ·������һ��λ����������˵�Ҳ��Ϊ���ڿ�λ
% Route --- Ϊ·��
% C --- ��λ����(n x 2)
% D --- ����֮��ľ������

% function [ Route , bestLength] = deleteNode( Route, C, bestLength��D)
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
                % ��X1��Y2��������X1/Y2��֮������п�λ����
                tempRoute=[tempRoute(1:i),flip(tempRoute(i+1:j)),tempRoute(j+1:end)];
%                 temp=tempRoute(i+1);
%                 tempRoute(i+1)=tempRoute(j);
%                 tempRoute(j)=temp;     
%                 changeLength=0;
%                 for k=1:n-1
%                     % ������ĺ��·������
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
        % ������ĺ��·������
        Length=Length + D(tempRoute(k),tempRoute(k+1));
    end
end

