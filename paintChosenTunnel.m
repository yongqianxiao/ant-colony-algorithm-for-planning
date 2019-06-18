%% 此函数用来在绘制轮廓时，绘制选中的轮廓
function  paintChosenTunnel( temptunnel )
if isfield(temptunnel,'line')
    line=temptunnel.line;
else
    line=[];
end
if isfield(temptunnel,'arc')
    arc=temptunnel.arc;
else
    arc=[];
end
if ~isempty(line)
    for i=1:length(line)
        x1=line(i).x1;
        y1=line(i).y1;
        x2=line(i).x2;
        y2=line(i).y2;
        plot([x1,x2],[y1,y2],'k-');
    end
end

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
        plot(x,y,'k');
    end
end

end

