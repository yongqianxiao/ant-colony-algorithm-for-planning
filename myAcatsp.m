function [ Shortest_Route,Shortest_Length ,Length_best,Length_ave] = myAcatsp( C,iter_max,m,alpha,beta,rho,Q,color, type,isSimulate ,startX,startY)
%%  ACATSP.m
%%  Ant Colony Algorithm for Traveling Salesman Problem
%%-------------------------------------------------------------------------
%%  ��Ҫ����˵��
%%  C        n�����е����꣬n��2�ľ���
%%  iter_max   ����������
%%  m        ���ϸ���
%%  alpha    ������Ϣ����Ҫ�̶ȵĲ���
%%  beta     ��������ʽ������Ҫ�̶ȵĲ���
%%  rho      ��Ϣ������ϵ��
%%  Q        ��Ϣ������ǿ��ϵ��
%%  Eta=1./D     ��������
%%  Route_best   ���·��
%%  Length_best   ���·�ߵĳ���
%%  Route_itbest  �������·��
%%  Length_itbest ������ѳ���
%%  Length_ave    ����ƽ��·�ߵĳ���
%%  Shortest_Route     �����·
%%  Shortest_Length    ��̳���
%%  type          ��ʾ������ 1����ۿ� 2���м�ۿ� 3���ұۿ�
%%  xKuoHole      ���׵ĺ�����
%%  yKuoHole      ���׵�������
%%  isSimulate    Ŀǰ�Ƿ�Ϊ����ģʽ
%%  startX/startY --- �м�ۿ���滮���յ㣬������۵���ʼ��Ϊ�����м���յ�����ĵ�
%%                �ұ۵���ʼ��Ϊ���м����ʼ������ĵ�
%%=========================================================================
tic
%% ����׼��໥����
n=size(C,1);
D=zeros(n,n);
for i=1:n
    for j=1:n
       if(i~=j)
            D(i,j)=sqrt(sum((C(i,:)-C(j,:)).^2)); %�׼�ľ���
       else
            D(i,j)=1e-4; %ͬһ�����ľ���ӦΪ�㣬Ϊ������㣬ȡһ��ԼΪ0����
       end
    end
    
end

% ����������Χ�ĵ㣬������Ĵ�С����
% initTable --- �Ը�����Ϊ���ģ��������㰴�����С�������б�
initTable=zeros(n,n);
for i=1:n
    % ���жԽ����ϵľ���Ϊ0��Ϊ������ľ���
    [~, index]=sort(D(i,:));
    initTable(i,:)=index;
end

%% ��ʼ������
Eta=1./D;               % ��������
Tau=ones(n,n);          % ��Ϣ�ؾ���
Table=zeros(m,n);       % ·����¼��
iter =1;                % ����������ֵ
Route_best= zeros(iter_max,1);      % ���·��
Length_best=zeros(iter_max,1);      % �������·���ĳ���
Length_ave= zeros(iter_max,1);      % ����·����ƽ������
Route_itbest=zeros(iter_max,n);     % ����·�������·��

%     start = ones(1,m);
%     % ���ݴ������Ŀ׶������ϵ���ʼλ��
%     holeNum = 1:n;
%     holeAngle = atan(C(:,2)./C(:,1));
%     tempC = [C holeNum' floor(C(:,1)) holeAngle];
%     if type ==1 % ������������۵Ŀף������½ǿ�ʼ���
%         A = sortrows(tempC, [-4 2]);
%         start = start .* A(1,3);
%     elseif type == 2
%         A = sortrows(tempC, [2 -1]);
%         start = start .* A(1,3);
%     elseif type == 3
% %         A = sortrows(tempC, [2 1]);       
% %         start = start .* A(1,3);
%         % ��40-45���Ͼ�ԭ������ĵ�Ϊ��ʼ��
%         proRows = tempC(:,5)>40*pi/180 & tempC(:,5)<50*pi/180;
%         A = sortrows(tempC(proRows,:),4);
%         start = start .* A(1,3);
%     end
start = ones(1,m);
holeNum = 1:n;
startX = ones(n,1)*startX;
startY = ones(n,1)*startY;
dis = (C(:,1)-startX).^2 + (C(:,2)-startY).^2;
tempC = [C holeNum' dis];
if type == 2
    A = sortrows(tempC, [-2 1]);
elseif type == 1
    A = sortrows(tempC, [2 -1]);
elseif type == 3
    A = sortrows(tempC, [-2 1]);
end
start = start .* A(1,3);
%% ����Ѱ�����·��
% H=C';
while iter<=iter_max
%     %��������������ϵ�����λ
%     Randpos=randperm(n);
%     start=Randpos(1:m)';
    
    Table(:,1)=start;               % �˴ε���·�������
%     holes_index = 1:n;              % �׵����
    % �������·��ѡ��
    for i=1:m
       % �����λ·��ѡ�� ���г�ʼλ��
       for j=2:n
           tabu = Table(i,1:(j-1));     % �ѷ��ʵĿ׼��ϣ����ɱ�
           % ismember(x,y)����һ����xͬ�׾���x��Ԫ����y�����ҵ�����1�����򷵻�0
           allow_index= ~ismember(initTable(tabu(end),:),tabu);    
           temp=initTable(tabu(end),:);
           allow = temp(allow_index);    % �����ʵĿ�λ����
               
%            �ٴ�allow��ȡǰn/4���㣬��ȡ��ǰ�������n/4����-------------
           if length(allow)>n/4
%                 if rand<rand
                if rand<0.9
                    allow=allow(1:ceil(n/4));
                end
           end
% ------------------------------------
           P = allow;
           % �����λ��ת�Ƹ���(�����ִ��Ŀ�λ����������λ��ת�Ƹ���)
           for k=1:length(allow)
               P(k)=Tau(tabu(end),allow(k))^alpha * Eta(tabu(end),allow(k))^beta;
           end
           P=P/sum(P);  
           % ʹ����Ԫ�غ�Ϊ1
           % ���̶��㷨ѡ����һ�����ʳ���
           % �ڶ���Ԫ����Ϊ��Ԫ����ǰһ��Ԫ�صĺͣ�ʹ��Pc�����һ��Ԫ��Ϊ1
           %��˿�ʹ���̶�һ����ѡ��һ����λ
           Pc = cumsum(P);          
           % ���ش���rand�������������Ԫ���±�����
           target_index=find(Pc >=rand);
           target =  allow(target_index(1)); 
           Table(i,j) = target;
       end
    end
    % һ�ε����󣬼���������ϵ�·������
    Length = zeros(m,1);
    for i=1:m
        Route = Table(i,:);
        for j=1:(n-1)
            Length(i)=Length(i)+D(Route(j),Route(j+1));
        end
    end
    % ����һ�ε���������·�����뼰ƽ������
    if iter == 1    % ��һ�ε���ֻ��һ�����ݣ��޷��Ƚ�
        % min�������ؾ�����Сֵ����һ����Сֵ���±�
        [min_Length,min_index]=min(Length);
        Length_best(iter)=min_Length;
        bestLength = min_Length;
        Length_ave(iter)=mean(Length);
        Route_best=Table(min_index,:);
        Route_itbest(iter,:)=Table(min_index,:);        
    else
        [min_Length,min_index]=min(Length);    
%         Length_best(iter)=min_Length;
        bestLength=min(bestLength,min_Length);
        Route_itbest(iter,:)=Table(min_index,:);        
        if bestLength == min_Length
            Route_best = Table(min_index,:);
            % ����һ����ɺ�ȥ������·�����ཻ��·��-----------------
            [changeRoute,bestLength]=deleteNode(Route_best, C,D);
            Route_best=changeRoute;
            Table(min_index,:)=changeRoute;
            Length(min_index)=bestLength;
            Length_best(iter)=bestLength;
            %----------------
%         else
%             Route_best(iter,:)=Route_best((iter - 1),:);
        end      
        Length_best(iter)=bestLength;
        Length_ave(iter)= mean(Length);
    end
    % ������Ϣ��
    Delta_Tau = zeros(n,n);
    % ������ϼ���
    for i=1:m
        % �����λ����
        for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
        end
        Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
    end
    Tau=(1-rho)*Tau + Delta_Tau;
    % ����������1�����·����¼��
    iter = iter +1;
    Table =zeros(m,n);
end
% [Route_best,Shortest_Length]=deleteNode(Route_best, C, D);
%% �����ʾ
[Shortest_Length,shortest_index]=min(Length_best);
Shortest_Route=Route_best;
disp(['��̾��룺' num2str(Shortest_Length)]);
disp(['���·����' num2str(Shortest_Route)]);
%% ��ͼ
% if isSimulate
%     figure;
% end
plot(C(Shortest_Route,1),C(Shortest_Route,2),color);
% for i=1:n
%     text(C(i,1),C(i,2),num2str(i));
% end
    % ��ע�Ͽ���
    % for i = 1:size(C,1)
    %     text(C(i,1),C(i,2),['   ' num2str(i)]);
    % end
text(C(Shortest_Route(1),1),C(Shortest_Route(1),2),'���');
text(C(Shortest_Route(end),1),C(Shortest_Route(end),2),' �յ�');
toc
% if isSimulate
%     xlabel('��λ������/m');
%     ylabel('��λ������/m');
%     title(['��̾��룺' num2str(Shortest_Length) ]);
%     % axis off
%     %% ��̾����ƽ�������
%     figure;
%     % subplot(1,2,2)
%     plot(1:iter_max,Length_best,'--k',1:iter_max,Length_ave,'k:');
%     legend('��̾���','ƽ������');
%     xlabel('��������');
%     ylabel('����L/m');
%     % title('������̾�����ƽ������Ա�');
% end

end