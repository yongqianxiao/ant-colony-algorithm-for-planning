function [ Shortest_Route,Shortest_Length ,Length_best,Length_ave] = myAcatsp( C,iter_max,m,alpha,beta,rho,Q,color, type,isSimulate ,startX,startY)
%%  ACATSP.m
%%  Ant Colony Algorithm for Traveling Salesman Problem
%%-------------------------------------------------------------------------
%%  主要符号说明
%%  C        n个城市的坐标，n×2的矩阵
%%  iter_max   最大迭代次数
%%  m        蚂蚁个数
%%  alpha    表征信息素重要程度的参数
%%  beta     表征启发式因子重要程度的参数
%%  rho      信息素蒸发系数
%%  Q        信息素增加强度系数
%%  Eta=1./D     启发函数
%%  Route_best   最佳路线
%%  Length_best   最佳路线的长度
%%  Route_itbest  各代最佳路线
%%  Length_itbest 各代最佳长度
%%  Length_ave    各代平均路线的长度
%%  Shortest_Route     最短线路
%%  Shortest_Length    最短长度
%%  type          表示孔类型 1：左臂孔 2：中间臂孔 3：右臂孔
%%  xKuoHole      扩孔的横坐标
%%  yKuoHole      扩孔的纵坐标
%%  isSimulate    目前是否为仿真模式
%%  startX/startY --- 中间臂孔序规划的终点，设置左臂的起始点为距离中间臂终点最近的点
%%                右臂的起始点为距中间臂起始点最近的点
%%=========================================================================
tic
%% 计算孔间相互距离
n=size(C,1);
D=zeros(n,n);
for i=1:n
    for j=1:n
       if(i~=j)
            D(i,j)=sqrt(sum((C(i,:)-C(j,:)).^2)); %孔间的距离
       else
            D(i,j)=1e-4; %同一个点间的距离应为零，为方便计算，取一个约为0的数
       end
    end
    
end

% 将各个点周围的点，按距离的大小排序
% initTable --- 以各个点为中心，将其它点按距离大小排序后的列表
initTable=zeros(n,n);
for i=1:n
    % 其中对角线上的距离为0，为与自身的距离
    [~, index]=sort(D(i,:));
    initTable(i,:)=index;
end

%% 初始化参数
Eta=1./D;               % 启发函数
Tau=ones(n,n);          % 信息素矩阵
Table=zeros(m,n);       % 路径记录表
iter =1;                % 迭代次数初值
Route_best= zeros(iter_max,1);      % 最佳路径
Length_best=zeros(iter_max,1);      % 各代最佳路径的长度
Length_ave= zeros(iter_max,1);      % 各代路径的平均长度
Route_itbest=zeros(iter_max,n);     % 各代路径的最佳路径

%     start = ones(1,m);
%     % 根据传进来的孔定义蚂蚁的起始位置
%     holeNum = 1:n;
%     holeAngle = atan(C(:,2)./C(:,1));
%     tempC = [C holeNum' floor(C(:,1)) holeAngle];
%     if type ==1 % 传进来的是左臂的孔，从左下角开始钻孔
%         A = sortrows(tempC, [-4 2]);
%         start = start .* A(1,3);
%     elseif type == 2
%         A = sortrows(tempC, [2 -1]);
%         start = start .* A(1,3);
%     elseif type == 3
% %         A = sortrows(tempC, [2 1]);       
% %         start = start .* A(1,3);
%         % 从40-45度上距原点最近的点为起始点
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
%% 迭代寻找最佳路径
% H=C';
while iter<=iter_max
%     %随机产生各个蚂蚁的起点孔位
%     Randpos=randperm(n);
%     start=Randpos(1:m)';
    
    Table(:,1)=start;               % 此次迭代路径的起点
%     holes_index = 1:n;              % 孔的序号
    % 逐个蚂蚁路径选择
    for i=1:m
       % 逐个孔位路径选择 已有初始位置
       for j=2:n
           tabu = Table(i,1:(j-1));     % 已访问的孔集合（禁忌表）
           % ismember(x,y)返回一个和x同阶矩阵，x中元素在y中能找到返回1，否则返回0
           allow_index= ~ismember(initTable(tabu(end),:),tabu);    
           temp=initTable(tabu(end),:);
           allow = temp(allow_index);    % 待访问的孔位集合
               
%            再从allow中取前n/4个点，即取当前点最近的n/4个点-------------
           if length(allow)>n/4
%                 if rand<rand
                if rand<0.9
                    allow=allow(1:ceil(n/4));
                end
           end
% ------------------------------------
           P = allow;
           % 计算孔位间转移概率(蚂蚁现处的孔位到其它各孔位的转移概率)
           for k=1:length(allow)
               P(k)=Tau(tabu(end),allow(k))^alpha * Eta(tabu(end),allow(k))^beta;
           end
           P=P/sum(P);  
           % 使所有元素和为1
           % 轮盘赌算法选择下一个访问城市
           % 第二个元素起，为该元素与前一个元素的和，使得Pc中最后一个元素为1
           %如此可使轮盘赌一定能选出一个孔位
           Pc = cumsum(P);          
           % 返回大于rand产生的随机数的元素下标向量
           target_index=find(Pc >=rand);
           target =  allow(target_index(1)); 
           Table(i,j) = target;
       end
    end
    % 一次迭代后，计算各个蚂蚁的路径距离
    Length = zeros(m,1);
    for i=1:m
        Route = Table(i,:);
        for j=1:(n-1)
            Length(i)=Length(i)+D(Route(j),Route(j+1));
        end
    end
    % 计算一次迭代后的最短路径距离及平均距离
    if iter == 1    % 第一次迭代只有一组数据，无法比较
        % min函数返回矩阵最小值及第一个最小值的下标
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
            % 迭代一次完成后，去掉最优路径中相交的路径-----------------
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
    % 更新信息素
    Delta_Tau = zeros(n,n);
    % 逐个蚂蚁计算
    for i=1:m
        % 逐个孔位计算
        for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
        end
        Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
    end
    Tau=(1-rho)*Tau + Delta_Tau;
    % 迭代次数加1，清空路径记录表
    iter = iter +1;
    Table =zeros(m,n);
end
% [Route_best,Shortest_Length]=deleteNode(Route_best, C, D);
%% 结果显示
[Shortest_Length,shortest_index]=min(Length_best);
Shortest_Route=Route_best;
disp(['最短距离：' num2str(Shortest_Length)]);
disp(['最短路径：' num2str(Shortest_Route)]);
%% 绘图
% if isSimulate
%     figure;
% end
plot(C(Shortest_Route,1),C(Shortest_Route,2),color);
% for i=1:n
%     text(C(i,1),C(i,2),num2str(i));
% end
    % 标注上孔序
    % for i = 1:size(C,1)
    %     text(C(i,1),C(i,2),['   ' num2str(i)]);
    % end
text(C(Shortest_Route(1),1),C(Shortest_Route(1),2),'起点');
text(C(Shortest_Route(end),1),C(Shortest_Route(end),2),' 终点');
toc
% if isSimulate
%     xlabel('孔位横坐标/m');
%     ylabel('孔位纵坐标/m');
%     title(['最短距离：' num2str(Shortest_Length) ]);
%     % axis off
%     %% 最短距离和平均距离表
%     figure;
%     % subplot(1,2,2)
%     plot(1:iter_max,Length_best,'--k',1:iter_max,Length_ave,'k:');
%     legend('最短距离','平均距离');
%     xlabel('迭代次数');
%     ylabel('距离L/m');
%     % title('各代最短距离与平均距离对比');
% end

end