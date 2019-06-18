%% 此函数根据相交的路径计算相应交点的禁忌点
% cTabu --- 各点的禁忌表
% C --- 各点的坐标(n x 2)矩阵
% D --- 各点的距离矩阵
% table --- 为m只蚂蚁对n个点进行规划后的路径表
function [ cTabu ] = calCityTab( cTabu, C, D, table )
% m --- 蚂蚁数量
% n --- 城市数量
    m=size(table,1);
    n=size(table,2);
%     cTabu=zeros(n,n);
    for i=1:m
        for j=1:n-2
            X1=C(table(i,j),:);
            Y1=C(table(i,j+1),:);
            for k=j+2:n-1
                X2=C(table(i,k),:);
                Y2=C(table(i,k+1),:);
                [~,~,isIntersect]= node( X1,Y1,X2,Y2 );
                if isIntersect
                    % 如果规划下的非相邻的两直线相交，则将线段较长的两点相互加入其禁忌表中
                    if D(table(i,j),table(i,j+1)) > D(table(i,k),table(i,k+1))
                        % 如果cTabu对应的行中有table(i,j)数值，则返回1，否则返回0
                        if ~any(cTabu(table(i,j),:) == table(i,j+1))
                            index_1=find(cTabu(table(i,j),:)==0);                            
                            cTabu(table(i,j),index_1(1))=table(i,j+1);                            
                        end     
                        if ~any(cTabu(table(i,j+1),:) == table(i,j))
                            index_2=find(cTabu(table(i,j+1),:)==0); 
                            cTabu(table(i,j+1),index_2(1))=table(i,j);
                        end
                    else
                        if ~any(cTabu(table(i,k),:) == table(i,k+1))
                            index_1=find(cTabu(table(i,k),:)==0);                             
                            cTabu(table(i,k),index_1(1))=table(i,k+1);                            
                        end
                        if ~any(cTabu(table(i,k+1),:) == table(i,k))
                            index_2=find(cTabu(table(i,k+1),:)==0);
                            cTabu(table(i,k+1),index_2(1))=table(i,k);
                        end
                    end
                end
            end
        end
    end
end

