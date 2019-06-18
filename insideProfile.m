%% �˺������ڸ��ݲ���ȡ�Զ����������ڲ�����
% tunnel --- �ṹ�����飺������͡�������гߴ�
% holeDis --- �׾�
% floorDis --- ���
% axes --- ���׻�ͼ��������
% holesR --- �׾�
% inclineAngle --- ̽����
% depth --- ����
% sequence --- ������������Բ����ֱ�ߵ�˳��

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
% �������
% arcPoint ������ű任���Բ���˵�����
arcPoint=zeros(length(arc)*2,2);
% linePoint �������δ�任����ֱ�ߵĶ˵�����
linePoint=zeros(length(line)*2,2);
% tempPoint ����������б任��ĵ�����
tempPoint=zeros(length(sequence),2);
% 
%--------���׺��Բ��ֻ��Ҫ���İ뾶�Ϳɣ����಻��
% ��Բ����ֱ�ߵ���β�����������
if ~isempty(arc)
    % tempArc������ű任���Բ�����ṹ���飩
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
    % tempLine������ű任���ֱ�߶Σ��ṹ���飩
    tempLine=line;
    for i=1:length(line)
        linePoint(2*i-1,1)=line(i).x1;
        linePoint(2*i-1,2)=line(i).y1;
        linePoint(2*i,1)=line(i).x2;
        linePoint(2*i,2)=line(i).y2;
    end
end
num=1;
% point�е�Բ���İ뾶���Ѿ������任�ģ���ֱ�ߵ���δ�����任��
point=[arcPoint;linePoint];

% -----------------
if ~isempty(arc)
    for i=1:length(sequence)/2
        if(sequence(2*i-1)>length(arc)*2)
        %�����ǰ����ֱ�߶�
            tempPoint(2*i-1,1)=tempPoint(2*i-2,1);
            tempPoint(2*i-1,2)=tempPoint(2*i-2,2);
            if i~=length(sequence)/2
                % �������һ�Σ��ҵ�ǰֱ�߶����ӵ���һ��Ҳ��ֱ�߶�
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
                    % ��һ�νӵ���Բ��
                    tempPoint(2*i,1)=arcPoint(sequence(2*i+1),1);
                    tempPoint(2*i,2)=arcPoint(sequence(2*i+1),2);
                end
            else
                % ��ǰ�����һ��ֱ�߶�
                tempPoint(2*i,1)=tempPoint(1,1);
                tempPoint(2*i,2)=tempPoint(1,2);
            end
            % ���任���ֱ�������ŵ�tempLine�ṹ������
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
%% �жϱ任���ֱ�߶��У��Ƿ��з����߶��ཻ�������ཻ�߶Σ���ɾ�����ཻ�߶���sequence���м�ĵ��߶�
% ����sequence=[1 2 3 4 5 6 11 12 7 8 9 10]����1 2ΪԲ�������˵�
% ��5 6���ɵ��߶���9 10���ɵ��߶��ڱ任���ཻ�ˣ���ȥ���м��11 12 7 8
temp=[0 0];
% needDelete ���ڴ����Ҫɾ�����߶λ�Բ��������
needDelete=[];
if length(tempLine)>1 && length(sequence)/2>3
    for i=1:length(sequence)/2-2
        if(sequence(2*i-1)>length(arc)*2)
        % ˵�����˵㹹�ɵ��߶ζ�����Բ��
            X1=[tempPoint(2*i-1,1),tempPoint(2*i-1,2)];
            Y1=[tempPoint(2*i,1),tempPoint(2*i,2)];
            for j=i+2:length(sequence)/2
            % �ӵ�ǰ�߶ε����¶ο�ʼ�жϣ�������߶����жϱ任����߶��Ƿ��ཻ
                if sequence(2*j-1)>length(arc)*2
                % ˵���˶�Ϊ�߶�
                    X2=[tempPoint(2*j-1,1),tempPoint(2*j-1,2)];
                    Y2=[tempPoint(2*j,1),tempPoint(2*j,2)];
                    [X,Y,isIntersect] = node(X1, Y1, X2, Y2 );
                    if isIntersect
                    % ˵���任������߶��ཻ
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
% ���任���ཻ���߶�֮����߶λ�Բ�������в�����Ϊ0
% ��ֱ��ɾ����ԭ���ǣ����ֱ��ɾ��������ɾ�����ݺ�������ݻ�ǰ�ƣ����ݽṹ���ƻ�
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
% �ж����ݣ����ĳ���߶λ�Բ��������ȫΪ0����ɾ��֮=====�Ӻ���ǰɾ====
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

