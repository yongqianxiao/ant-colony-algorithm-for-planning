% �ػ���������ϵ���������Ϳ�
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
    % �ػ��������
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
% �ػ���������ϵĿ�
for i=1:length(holes)
    drawSingleCircle( holes(i).x,holes(i).y,holes(i).r,holes(i).biasAngle,holes(i).inclineAngle,handles.axes1,'g' );
end
% ����Ƿ���Ҫ���ƿ׺�
isChecked=get(handles.holeNum,'Checked');
if strcmpi(isChecked,'on')
    paintHoleNum( holes );
end

end

