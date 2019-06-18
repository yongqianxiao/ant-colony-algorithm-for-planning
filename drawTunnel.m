%% 此函数用来绘制非标准隧道断面轮廓
function drawTunnel( tunnel,color)
% r=5;
% theta=-45:0.01:45;
% theta=theta*pi/180;
% x=3+r*cos(theta);
% y=3+r*sin(theta);
% plot(x,y,'r');
% axis([-9 9 -9 9]);
% 清屏

% 如果arcflag=0 且 lineflag=0，则说明没有有效的圆弧或线段，则直接返回
arcflag=0;
lineflag=0;
% ---------------
h=get(gca,'children');
delete(h);
% 绘制坐标轴
plot([-100,100],[0,0],'k--');
hold on;
plot([0 0],[-100,100],'k--');

% 设置合理的axis
% 将圆弧和直线的首尾点放入数组中
if isfield(tunnel,'arc')
    if isempty(tunnel.arc)
        r=0;
    else
        r=zeros(length(tunnel.arc),1);
        arcflag=1;
    end
else
    tunnel.arc=[];
end
arc=tunnel.arc;
% if isfield(tunnel,'arc')
%     if ~isempty(tunnel.arc)
%         if isempty(tunnel.arc(1).x)
%             arc=[];
%             r=0;
%         else
%             arcflag=1;
%             arc = tunnel.arc;
%             r=zeros(length(arc),1);
%         end
%     else
%         arc=[];
%         r=0;
%     end
% else
%     arcflag=0;
%     arc=[];
% end
if isfield(tunnel,'line')
    if ~isempty(tunnel.line)
        lineflag=1;
    end
else
    tunnel.line=[];
end
line=tunnel.line;
% if isfield(tunnel,'line')
%     if ~isempty(tunnel.line)
%         if isempty(tunnel.line(1).x1)
%             line=[];
%         else
%             lineflag=1;
%             line = tunnel.line;
%         end
%     else
%         line=[];
%     end
% else
%     line=[];
% end
if arcflag==0 && lineflag==0
    return;
end
arcPoint=zeros(length(arc)*2,2);
linePoint=zeros(length(line)*2,2);

if ~isempty(arc)
    for i=1:length(arc)
        arcPoint(2*i-1,1)=arc(i).x + arc(i).r * cos(arc(i).theta1);
        arcPoint(2*i-1,2)=arc(i).y + arc(i).r * sin(arc(i).theta1);
        arcPoint(2*i,1)=arc(i).x + arc(i).r * cos(arc(i).theta2);
        arcPoint(2*i,2)=arc(i).y + arc(i).r * sin(arc(i).theta2);
        r(i)=arc(i).r;
    end
end
if ~isempty(line)
    for i=1:length(line)
        linePoint(2*i-1,1)=line(i).x1;
        linePoint(2*i-1,2)=line(i).y1;
        linePoint(2*i,1)=line(i).x2;
        linePoint(2*i,2)=line(i).y2;
    end
end
point=[arcPoint;linePoint];
axis([min(point(:,1))-2, max(point(:,1))+2, min(point(:,2))-1, max(point(:,2))+max(r)+1]);

% 圆弧参数
if ~isempty(arc)
    for i=1:length(arc)
        xcen=arc(i).x;
        ycen=arc(i).y;
        r=arc(i).r;
        theta1=arc(i).theta1;
        theta2=arc(i).theta2;
        theta=theta1:0.01:theta2;
        % 画圆弧
        x=xcen+r*cos(theta);
        y=ycen+r*sin(theta);
%         plot(handles.axes1,x,y,color);
        plot(x,y,color);
    end
end

% 直线参数
if ~isempty(line)
    for i=1:length(line)
        x1=line(i).x1;
        y1=line(i).y1;
        x2=line(i).x2;
        y2=line(i).y2;
        % 画直线
%         plot(handles.axes1,[x1 x2],[y1 y2],color);      
        plot([x1 x2],[y1 y2],color);  
    end
end
end

