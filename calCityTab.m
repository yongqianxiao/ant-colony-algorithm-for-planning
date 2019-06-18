%% �˺��������ཻ��·��������Ӧ����Ľ��ɵ�
% cTabu --- ����Ľ��ɱ�
% C --- ���������(n x 2)����
% D --- ����ľ������
% table --- Ϊmֻ���϶�n������й滮���·����
function [ cTabu ] = calCityTab( cTabu, C, D, table )
% m --- ��������
% n --- ��������
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
                    % ����滮�µķ����ڵ���ֱ���ཻ�����߶νϳ��������໥��������ɱ���
                    if D(table(i,j),table(i,j+1)) > D(table(i,k),table(i,k+1))
                        % ���cTabu��Ӧ��������table(i,j)��ֵ���򷵻�1�����򷵻�0
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

