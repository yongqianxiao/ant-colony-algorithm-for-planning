%% 此函数用于根据层距获取自定义轮廓的内层轮廓
% tunnel --- 结构体数组：隧道类型、隧道所有尺寸
% holeDis --- 孔距
% floorDis --- 层距
% axes --- 布孔绘图的坐标轴
% holesR --- 孔径
% inclineAngle --- 探出角
% depth --- 孔深
% sequence --- 组成隧道轮廓的圆弧或直线的顺序

function  tempTunnel=insideProfile( tunnel,sequence,floorDis )
if ~isempty(tunnel.arc)
    arc=tunnel.arc;
else
    arc=[];
end
if ~isempty(tunnel.line)
    line=tunnel.line;
else
    line=[];
end
% 坐标矩阵
% arcPoint 用来存放变换后的圆弧端点坐标
arcPoint=zeros(length(arc)*2,2);
% linePoint 用来存放未变换轮廓直线的端点坐标
linePoint=zeros(length(line)*2,2);
% tempPoint 用来存放所有变换后的点坐标
tempPoint=zeros(length(sequence),2);
% 
%--------布孔后的圆弧只需要更改半径就可，其余不变
% 将圆弧和直线的首尾点放入数组中
if ~isempty(arc)
    % tempArc用来存放变换后的圆弧（结构数组）
    tempArc=arc;
    for i=1:length(arc)
        arcPoint(2*i-1,1)=arc(i).x + (arc(i).r-floorDis) * cos(arc(i).theta1);
        arcPoint(2*i-1,2)=arc(i).y +(arc(i).r-floorDis) * sin(arc(i).theta1);
        arcPoint(2*i,1)=arc(i).x + (arc(i).r-floorDis) * cos(arc(i).theta2);
        arcPoint(2*i,2)=arc(i).y + (arc(i).r-floorDis) * sin(arc(i).theta2);
        tempArc(i).r=arc(i).r-floorDis;
    end
end
if ~isempty(line)
    % tempLine用来存放变换后的直线段（结构数组）
    tempLine=line;
    for i=1:length(line)
        linePoint(2*i-1,1)=line(i).x1;
        linePoint(2*i-1,2)=line(i).y1;
        linePoint(2*i,1)=line(i).x2;
        linePoint(2*i,2)=line(i).y2;
    end
end
num=1;
% point中的圆弧的半径是已经经过变换的，而直线的是未经过变换的
point=[arcPoint;linePoint];

% -----------------
if ~isempty(arc)
    for i=1:length(sequence)/2
        if(sequence(2*i-1)>length(arc)*2)
        %如果当前的是直线段
            tempPoint(2*i-1,1)=tempPoint(2*i-2,1);
            tempPoint(2*i-1,2)=tempPoint(2*i-2,2);
            if i~=length(sequence)/2
                % 不是最后一段，且当前直线段连接的下一段也是直线段
                if sequence(2*i+1)>length(arc)*2
                    [x,y]=solveEquation(point(sequence(2*i-1),1),point(sequence(2*i-1),2),...
                        point(sequence(2*i),1),point(sequence(2*i),2),...
                        tempPoint(2*i-1,1),tempPoint(2*i-1,2),...
                        point(sequence(2*i+2),1),point(sequence(2*i+2),2),...
                        point(sequence(2*i+1),1),point(sequence(2*i+1),2),...
                        point(sequence(2*i),1),point(sequence(2*i),2));
                    tempPoint(2*i,1)=x;
                    tempPoint(2*i,2)=y;
                else
                    % 下一段接的是圆弧
                    tempPoint(2*i,1)=arcPoint(sequence(2*i+1),1);
                    tempPoint(2*i,2)=arcPoint(sequence(2*i+1),2);
                end
            else
                % 当前是最后一个直线段
                tempPoint(2*i,1)=tempPoint(1,1);
                tempPoint(2*i,2)=tempPoint(1,2);
            end
            % 将变换后的直线坐标存放到tempLine结构数组中
            tempLine(num).x1=tempPoint(2*i-1,1);
            tempLine(num).y1=tempPoint(2*i-1,2);
            tempLine(num).x2=tempPoint(2*i,1);
            tempLine(num).y2=tempPoint(2*i,2);
            line(sequence(2*i)/2-length(arc)).x1=tempPoint(2*i-1,1);
            line(sequence(2*i)/2-length(arc)).y1=tempPoint(2*i-1,2);
            line(sequence(2*i)/2-length(arc)).x2=tempPoint(2*i,1);
            line(sequence(2*i)/2-length(arc)).y2=tempPoint(2*i,2);
            num=num+1;
        else
            tempPoint(2*i-1,1)=arcPoint(sequence(2*i-1),1);
            tempPoint(2*i-1,2)=arcPoint(sequence(2*i-1),2);
            tempPoint(2*i,1)=arcPoint(sequence(2*i),1);
            tempPoint(2*i,2)=arcPoint(sequence(2*i),2);
        end
    end
end
%% 判断变换后的直线段中，是否有非邻线段相交，若有相交线段，则删除两相交线段在sequence中中间的的线段
% 例如sequence=[1 2 3 4 5 6 11 12 7 8 9 10]其中1 2为圆弧的两端点
% 若5 6构成的线段与9 10构成的线段在变换后相交了，则去掉中间的11 12 7 8
temp=[0 0];
% needDelete 用于存放需要删除的线段或圆弧的区间
needDelete=[];
if length(tempLine)>1 && length(sequence)/2>3
    for i=1:length(sequence)/2-2
        if(sequence(2*i-1)>length(arc)*2)
        % 说明两端点构成的线段而不是圆弧
            X1=[tempPoint(2*i-1,1),tempPoint(2*i-1,2)];
            Y1=[tempPoint(2*i,1),tempPoint(2*i,2)];
            for j=i+2:length(sequence)/2
            % 从当前线段的下下段开始判断，如果是线段再判断变换后的线段是否相交
                if sequence(2*j-1)>length(arc)*2
                % 说明此段为线段
                    X2=[tempPoint(2*j-1,1),tempPoint(2*j-1,2)];
                    Y2=[tempPoint(2*j,1),tempPoint(2*j,2)];
                    [X,Y,isIntersect] = node(X1, Y1, X2, Y2 );
                    if isIntersect
                    % 说明变换后的两线段相交
                        line(sequence(2*i)/2-length(arc)).x2=X;
                        line(sequence(2*i)/2-length(arc)).y2=Y;
                        line(sequence(2*j)/2-length(arc)).x1=X;
                        line(sequence(2*j)/2-length(arc)).y1=Y;
                        temp=[i j];
                        needDelete=[temp;needDelete];
                    end                    
                end
            end
        end
    end
end
% 将变换后相交的线段之间的线段或圆弧的所有参数设为0
% 不直接删除的原因是：如果直接删除，则所删的数据后面的数据会前移，数据结构会破坏
if size(needDelete,1)>0
    for i=1:size(needDelete,1)
        temp=needDelete(i,:);
        line1=temp(1);
        line2=temp(2);
        for j=line1+1:line2-1
            if sequence(2*j-1)>length(arc)*2
                line(sequence(2*j)/2-length(arc)).x1=0;
                line(sequence(2*j)/2-length(arc)).y1=0;
                line(sequence(2*j)/2-length(arc)).x2=0;
                line(sequence(2*j)/2-length(arc)).y2=0;
            else
                tempArc(sequence(2*j)/2).x=0;
                tempArc(sequence(2*j)/2).y=0;
                tempArc(sequence(2*j)/2).r=0;
                tempArc(sequence(2*j)/2).theta1=0;
                tempArc(sequence(2*j)/2).theta2=0;
            end
        end
    end
end
% 判断数据，如果某个线段或圆弧的数据全为0，则删除之=====从后往前删====
lengthLine=length(line);
lengthArc=length(tempArc);
for i=1:lengthLine
    if line(lengthLine+1-i).x1==0 && line(lengthLine+1-i).y1==0 && ...
            line(lengthLine+1-i).x2==0 && line(lengthLine+1-i).y2==0
        line(lengthLine+1-i)=[];
    end
end
for i=1:lengthArc
    if tempArc(lengthArc+1-i).x==0 && tempArc(lengthArc+1-i).y==0 && tempArc(lengthArc+1-i).r==0 ...
            && tempArc(lengthArc+1-i).theta1==0 && tempArc(lengthArc+1-i).theta2==0
        tempArc(lengthArc+1-i)=[];
    end
end
% --------------------
tempTunnel.type=250;
tempTunnel.arc=tempArc;
tempTunnel.line=line;
% figure;
% drawTunnel(tunnel,'g');
% figure;
% drawTunnel(tempTunnel,'r');
end

