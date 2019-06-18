%% �˺��������ж�����Ƿ���ѡ���������
% x.y --- �����������
% tunnel --- ��ǰ�Զ�����������ṹ����
function [ isChosen, chosenLine, chosenArc ] = isChosenTunnel( x,y,isDrag,xx,yy,tunnel )
isChosen=false;
chosenLine=[];
chosenArc=[];
line=tunnel.line;
arc=tunnel.arc;
if ~isempty(line)
    for i=1:length(line)
        x1=line(i).x1;
        y1=line(i).y1;
        x2=line(i).x2;
        y2=line(i).y2;
        k=(y2-y1)/(x2-x1);
        if isinf(k)
        % �����ǰ����������߶�Ϊ��ֱ�߶�
            if x>x1-0.1 && x<x1+0.1 && y>min([y1,y2]) && y<max([y1,y2]) && ~isDrag
                % ��˵��ѡ�и��߶�
                chosenLine=line(i);
                isChosen=true;
                return;
            elseif x1>min([x,xx]) && x1<max([x,xx]) && y1>min([y,yy]) && y1<max([y,yy]) ...
                    && y2>min([y,yy]) && y2<max([y,yy]) && isDrag
                % ��˵�����߶���ѡ����
                if isempty(chosenLine)
                    chosenLine=line(i);
                else
                    chosenLine(length(chosenLine)+1)=line(i);
                end
                isChosen=true;
            end
        else
        % �����ǰ����������߶β��Ǵ�ֱ��
            b=y1-k*x1;
            if x>x1 && x<x2 && y>k*x+b-0.1 && y<k*x+b+0.1 && ~isDrag
                % ��˵�����ѡ�и��߶�
                chosenLine=line(i);
                isChosen=true;
                return;
            elseif x1>min([x,xx]) && x1<max([x,xx]) && y1>min([y,yy]) && y1<max([y,yy]) && ...
                    x2>min([x,xx]) && x2<max([x,xx]) && y2>min([y,yy]) && y2<max([y,yy]) && isDrag
                % ��˵�������߶ζ��������ڣ��߶α�ѡ��
                if isempty(chosenLine)
                    chosenLine=line(i);
                else
                    chosenLine(length(chosenLine)+1)=line(i);
                end
                isChosen=true;
            end
        end
    end
end
% x1,y1 --- Բ��Բ������
% xth1,xth2 --- Բ��������ϵ�е�x�᷽��ķ�Χ
if ~isempty(arc)
    for i=1:length(arc)
        x1=arc(i).x;
        y1=arc(i).y;
        r=arc(i).r;
        theta1=arc(i).theta1;
        theta2=arc(i).theta2;
        d=sqrt((y-y1)^2 + (x-x1)^2);
        theta=atan((y-y1)/(x-x1));
        if y>y1
            % ���y>y1,��������ĵ���Բ��Բ������,��theta��0~180֮��
            if theta<0
                theta=theta+pi;
            elseif theta>pi
                theta=theta-pi;
            end
        elseif y<y1
            % ���y<y2,��������ĵ���Բ��Բ�����£���theta��180~360֮���ǣ�������-180~0
            if theta>0 && theta<pi
                theta=theta-pi;
            elseif theta<-pi
                theta = theta+pi;
            end
        end
        if theta>min([theta1,theta2]) && theta<max([theta1 theta2]) && d>r-0.1 && d<r+0.1 && ~isDrag
            % ˵������ѡ���˵�ǰԲ��
            chosenArc=arc(i);
            isChosen=true;
            return;
        elseif isDrag
            % ˵������ѡ��
            % ��Բ��ÿ��0.01����ȡ��һ���㣬�����Щ����ɵ����������еĵ㶼��ѡ���ڣ���˵��ѡ��
            thetatemp=(theta1:0.01:theta2);
            xtemp=x1+r*cos(thetatemp);
            ytemp=y1+r*sin(thetatemp);
            xpoint=find(xtemp<min([x,xx]) | xtemp>max([x,xx]), 1);
            ypoint=find(ytemp<min([y,yy]) | ytemp>max([y,yy]), 1);
            if isempty(xpoint) && isempty(ypoint)
            % ˵����ǰԲ������ѡ���У�ѡ���˵�ǰԲ��
                if isempty(chosenArc)
                    chosenArc=arc(i);
                else
                    chosenArc(length(chosenArc)+1)=arc(i);
                end
                isChosen=true;
            end
        end
    end
end
end

