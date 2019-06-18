%% 此函数用来判断鼠标是否有选中隧道轮廓
% x.y --- 鼠标点击的坐标
% tunnel --- 当前自定义隧道轮廓结构数组
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
        % 如果当前隧道轮廓的线段为垂直线段
            if x>x1-0.1 && x<x1+0.1 && y>min([y1,y2]) && y<max([y1,y2]) && ~isDrag
                % 则说明选中该线段
                chosenLine=line(i);
                isChosen=true;
                return;
            elseif x1>min([x,xx]) && x1<max([x,xx]) && y1>min([y,yy]) && y1<max([y,yy]) ...
                    && y2>min([y,yy]) && y2<max([y,yy]) && isDrag
                % 则说明该线段在选框内
                if isempty(chosenLine)
                    chosenLine=line(i);
                else
                    chosenLine(length(chosenLine)+1)=line(i);
                end
                isChosen=true;
            end
        else
        % 如果当前隧道轮廓的线段不是垂直的
            b=y1-k*x1;
            if x>x1 && x<x2 && y>k*x+b-0.1 && y<k*x+b+0.1 && ~isDrag
                % 则说明点击选中该线段
                chosenLine=line(i);
                isChosen=true;
                return;
            elseif x1>min([x,xx]) && x1<max([x,xx]) && y1>min([y,yy]) && y1<max([y,yy]) && ...
                    x2>min([x,xx]) && x2<max([x,xx]) && y2>min([y,yy]) && y2<max([y,yy]) && isDrag
                % 则说明整个线段都在拉框内，线段被选中
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
% x1,y1 --- 圆弧圆心坐标
% xth1,xth2 --- 圆弧在坐标系中的x轴方向的范围
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
            % 如果y>y1,即鼠标点击的点在圆弧圆心以上,则theta在0~180之间
            if theta<0
                theta=theta+pi;
            elseif theta>pi
                theta=theta-pi;
            end
        elseif y<y1
            % 如果y<y2,即鼠标点击的点在圆弧圆心以下，则theta在180~360之初是，或者在-180~0
            if theta>0 && theta<pi
                theta=theta-pi;
            elseif theta<-pi
                theta = theta+pi;
            end
        end
        if theta>min([theta1,theta2]) && theta<max([theta1 theta2]) && d>r-0.1 && d<r+0.1 && ~isDrag
            % 说明单击选中了当前圆弧
            chosenArc=arc(i);
            isChosen=true;
            return;
        elseif isDrag
            % 说明是拉选框
            % 将圆弧每隔0.01弧度取出一个点，如果这些点组成的数组中所有的点都在选框内，则说明选中
            thetatemp=(theta1:0.01:theta2);
            xtemp=x1+r*cos(thetatemp);
            ytemp=y1+r*sin(thetatemp);
            xpoint=find(xtemp<min([x,xx]) | xtemp>max([x,xx]), 1);
            ypoint=find(ytemp<min([y,yy]) | ytemp>max([y,yy]), 1);
            if isempty(xpoint) && isempty(ypoint)
            % 说明当前圆弧都在选框中，选中了当前圆弧
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

