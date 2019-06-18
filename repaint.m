% 重绘隧道断面上的隧道轮廓和孔
function repaint(tunnel, handles, holes, axisValue)
h=get(handles.axes1,'children');
delete(h);
type=tunnel.type;
if type~=250
    R=tunnel.size.R;
    t=tunnel.size.t;
    a=tunnel.size.a;
    l=tunnel.size.l;
    r=tunnel.size.r;
    % 重绘隧道轮廓
    switch type
        case 1
            waterTunnel( R, t, a, l, r,axisValue );
        case 2
            roadTunnel(R,a,l,r,axisValue);
        case 3
            horseshoeTunnel( R,a,l,r,axisValue );
    end
else
    drawTunnel(tunnel,'r');
    axis(axisValue);
    set(handles.pb_Tunnel,'visible','off');
end
% 重绘隧道断面上的孔
for i=1:length(holes)
    drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );
end
% 检查是否需要绘制孔号
isChecked=get(handles.holeNum,'Checked');
if strcmpi(isChecked,'on')
    paintHoleNum( holes );
end

end

